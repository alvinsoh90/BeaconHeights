<%-- 
    Document   : manage-featureposts
    Created on : Mar 22, 2013, 7:40:24 AM
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
            
            function populateUnfeaturePostModal(postID){ 
                postList.forEach(function(post){
                    if(post.postId == postID){
                        $("#usernameFeaturedLabel").text(post.firstName + " " + post.lastName);
                        $("#unfeatured_firstName").text(post.firstName);
                        $("#unfeatured_lastName").text(post.lastName);
                        $("#unfeatured_postDate").text(post.date);
                        $("#unfeatured_id").val(post.postId);
                        
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

        <script>
            var successStatus = "${SUCCESS}";
            if(successStatus == "true"){
                toastr.success("Successfully posted on the community wall!");
            }else if(successStatus == "false"){
                toastr.error("Sorry, there was a problem posting your entry. Please try again later.");
            }
            
            // ** Handle posting ** //
            
            var inviteDefaultTitle = "invites the community";
            var announcementDefaultTitle = "this is announcmentsia";
            var shoutoutDefaultTitle = "says.."
            var requestDefaultTitle = "made a request"
            var defaultTitle = shoutoutDefaultTitle;
            
            var defaultPostContent = "Enter your message to the community..."
            
            $(document).ready(function(){
                $("#postTitle").val(defaultTitle);
                $("#postContent").val(defaultPostContent);
               
                $("#postTitle").focusin(function(){
                    if ($(this).val() == defaultTitle) $(this).val("");  
                });
                $("#postTitle").focusout(function(){
                    if ($(this).val() == "") $(this).val(defaultTitle);  
                });
               
                $("#postOption").change(function(){
                    changeDefaultPostTitle(); 
                });
               
                $("#postContent").focusin(function(){
                    if ($(this).val() == defaultPostContent) $(this).val("");  
                });
                $("#postContent").focusout(function(){
                    if ($(this).val() == "") $(this).val(defaultPostContent);  
                });
               
                $("#submitPost").click(function(){
                    if ($("#postContent").val() == defaultPostContent)  {
                        $("#postContent").val("");
                        toastr.error("Please enter a message for your post");
                    }
                });
                
                function changeDefaultPostTitle(){
                    var postType = $('select#postOption option:selected').val();
                
                    if(postType == "INVITE"){
                        defaultTitle = inviteDefaultTitle;
                    }
                    else if(postType == "SHOUTOUT"){
                        defaultTitle = shoutoutDefaultTitle;
                    }
                    else if(postType == "REQUEST"){
                        defaultTitle = requestDefaultTitle;
                    }
                    else if(postType == "ANNOUNCEMENT"){
                        defaultTitle = announcementDefaultTitle;
                    }
                
                    $("#firstPostIcon").removeClass("INVITE");
                    $("#firstPostIcon").removeClass("SHOUTOUT");
                    $("#firstPostIcon").removeClass("REQUEST");
                    $("#firstPostIcon").removeClass("ANNOUNCEMENT");
                
                    $("#firstPostIcon").addClass(postType);
                    $("#postTitle").val(defaultTitle);
                }
               
                //* Handle Commentng *//
               
                //handlers for making comment
                $(".commentTextArea").each(function(){
                    $(this).keypress(function(e) {
                        if(e.which == 13) {
                            var postId = $(this).attr("data-post-id");
                            var content = $(this).val();
                            postComment(postId,content);
                        }
                    });                   
                });
            });
          

        </script>
        <c:if test="${managePostBean.featuredPostList.size()!=0}">   

            <c:forEach items="${managePostBean.featuredPostList}" var="post" varStatus="loop">
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
        <script>
            // ** Handle friend tagging ** //
    
            var start=/@/ig; // @ Match
            var word=/@(\w+)/ig; //@abc Match
    
            var latestFriendList;
    
            function tagFriendAndReplaceByIdx(idx){
                var content = $("#postContent").val();

                var symbol = content.match(start); //Content Matching @
                var name = content.match(word);
        
                console.log("old content: " + content + ".. looking to replace == " + name);
        
                content = content.replace(name, "<div><a href='./profile.jsp?profileid='>"
                    + latestFriendList[idx].name + "</div></a>");
        
                $("#postContent").append(content);
                console.log("new content: " + content);
            }
    

            //Watch for @
            $("#postContent").on('keyup',function(){
                var content = $("#postContent").val();
        
                var symbol = content.match(start); //Content Matching @
                var name = content.match(word);
        
        
                // if @name is found
                if(symbol != null){ 
                    //make ajax call
                    console.log("make ajax");
            
                    var dat = new Object();
                    dat.userId = '${sessionScope.user.userId}';
                    console.log(name[0]);
                    dat.searchString = name[0].substring(1);                   
                } 
            });
    
            var taggedFriendsList = [];
    
            $(document).ready(function() {
                $("#tagFriendsBox").tokenInput("/json/community/getUserTaggableFriends.jsp", {
                    theme: "facebook",
                    queryParam:"searchString",
                    jsonContainer:"friendList",
                    searchingText:"Searching friends...",
                    hintText:"Enter a friend's name",
                    resultsFormatter: function(item){ return "<li>" + "<img class='resultsPic' src='/uploads/profile_pics/" + item.profilePic + "' title='" + item.name + "' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='resultsName'>" + item.name + "</div><div class='resultsUsername'>" + item.username + "</div></div></li>" },
                    onAdd: function(item){
                        taggedFriendsList.push(item.userId);
                        $("#taggedFriends").val(JSON.stringify(taggedFriendsList));
                    },
                    onDelete: function(item){
                        var idx = taggedFriendsList.indexOf(item.userId);
                        if(idx!=-1) taggedFriendsList.splice(idx,1);
                        $("#taggedFriends").val(JSON.stringify(taggedFriendsList));
                    }
                });
            });
            

        </script>
        



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
                        <h1>Community Posts <small>Manage Featured Posts</small></h1>
                    </div>

                    <h3>Add a new Feature Post</h3>
                    <div class="post span9">
                        
                        <div class="baseContent newPost">
                            
                            <stripes:form id="makePostForm" beanclass="com.lin.resident.AddPostActionBean" focus="postContent">
                                <div class="inlineblock name">${user.firstname} ${user.lastname}  </div>
                                <stripes:text id="postTitle" name="postTitle" class="postTitleArea span3" />
                                <stripes:textarea id="postContent" name="postContent" class="makePost" />
                                Tag Event:
                                <stripes:select name="eventId">
                                    <c:set value="${manageEventBean.getAllFutureEventsForUser(user)}" var="futureBookingList" />
                                    <c:choose>
                                        <c:when test="${not empty futureBookingList}">
                                            <option value="-1">Select an event</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="-1">No events available</option>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:forEach items="${futureBookingList}" var="event">
                                        <option value="${event.id}">${event.title} 
                                            on <fmt:formatDate pattern="dd/MM @ hh:mm a" value="${event.startTime}" /></option>
                                        </c:forEach>       

                                </stripes:select>
                                <br/>
                                Tag Friends: <input text="text"  id="tagFriendsBox" />
                                <stripes:hidden name="taggedFriends" id="taggedFriends" />
                                <br/>
                                <stripes:hidden name="posterId" id="posterID" value='${sessionScope.user.userId}'/> 
                                <div class="optionsBar">
                                    <span>Type:</span> <stripes:select name="postCategory" id="postOption">
                                        <option value="SHOUTOUT">Shout Out</option>
                                        <option value="INVITE">Event Invitation</option>                                                                   
                                        <option value="REQUEST">Request</option> 
                                    </stripes:select>
                                    <stripes:hidden name="wallId" id="wallId" value="-1"/> 
                                    <stripes:hidden name="isFeaturedPost" id="isFeaturedPost" value ='true'/>
                                    
                                    <c:set var="freshUser" value="${utilBean.refreshUser(user)}" /> 
                                    <c:choose>
                                        <c:when test="${not empty freshUser.facebookId}">
                                            Share with Facebook Group <stripes:checkbox name="shareOnFacebook" checked="true"/>
                                        </c:when>
                                        <c:otherwise>
                                            Share with Facebook Group <stripes:checkbox name="shareOnFacebook" checked="false" disabled="true"/>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <stripes:submit id="submitPost" class="float_r btn btn-peace-1" name="addPost" value="Submit Feature Post"/> 
                                </stripes:form>
                            </div>
                        </div>
                        
                    </div>
                    
                    
                    <c:forEach items="${managePostBean.featuredPostList}" var="post" varStatus="loop">

                        <div id="post-${post.postId}" class="postWrapper row-fluid">
                            
                            <div class="post span6">

                                <div class="baseContent">
                                    <div class="title"><b><a href="profile.jsp?profileid=${post.user.userId}">${post.user.firstname} ${post.user.lastname}</b></a> ${post.title}</div>
                                    <div class="content">"${post.message}"</div>

                                </div>

                            </div>
                            <div class="span2 postSideBlock">
                                <div class="btn-group" style="visibility:visible !important;">
                                <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <li><a href="#unfeaturePostModal" role="button" data-toggle="modal" onclick="populateUnfeaturePostModal(${post.postId})"><i class="icon-pencil"></i> Edit</a></li>
                                    <li><a href="#deletePostModal" role="button" data-toggle="modal" onclick="populateDeletePostModal(${post.postId})"><i class="icon-trash"></i> Delete</a></li>
                                </ul>
                            </div>


                        </div>   

                    </div>
                </c:forEach>

            </div>
        </div>
    </div>
</div>

<hr>

<%@include file="include/footer.jsp"%>


<!-- unfeature post -->
<div id="unfeaturePostModal" class="modal hide fade">
    <div id="myModal" class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>Unfeature of <span id="usernameFeaturedLabel"></span>'s post</h3>
    </div>
    <div class="modal-body">
        <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManagePostBean" focus=""> 
            You are now un-featuring <b><span id="unfeatured_firstName"></span> 
                <span id="unfeatured_lastName"></span>'s</b> post on the <b>
                <span id="unfeatured_postDate"></span>
            </b>. Are you sure?
        </div>
        <div class="modal-footer">
            <a data-dismiss="modal" class="btn">Close</a>
            <stripes:hidden id="unfeatured_id" name="postId"/>
            <input type="submit" name="adminUnfeaturePost" value="Confirm Unfeature Post" class="btn btn-primary"/>
        </div>
    </stripes:form>
</div>

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