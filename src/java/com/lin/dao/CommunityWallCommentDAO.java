/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.dao;
import com.lin.entities.Comment;
import com.lin.entities.User;
import com.lin.utils.HibernateUtil;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import javax.transaction.Transaction;
import org.hibernate.CacheMode;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Yangsta
 */
public class CommunityWallCommentDAO {
    Session session = null;
    
    public CommunityWallCommentDAO() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        
        if(session == null){
            System.out.println("Session was null, creating one");
            this.session = HibernateUtil.getSessionFactory().openSession();
        }
    }

    private void openSession() {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
    }
    
    public ArrayList<Comment> retrieveCommentsForPost(int postId) {
        openSession();
        ArrayList<Comment> commentList = null;
        try {
            org.hibernate.Transaction tx = session.beginTransaction();
            Query q = session.createQuery("from Comment as c join fetch c.user where c.post.postId = :id");
            q.setString("id", postId+"");
            
            commentList = (ArrayList<Comment>) q.list();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return commentList;
    }
    
        public Comment addComment(Comment comment) {

        openSession();

        org.hibernate.Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save("Comment", comment);
            tx.commit();
            return comment;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        }
        // if txn fails, return null
        return null;
    }
}
