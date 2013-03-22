<%-- 
    Document   : manage-posts
    Created on : Mar 9, 2013, 6:26:57 PM
    Author     : jonathanseetoh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="managePostBean" scope="page"
             class="com.lin.resident.ManagePostBean"/>

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Resources</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <script src="js/jquery.js"></script>        
        <link href="css/linadmin.css" rel="stylesheet">    

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">

        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery.tokeninput.js"></script>
        <script type="text/javascript" src="/js/jquery.tipsy.js"></script>
        <link rel="stylesheet" href="/css/token-input.css" type="text/css" />
        <link rel="stylesheet" href="/css/token-input-facebook.css" type="text/css" />
        <link rel="stylesheet" href="/css/tipsy.css" type="text/css" />
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/jquery.validate.bootstrap.js"></script>                
        <script src="./js/bootstrap.js"></script>




        <script>
            var postList = [];             
                
            function populateDeletePostModal(postID){ 
                postList.forEach(function(post){
                    if(post.postId == postID){
                        $("#usernameDeleteLabel").text(post.firstName + " " + post.lastName);
                        $("#delete_firstName").text(post.firstName);
                        $("#delete_lastName").text(post.lastName);
                        $("#delete_postDate").text(post.date);
                        $("#delete_id").val(post.postId);
                        
                    }
                });
                
            }
            
            function populateDeletepostCommentModal(postID,commentID){ 
                postList.forEach(function(post){
                    alert("here");
                    $("#usernameDeleteCommentLabel").text(post.firstName + " " + post.lastName);
                    $("#usernameCommentLabel").text(post.firstName + " " + post.lastName);
                    $("#delete_comment_id").val(commentID);
                });
                
            }
            
            function unFlagPostInappropriate(postId){
                var dat = new Object();
                dat.postId = postId;
                dat.isInappropriate = false;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .flagInappropriateBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/flagOrUnflagInappropriate.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    }
                     
                });
            }

        </script>


        <c:if test="${managePostBean.flaggedPostList.size()!=0}">   

            <c:forEach items="${managePostBean.flaggedPostList}" var="post" varStatus="loop">
                <script>
                    var post = new Object();
                    post.postId = '${post.postId}';
                    post.username = '${post.user.escapedUserName}';
                    post.firstName = '${post.user.escapedFirstName}';
                    post.lastName = '${post.user.escapedLastName}';
                    post.title = '${post.title}';
                    post.date = '${post.date}';
                    
                    postList.push(post);
                </script>
            </c:forEach>
        </c:if>
        <c:if test="${managePostBean.postList.size()!=0}">   

            <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">
                <script>
                    var post = new Object();
                    post.postId = '${post.postId}';
                    post.username = '${post.user.escapedUserName}';
                    post.firstName = '${post.user.escapedFirstName}';
                    post.lastName = '${post.user.escapedLastName}';
                    post.title = '${post.title}';
                    post.date = '${post.date}';
                    
                    postList.push(post);
                </script>
            </c:forEach>
        </c:if>
    </head>
    <body>

        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>   

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>

                    <div class="page-header">
                        <h1>Community Posts <small>Manage Posts</small></h1>
                    </div>


                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">Flagged Posts</a></li>
                            <li><a href="#pane2" data-toggle="tab">All Posts</a></li>

                        </ul>
                        <div class="tab-content">
                            <!-- Tab 1 -->


                            <div id="pane1" class="tab-pane active">
                                <h4>Flagged Posts</h4>
                                <c:forEach items="${managePostBean.flaggedPostList}" var="post" varStatus="loop">

                                    <div id="post-${post.postId}" class="postWrapper row-fluid">

                                        <div class="post span8">

                                            <div class="delete"><a href="#deletePostModal" role ="button" data-toggle="modal"
                                                                   onclick="populateDeletePostModal(${post.postId})">
                                                    <i class="icon-remove"></i>							
                                                </a></div>





                                            <div class="baseContent">
                                                <div class="title"><b><a href="profile.jsp?profileid=${post.user.userId}">${post.user.firstname} ${post.user.lastname}</b></a> ${post.title}</div>
                                                <div class="content">"${post.message}"</div>




                                            </div>
                                            <div class="comment replyArea">
                                                Comments:
                                                <br class="clearfix"/>
                                            </div>   

                                            <div class="commentArea">
                                                <div class="comments">
                                                    <c:forEach items="${managePostBean.sortCommentsByDate(post.comments)}" var="comment" varStatus="loop">
                                                        <div class="comment">


                                                            <div class="content float_l">
                                                                <b>${comment.user.firstname} ${comment.user.lastname}: </b>${comment.text}
                                                                <div class="timestamp">${comment.timeSinceComment}</div>
                                                            </div>
                                                            <br class="clearfix"/>
                                                        </div>
                                                    </c:forEach>
                                                </div>






                                            </div>

                                        </div>
                                        <div class="span2 postSideBlock">



                                            <div class="linkBar">
                                                <!--<a class="btn btn-mini btn-peace-2"><i class="icon-check"></i> I'm going!</a>-->



                                                <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Post</a> -->
                                                <!-- This should be to flag as APPROPRIATE-->
                                                <a href="#flag" onclick="unFlagPostInappropriate(${post.postId})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Unflag Inappropriate Post</span></a>

                                            </div>
                                            <!--<div class="sideHeaderBtn">
                                                <div><i class="iconLike icon-heart"></i></div>
                                                <div class="txt">You Like</div> 
                                            </div>-->

                                        </div>   

                                    </div>
                                </c:forEach>



                            </div> 

                            <!-- Tab 2 -->
                            <div id="pane2" class="tab-pane">
                                <h4>All Posts</h4>
                                <br/>
                                <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">

                                    <div id="post-${post.postId}" class="postWrapper row-fluid">

                                        <div class="post span8">

                                            <div class="delete"><a href="#deletePostModal" role ="button" data-toggle="modal"
                                                                   onclick="populateDeletePostModal(${post.postId})">
                                                    <i class="icon-remove"></i>							
                                                </a></div>





                                            <div class="baseContent">
                                                <div class="title"><b><a href="profile.jsp?profileid=${post.user.userId}">${post.user.firstname} ${post.user.lastname}</b></a> ${post.title}</div>
                                                <div class="content">"${post.message}"</div>




                                            </div>
                                            <div class="comment replyArea">
                                                Comments:
                                                <br class="clearfix"/>
                                            </div>   

                                            <div class="commentArea">
                                                <div class="comments">
                                                    <c:forEach items="${managePostBean.sortCommentsByDate(post.comments)}" var="comment" varStatus="loop">
                                                        <div class="comment">


                                                            <div class="content float_l">
                                                                <b>${comment.user.firstname} ${comment.user.lastname}: </b>${comment.text}
                                                                <div class="timestamp">${comment.timeSinceComment}</div>
                                                            </div>
                                                            <br class="clearfix"/>
                                                        </div>
                                                    </c:forEach>
                                                </div>






                                            </div>

                                        </div>
                                        <div class="span2 postSideBlock">


                                            <!--
                                            <div class="linkBar">
                                                <!--<a class="btn btn-mini btn-peace-2"><i class="icon-check"></i> I'm going!</a>-->



                                                <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Post</a> -->
                                                <!-- This should be to flag as APPROPRIATE
                                                <a href="#flag" onclick="unFlagPostInappropriate(${post.postId})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Unflag Inappropriate Post</span></a>

                                            </div>-->
                                                
                                                
                                              
                                            <!--<div class="sideHeaderBtn">
                                                <div><i class="iconLike icon-heart"></i></div>
                                                <div class="txt">You Like</div> 
                                            </div>-->

                                        </div>   

                                    </div>
                                </c:forEach>


                            </div>
                            <hr>
                        </div>
                    </div><!-- /.tab-content -->







                </div>


                <!--<a href="#createEnquiryModal" role='button' data-toggle='modal' class="btn btn-success">Submit Enquiry/Feedback</a>-->
            </div>
        </div>
    </div>

    <hr>

    <%@include file="include/footer.jsp"%>

    <!-- Delete Post Modal -->
    <div id="deletePostModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion of <span id="usernameDeleteLabel"></span>'s post</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManagePostBean" focus=""> 
                You are now deleting <b><span id="delete_firstName"></span> 
                    <span id="delete_lastName"></span>'s</b> post on the <b>
                    <span id="delete_postDate"></span>
                </b>. Are you sure?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>
                <stripes:hidden id="delete_id" name="postId"/>
                <input type="submit" name="adminDeletePost" value="Confirm Delete" class="btn btn-danger"/>
            </div>
        </stripes:form>
    </div>


    <!-- Delete Post Comment Modal -->
    <div id="deleteCommentModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion of <span id="usernameDeleteCommentLabel"></span>'s comment</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManagePostBean" focus=""> 
                You are now deleting <b><span id="usernameCommentLabel"></span>'s</b> comment. Are you sure?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>
                <stripes:hidden id="delete_comment_id" name="commentId"/>
                <input type="submit" name="adminDeleteComment" value="Confirm Delete" class="btn btn-danger"/>
            </div>
        </stripes:form>
    </div>


    <script src="../js/jquery.validate.js"></script>
    <%@include file="/analytics/analytics.jsp"%>

</body>
</html>
