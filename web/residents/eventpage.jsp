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
        <title>Event Page | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageEventBean" scope="page"
                     class="com.lin.resident.ManageEventBean"/>
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

        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        
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
            //Handle Posting
            
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
            
            
            
            
            
            //* Handle Commentng *//
            $(document).ready(function() {       
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
            function refreshEvent(postId){
                //fade out comment area
                $("#post-" + postId + " .commentArea .comments").css("opacity","0.6");
                //show ajax loading
                $("#post-" + postId + " .commentArea .ajaxSpinnerSmall").show();
                
                var dat = new Object();
                dat.eventId = postId;
                
                //post comment
                $.ajax({
                    type: "POST",
                    url: "/json/community/getEventCommentsForEvent.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(data.comments);
                        r = data.comments[0];
                        $("#post-" + postId + " .commentArea .comments").html(""); 
                            
                        //loop thru retrieved comments and append to html
                        for(var i=0;i<data.comments[0].length;i++){
                            var c = data.comments[0][i];
                            $("#post-" + postId + " .commentArea .comments").append(
                            '<div class="comment"><img src="/uploads/profile_pics/'+c.user.profilePicFilename+'" class="profilePic float_l"><div class="content float_l"><b>'+c.user.escapedFirstName + ' ' + c.user.escapedLastName +': </b>'+c.text+'<div class="timestamp">'+c.timeSinceComment+'</div></div><br class="clearfix"></div>'
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
            
            function likePost(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isALike = true;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .postLikeBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/likeOrUnlikePost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            $("#post-"+postId+" .postLikeBtn").removeClass("disabled");
                            // disable like button
                            $("#post-"+postId+" .postLikeBtn .txt").text("You like");
                            $("#post-"+postId+" .postLikeBtn .iconLike").attr("class","icon-ok iconLike");
                            $("#post-"+postId+" .postLikeBtn").attr("onclick","unlikePost("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem liking this post. Please try again later.");
                        }
                    } 
                });
            }
            
            function unlikePost(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isALike = false;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .postLikeBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/likeOrUnlikePost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            $("#post-"+postId+" .postLikeBtn").removeClass("disabled");
                            // enable like button
                            $("#post-"+postId+" .postLikeBtn .txt").text("Like");
                            $("#post-"+postId+" .postLikeBtn .iconLike").attr("class","icon-heart iconLike");
                            $("#post-"+postId+" .postLikeBtn").attr("onclick","likePost("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem unliking this post. Please try again later.");
                        }
                    } 
                });
            }
            
            function flagPostInappropriate(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isInappropriate = true;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .flagInappropriateBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/flagOrUnflagInappropriate.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        if(xhr.status === 200){
                            if(!data.flag_success && data.reason){
                                toastr.error(data.reason);
                            }
                            $("#post-"+postId+" .flagInappropriateBtn").removeClass("disabled");
                            // disable button
                            $("#post-"+postId+" .flagInappropriateBtn .txt").text("Post flagged (click to undo)");
                            $("#post-"+postId+" .flagInappropriateBtn").attr("onclick","unFlagPostInappropriate("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    }
                });
            }
            
            function unFlagPostInappropriate(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isInappropriate = false;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .flagInappropriateBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/flagOrUnflagInappropriate.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            $("#post-"+postId+" .flagInappropriateBtn").removeClass("disabled");
                            // disable like button
                            $("#post-"+postId+" .flagInappropriateBtn .txt").text("Flag as inappropriate");
                            $("#post-"+postId+" .flagInappropriateBtn").attr("onclick","flagPostInappropriate("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    } 
                });
            }
            
            function joinEvent(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isJoiningEvent = true;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .joinEventBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/joinOrUnJoinEvent.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        if(xhr.status === 200){
                            if(!data.flag_success && data.reason){
                                toastr.error(data.reason);
                            }
                            $("#post-"+postId+" .joinEventBtn").removeClass("disabled");
                            // disable button
                            $("#post-"+postId+" .joinEventBtn .txt").text("You're going!");
                            $("#post-"+postId+" .joinEventBtn .iconJoinEvent").attr("class","icon-check iconJoinEvent");
                            $("#post-"+postId+" .joinEventBtn").attr("onclick","unJoinEvent("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    }
                });
            }
            
            function unJoinEvent(postId){
                var dat = new Object();
                dat.eventId = postId;
                dat.isJoiningEvent = false;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .joinEventBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/joinOrUnJoinEvent.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        if(xhr.status === 200){
                            if(!data.flag_success && data.reason){
                                toastr.error(data.reason);
                            }
                            $("#post-"+postId+" .joinEventBtn").removeClass("disabled");
                            // disable button
                            $("#post-"+postId+" .joinEventBtn .txt").text("Join Event");
                            $("#post-"+postId+" .joinEventBtn .iconJoinEvent").attr("class","icon-share iconJoinEvent");
                            $("#post-"+postId+" .joinEventBtn").attr("onclick","joinEvent("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    }
                });
            }
        </script>

    </head>
    <body>

        <c:set var="event" value="${manageEventBean.getEvent(param.eventid)}"/>


        <div id="content" class="nopaddingtop">
            <c:if test="${user.userId==event.user.userId}">
                <a href='#editPicModal' role='button' data-toggle='modal'>
                </c:if>
                <img class ="bannerEvent" src="/uploads/banner_pics/${event.bannerFileName}" />
                <c:if test="${user.userId==event.user.userId}">
                </a>
            </c:if>
            <div class="container">

                <c:if test="${!manageEventBean.getIsEventViewable(param.eventid,user.userId)}">
                    <div class="postWrapper row-fluid">
                        <div class="baseContent container">
                            <h2>
                                Sorry, the event you're trying to access is either not public or you haven't been invited.
                            </h2>
                        </div>
                    </div>
                </c:if>
                <c:if test="${manageEventBean.getIsEventViewable(param.eventid,user.userId)}">


                    <div id="post-${event.id}" class="postWrapper row-fluid">
                        <div class="leftContent span2">
                            <div class="posterInfo">
                                <img src="/uploads/profile_pics/${event.user.profilePicFilename}" class="profilePic" />
                                <a href="profile.jsp?profileid=${event.user.userId}"><div class="name">${event.user.firstname} ${event.user.lastname}</div></a>
                                <div class="timestamp">${event.timeSincePost}</div>
                            </div>
                            <div class="postIcon wallicon DATE">
                                <div class="timeline"/></div>
                        </div>
                        <div class="wallDate"><fmt:formatDate pattern="dd MMM" value="${event.startTime}" /></div>
                    </div>
                    <div class="post span6">
                        <div class="baseContent">
                            <div class="title"><a href="profile.jsp?profileid=${event.user.userId}"><b>${event.user.firstname} ${event.user.lastname}</b></a>'s event</div>
                            <div class="content"><h2>"${event.details}"</h2></div>
                            <div class="attachment event">
                                <div class="eventTitle"><a href="#"><h1>${event.title}</h1></a></div>
                                <c:if test="${event.booking != null}">
                                    <div class="eventMeta">
                                        <b>Venue:</b> ${event.venue}
                                        <c:if test="${not empty event.booking.facility.name}">
                                            <span class="label label-info bookedLabel">${event.booking.facility.name} <b>(Booked)</b></span>
                                        </c:if>
                                        <br/>                                    
                                    </div>
                                </c:if>
                                <b>Date/Time:</b> ${event.formattedEventTime}
                            </div>

                            <c:set var="taggedUsers" value="${manageEventBean.getPendingInvites(event.id,-1)}"/>
                            <c:set var="attendingUsers" value="${manageEventBean.getAttendingUsers(event.id,-1)}"/>

                            <div class="taggedUsers">
                                <c:if test="${not empty taggedUsers}">

                                    ${fn:length(taggedUsers)} Invited:
                                    <c:forEach items="${taggedUsers}" var="tagged" varStatus="status">
                                        <a href="profile.jsp?profileid=${tagged.userId}"><img title="${tagged.firstname}" class="liker" src='/uploads/profile_pics/${tagged.profilePicFilename}' height="25px" width="25px" class="float_l"/></a>
                                        </c:forEach>                                    

                                </c:if>
                                <c:if test="${not empty attendingUsers}">

                                    <c:if test="${not empty attendingUsers && not empty taggedUsers}"><span class="gap"></span></c:if>
                                    ${fn:length(attendingUsers)} Coming:
                                    <c:forEach items="${attendingUsers}" var="tagged" varStatus="status">
                                        <a href="profile.jsp?profileid=${tagged.userId}"><img title="${tagged.firstname} ${tagged.lastname}" class="liker" src='/uploads/profile_pics/${tagged.profilePicFilename}' height="25px" width="25px" class="float_l"/></a>
                                        </c:forEach>    
                                    </c:if>
                            </div>

                            <div class="linkBar">
                                <!--<a class="btn btn-mini btn-peace-2"><i class="icon-check"></i> I'm going!</a>-->

                                <%-- Check if user likes this event --%>
                                <c:choose>
                                    <c:when test="${manageEventBean.hasUserLikedEvent(event.id, sessionScope.user.userId)}">
                                        <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="unlikePost(${event.id})"><i class="iconLike icon-ok"></i> <span class="txt">You Like</span></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="likePost(${event.id})"><i class="iconLike icon-heart"></i> <span class="txt">Like</span</a>
                                    </c:otherwise>    
                                </c:choose>     
                                <%-- Check if user likes this post --%>
                                <c:if test="${user.userId != event.user.userId}">
                                    <c:choose>
                                        <c:when test="${manageEventBean.hasUserJoinedEvent(event.id, sessionScope.user.userId)}">
                                            <a href="#join" onclick="unJoinEvent(${event.id})" class="joinEventBtn btn btn-info btn-mini"><i class="icon-check iconJoinEvent"></i> <span class="txt">You're going!</span></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#join" onclick="joinEvent(${event.id})" class="joinEventBtn btn btn-info btn-mini"><i class="icon-share iconJoinEvent"></i> <span class="txt">Join Event</span></a>
                                        </c:otherwise>    
                                    </c:choose>     
                                </c:if>

                                <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Event</a> -->
                                <a href="#flag" onclick="flagPostInappropriate(${event.id})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Flag as inappropriate</span></a>
                            </div>
                            <div class="baseContent newPost">
                                <stripes:form id="makePostForm" beanclass="com.lin.resident.AddPostActionBean" focus="postContent">
                                    <div class="inlineblock name">Post something to this wall </div><br/>
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
                                    <stripes:hidden name="wallId" id="wallId" value='${param.eventid}'/> 
                                    <div class="optionsBar">
                                        <span>Type:</span> <stripes:select name="postCategory" id="postOption">
                                            <option value="SHOUTOUT">Shout Out</option>
                                            <option value="INVITE">Event Invitation</option>                                                                   
                                            <option value="REQUEST">Request</option> 
                                        </stripes:select>

                                        <stripes:submit id="submitPost" class="float_r btn btn-peace-1" name="addPost" value="Post to Event"/> 
                                    </stripes:form>
                                </div>
                            </div>
                        </div>


                    </div>


                    <div id="content">

                        <div class="container">
                            <div class="postWrapper row-fluid">

                            </div>
                        </div>

                    </div>


                    <c:forEach items="${managePostBean.getWallPostList(param.eventid)}" var="post" varStatus="loop">

                        <div id="post-${post.postId}" class="postWrapper row-fluid">
                            <div class="leftContent span2">
                                <div class="posterInfo">
                                    <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic" />
                                    <a href="profile.jsp?profileid=${post.user.userId}"><div class="name">${post.user.firstname} ${post.user.lastname}</div></a>
                                    <div class="timestamp">${post.timeSincePost}</div>
                                </div>
                                <div class="postIcon wallicon ${post.category}">
                                    <div class="timeline"/></div>
                            </div>
                        </div>
                        <div class="post span6">
                            <div class="baseContent">
                                <div class="title"><b><a href="profile.jsp?profileid=${post.user.userId}">${post.user.firstname} ${post.user.lastname}</b></a> ${post.title}</div>
                                <div class="content">"${post.message}"</div>


                                <c:set var="taggedUsers" value="${managePostBean.getTaggedUsers(post.postId,-1)}"/>

                                <c:if test="${not empty taggedUsers}">
                                    <div class="taggedUsers">
                                        Tagged:
                                        <c:forEach items="${taggedUsers}" var="tagged" varStatus="status">
                                            <a href="profile.jsp?profileid=${tagged.userId}"><img title="${tagged.firstname} ${tagged.lastname}" class="liker" src='/uploads/profile_pics/${tagged.profilePicFilename}' height="25px" width="25px" class="float_l"/></a>
                                            </c:forEach>
                                    </div>    
                                </c:if>

                                <div class="linkBar">
                                    <!--<a class="btn btn-mini btn-peace-2"><i class="icon-check"></i> I'm going!</a>-->

                                    <%-- Check if user likes this post --%>
                                    <c:choose>
                                        <c:when test="${managePostBean.hasUserLikedPost(post.postId, sessionScope.user.userId)}">
                                            <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="unlikePost(${post.postId})"><i class="iconLike icon-ok"></i> <span class="txt">You Like</span></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="likePost(${post.postId})"><i class="iconLike icon-heart"></i> <span class="txt">Like</span</a>
                                        </c:otherwise>    
                                    </c:choose>                                

                                    <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Event</a> -->
                                    <a href="#flag" onclick="flagPostInappropriate(${post.postId})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Flag as inappropriate</span></a>
                                </div>
                            </div>
                            <div class="commentArea">
                                <div class="comments">
                                    <c:forEach items="${managePostBean.sortCommentsByDate(post.comments)}" var="comment" varStatus="loop">
                                        <div class="comment">
                                            <img src="/uploads/profile_pics/${comment.user.profilePicFilename}" class="profilePic float_l"/>
                                            <div class="content float_l">
                                                <b>${comment.user.firstname} ${comment.user.lastname}: </b>${comment.text}
                                                <div class="timestamp">${comment.timeSinceComment}</div>
                                            </div>
                                            <br class="clearfix"/>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="comment replyArea">
                                    <img src="/uploads/profile_pics/${sessionScope.user.profilePicFilename}" class="profilePic float_l" />
                                    <input class="float_l commentTextArea" data-post-id="${post.postId}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                                    <br class="clearfix"/>
                                </div>


                            </div>
                        </div>
                        <div class="span2 postSideBlock">

                        </div>                                
                    </div>
                </c:forEach>

                <div class="commentArea">
                    <div class="comments">
                        <c:forEach items="${event.eventCommentsList}" var="comment" varStatus="loop">
                            <div class="comment">
                                <img src="/uploads/profile_pics/${comment.user.profilePicFilename}" class="profilePic float_l"/>
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
        </div>

        <div class="span2 postSideBlock">
            <c:set var="numPostLikes" value="${manageEventBean.getNumEventLikes(event.id)}"/>
            <c:if test="${numPostLikes > 0}">
                <div class="header">${numPostLikes} Likes</div>
                <div class="likerSpace">
                    <c:forEach items="${manageEventBean.getLikersOfEvent(event.id,18)}" var="liker" varStatus="stat">
                        <a href="profile.jsp?profileid=${liker.userId}"><img title="${liker.firstname} ${liker.lastname}" class="liker" src='/uploads/profile_pics/${liker.profilePicFilename}' height="25px" width="25px" class="float_l"/></a>
                        </c:forEach>      
                </div>
                <script>
                    $(document).ready(function() {         
                        //Tipsy tooltips
                        $(".liker").each(function(){
                            $(this).tipsy({gravity: 'n'});
                        });
                    });       
                </script>
            </c:if>                        
        </div>  

    </div>


</div>

</c:if>

</div>
<div id="footer">

    <div class="container">				

        <p><center><a href="mailto:helpdesk@beaconheights.com.sg">
                Facing Technical Issues? Contact the LivingNet help desk</a></center></p>
    </div> <!-- /container -->

</div> <!-- /footer -->
<!-- Edit Pic Modal Form -->
<div id="editPicModal" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>Upload A New Event Banner</h3>
    </div>
    <div class="modal-body">
        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.UploadEventBannerActionBean" name="new_resource_validate" id="new_resource_validate">                 
            <stripes:hidden name="user_id" value="${user.userId}" />
            <div class="control-group ${errorStyle}">
                <label class="control-label">File:</label>
                <div class="controls">
                    <stripes:file name="file" id="file"/><div id="fileInfoMsg"></div>
                </div>
            </div>
            <div class="modal-footer">
                <input type="submit" name="upload" value="Upload" class="btn btn-info btn-large" id="uploadBtn"/>                                                           
            </stripes:form>
        </div>
    </div>      
</div>


</body>
</html>
