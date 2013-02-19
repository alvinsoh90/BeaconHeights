<%-- 
    Document   : communitywall
    Created on : Jan 27, 2013, 11:36:07 PM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Community Wall | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.resident.ManagePostBean"/>
        <%@include file="/protect.jsp"%>


        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    

        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <%@include file="/header.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">


        <link rel="stylesheet" href="./css/fullcalendar.css" />	
        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        <script src="./js/unicorn.calendar.js"></script>
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <script>
            var successStatus = "${SUCCESS}";
            if(successStatus == "true"){
                toastr.success("Successfully posted on the community wall!");
            }else if(successStatus == "false"){
                toastr.error("Sorry, there was a problem posting your entry. Please try again later.");
            }
            
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
                
                $("#postTitle").val(defaultTitle);
            }
            
            function postComment(postId, commentContent){
                
                var dat = new Object();
                dat.postId = postId;
                dat.content = commentContent;
                dat.posterId = ${user.userId};
                
                console.log(JSON.stringify(dat));
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/commentOnCommunityWallPost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            refreshPost(postId);
                            //setTimeout('window.location.href="/admin/manage-facilitytypes.jsp"',1300);
                        }
                        else{
                            toastr.error("There was a problem leaving a comment. Please try again later.");
                        }
                    } 
                });
            }
            var r;
            function refreshPost(postId){
                //fade out comment area
                $("#post-" + postId + " .commentArea .comments").css("opacity","0.6");
                //show ajax loading
                $("#post-" + postId + " .commentArea .ajaxSpinnerSmall").show();
                
                var dat = new Object();
                dat.postId = postId;
                
                //post comment
                $.ajax({
                    type: "POST",
                    url: "/json/community/getCommentsForPost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(data.comments);
                        r = data.comments[0];
                        $("#post-" + postId + " .commentArea .comments").html(""); 
                            
                        //loop thru retrieved comments and append to html
                        for(var i=0;i<data.comments[0].length;i++){
                            var c = data.comments[0][i];
                            $("#post-" + postId + " .commentArea .comments").append(
                            '<div class="comment"><img src="/uploads/profile_pics/'+c.user.profilePicFilename+'" class="profilePic float_l"><div class="content float_l"><b>'+c.user.escapedUserName+': </b>'+c.text+'<div class="timestamp">'+c.timeSinceComment+'</div></div><br class="clearfix"></div>'
                        )
                        }

                        //after done, fade in comment area
                        $("#post-" + postId + " .commentArea .comments").css("opacity","1");
                        //clear comment input box
                        $("#post-" + postId + " .commentArea .commentTextArea").val("");   
                        //hide ajax loading
                        $("#post-" + postId + " .commentArea .ajaxSpinnerSmall").hide();
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                        }
                        else{
                            $("#post-" + postId + " .commentArea .comments").css("opacity","1");
                            toastr.error("There was a problem leaving a comment. Please try again later.");
                        }
                    } 
                });
                
                                               
            }
            
        </script>

    </head>
    <body>


        <div id="content">

            <div class="container">
                <div class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic" />
                            <div class="name">${user.userName}</div>
                        </div>
                        <div class="postIcon wallicon INVITE">
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post span6">
                    <div class="baseContent newPost">
                        <stripes:form id="makePostForm" beanclass="com.lin.resident.AddPostActionBean" focus="postContent">
                            <div class="inlineblock name">${user.userName}  </div>
                            <stripes:text id="postTitle" name="postTitle" class="postTitleArea span3" />
                            <stripes:textarea id="postContent" name="postContent" class="makePost" />
                            <stripes:hidden name="posterId" id="posterID" value='${sessionScope.user.userId}'/> 
                            <div class="optionsBar">
                                <span>Type:</span> <stripes:select name="postCategory" id="postOption">
                                    <option value="SHOUTOUT">Shout Out</option>
                                    <option value="INVITE">Event Invitation</option>                                                                    <option value="REQUEST">Request</option> 
                                </stripes:select>
                                <stripes:submit id="submitPost" class="float_r btn btn-peace-1" name="addPost" value="Post to Wall"/> 
                            </stripes:form>
                        </div>
                    </div>
                </div>

            </div>


            <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">


                <div id="post-${post.postId}" class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic" />
                            <div class="name">${post.user.userName}</div>
                            <div class="timestamp">${post.timeSincePost}</div>
                        </div>
                        <div class="postIcon wallicon ${post.category}">
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post span6">
                    <div class="baseContent">
                        <div class="title"><b>${post.user.userName}</b> ${post.title}</div>
                        <div class="content">"${post.message}"</div>
                        <div class="attachment event hide">
                            <div class="eventTitle"><a href="#">Tennis Game Tonight, 7pm!</a></div>
                            <div class="eventMeta">
                                <b>Venue:</b> Beacon Heights Tennis Court 2 <br/>
                                <b>Date/Time:</b> 28 Sept '12 @ 7pm - 10pm
                            </div>
                        </div>
                        <div class="linkBar hide">
                            <a class="btn"><i class="icon-check"></i> I'm going!</a>
                            <a class="btn"><i class="icon-heart"></i> Like</a>
                            <a class="btn"><i class="icon-eye-open"></i> View Event</a>
                            <a href="#" class="float_r flagPost"><i class="icon-flag"></i> Flag as inappropriate</a>
                        </div>
                    </div>
                    <div class="commentArea">
                        <div class="comments">
                            <c:forEach items="${post.comments}" var="comment" varStatus="loop">
                                <div class="comment">
                                    <img src="/uploads/profile_pics/${comment.user.profilePicFilename}" class="profilePic float_l"/>
                                    <div class="content float_l">
                                        <b>${comment.user.userName}: </b>${comment.text}
                                        <div class="timestamp">${comment.timeSinceComment}</div>
                                    </div>
                                    <br class="clearfix"/>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="comment replyArea">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic float_l" />
                            <input class="float_l commentTextArea" data-post-id="${post.postId}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                            <br class="clearfix"/>
                        </div>


                    </div>
                </div>

            </div>
        </c:forEach>

    </div>
</div>
<div id="footer">

    <div class="container">				

        <p><center><a href="mailto:helpdesk@beaconheights.com.sg">
                Facing Technical Issues? Contact the LivingNet help desk</a></center></p>
    </div> <!-- /container -->

</div> <!-- /footer -->
<script>
    $(document).ready(function() { 
                
        $("#makePostForm").validate({
            rules: {
                postTitle: "required",
                postContent: "required"                        
            },
            messages :{
                postTitle: "",
                postContent: ""
            },
                        
            submitHandler: function(form) {
                formAjaxSubmit();     
                //slotDataHasError
            }
                        
        });
    });
            
       
</script>                

<script src="../js/jquery.validate.js"></script>
<script src="../js/jquery.validate.bootstrap.js"></script>                
<script src="./js/bootstrap.js"></script>
</body>
</html>
