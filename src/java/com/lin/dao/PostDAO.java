/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;

import com.lin.entities.Post;
import com.lin.entities.PostLike;
import com.lin.entities.User;
import com.lin.utils.HibernateUtil;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author fayannefoo
 */
public class PostDAO {

    ArrayList<Post> postList = null;
    Session session = null;

    public PostDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public Post getPost(int postId) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Post where postId = :id");
            q.setString("id", postId + "");
            postList = (ArrayList<Post>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Post:" + postList.get(0));
        return postList.get(0);
    }

    public ArrayList<Post> retrieveAllPosts() {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Post as p join fetch p.user order by p.postId DESC");
            postList = (ArrayList<Post>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return postList;
    }
    
    public ArrayList<Post> retrievePostsWithLimit(int limit) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Post as p join fetch p.user order by p.postId DESC")
                    .setMaxResults(limit);
            
            postList = (ArrayList<Post>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return postList;
    }
    
    public ArrayList<Post> retrievePostsWithOffset(int offsetSize, int nextChunkSize) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Post as p join fetch p.user order by p.postId DESC");
            
            q.setFirstResult(offsetSize);
            q.setMaxResults(nextChunkSize);
            
            postList = (ArrayList<Post>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return postList;
    }

    public ArrayList<Post> retrievePostsByUserId(int user_id) {
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Post where postId = :id");
            q.setString("id", user_id + "");
            postList = (ArrayList<Post>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postList;
    }

    public Post addPost(Post post) {
        openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Post", post);
            session.flush();
            System.out.println("PostIDinserted: "+post.getPostId());
            
            tx.commit();
            return post;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return null;
    }

    public boolean deletePost(int postId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;

        try {
            tx = session.beginTransaction();
            String hql = "delete from Post where postId = :id";
            Query query = session.createQuery(hql);
            query.setString("id", postId + "");
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        System.out.println("Post - Rows affected: " + rowCount);
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean updatePostMessage(int postId, String message) {
        openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            Post p = (Post) session.get(Post.class, postId);
            p.setMessage(message);
            session.update(p);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return false;
    }
    
    public PostLike likePost(PostLike postLike){
        openSession();
        Transaction tx = null;
        
        try {
            tx = session.beginTransaction();
            session.save("PostLike", postLike);
            session.flush();
            
            tx.commit();
            return postLike;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        return null;
    }
    
    public PostLike getPostLike(int id){        
        ArrayList<PostLike> postLikeList = new ArrayList<PostLike>();
        openSession();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PostLike where id = :id");
            q.setInteger("id", id);
            postLikeList = (ArrayList<PostLike>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return postLikeList.get(0);
    }

    public boolean unlikePost(int userId, int postId) {
        openSession();
        Transaction tx = null;
        int rowCount = 0;
        
        try {
            tx = session.beginTransaction();
            String hql = "delete from PostLike as pl "
                    + "where pl.post.postId = :pid "
                    + "and pl.user.userId = :uid";
            Query query = session.createQuery(hql);
            query.setInteger("pid", postId);
            query.setInteger("uid", userId);
            rowCount = query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        
        if (rowCount > 0) {
            return true;
        } else {
            return false;
        }   
    }
    
    public boolean hasUserLikedPost(int postId, int userId){
        
        ArrayList<PostLike> postLikeList = new ArrayList<PostLike>();
        
        openSession();
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PostLike as pl "
                    + "where pl.post.postId = :id "
                    + "and pl.user.userId = :uid");
            q.setInteger("id", postId);
            q.setInteger("uid", userId);
            
            postLikeList = (ArrayList<PostLike>) q.list();
            tx.commit();
            
            return !postLikeList.isEmpty();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }

    public ArrayList<PostLike> getPostLikesByPostId(int postId) {
        openSession();
        ArrayList<PostLike> postLikeList = new ArrayList<PostLike>();
        
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from PostLike as pl "
                    + "where pl.post.postId = :id");
            
            q.setInteger("id", postId);
            postLikeList = (ArrayList<PostLike>) q.list();
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return postLikeList;
    }

}

