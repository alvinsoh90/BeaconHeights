<%-- 
    Document   : eventwall
    Created on : Feb 22, 2013, 11:56:08 AM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Event Wall | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageEventBean" scope="page"
                     class="com.lin.resident.ManageEventBean"/>
        <jsp:useBean id="manageNotificationBean" scope="page"
                     class="com.lin.resident.ManageNotificationBean"/>
        <jsp:useBean id="utilBean" scope="page"
                     class="com.lin.utils.UtilityFunctionsBean"/>
        
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
        <script src="/js/jquery-1.9.1.min.js"></script>
        <script src="/js/bootstrap-2.3.0.js"></script>
        <link href="../css/pickadate.02.classic.css" rel="stylesheet" />
        <script src="../js/pickadate.min.js"></script>
          <script type="text/javascript" src="/js/jquery.tokeninput.js"></script>
         <script type="text/javascript" src="/js/jquery.tipsy.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <link href="/css/custom/lin.css" rel="stylesheet" />
        
        <link rel="stylesheet" href="/css/token-input.css" type="text/css" />
        <link rel="stylesheet" href="/css/token-input-facebook.css" type="text/css" />
        <link rel="stylesheet" href="/css/tipsy.css" type="text/css" />
        <script src="../js/timepicker.min.js"></script> 
        <link href="../css/jquery.timepicker.css" rel="stylesheet"></script>
        <script src="../js/date.js"></script>
        <script src="../js/custom/lin.facebookfunctions.js"></script>

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
                preventDuplicates: true,
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
      
            <script>
                $(document).ready(function() {                
                    $('.timepicker').timepicker({
                        timeFormat:"H:i:s",
                        step:15,
                        'scrollDefaultNow': true 
                    });
                    $('.datepicker').pickadate({
                        format: 'mmm, dd yyyy'
                    });
                });
        </script>
        
        <script>
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
                dat.eventId = postId;
                dat.content = commentContent;
                
                console.log(JSON.stringify(dat));
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/commentOnEventWallPost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            refreshEvent(postId);
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
        <div id="content" class="nopaddingtop">
            <div class="bannerEvent default"></div>
            <div class="container">
                <div class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic" />
                            <a href="profile.jsp?profileid=${post.user.userId}"><div class="name">${user.firstname} ${user.lastname}</div></a>
                        </div>
                        <div class="postIcon wallicon DATE">
                            <div class="timeline"/></div>                           
                    </div>
                    <c:set var="now" value="<%=new java.util.Date()%>" />
                    <div class="wallDate"><fmt:formatDate pattern="dd MMM" value="${now}" /></div>
                </div>
                <div class="postEvent well well-small span5">
                    <h2>Create an Event</h2>
                        <div class="eventBasic">
                        <stripes:form id="postEventForm" beanclass="com.lin.resident.ManageEventBean" focus="eventname" class ="form-horizontal">
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Name</label>
                                    <div class="controls ">
                                    <stripes:text class="wide" id="event_name" name="title" value=""/> 
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Date</label>
                                <div class="controls">
                                    <input class = "wide datepicker input" id="eventDateRaw" />
                                </div>
                            </div>
                            <div class="pushBottom">
                                <label class="control-label">Event Time</label>
                                <div class="controls">
                                        <stripes:hidden id="eventTimeStart" name="eventTimeStart"/>
                                        <input class = "shorty input timepicker" id="eventTimeStartRaw" />
                                        <span class="gap">to</span>
                                        <stripes:hidden id="eventTimeEnd" name="eventTimeEnd" />
                                        <input class = "shorty input timepicker" id="eventTimeEndRaw" />
                                </div>
                           </div>                                
                           <div class="pushBottom">
                                <label class="control-label">Venue</label>
                                <div class="controls">
                                    <stripes:text class="shorty" id="event_venue" name="venue" />
                                    <span class="gap">and</span>
                                    <stripes:select class="shorty" name="bookingId">
                                        <c:set var="bookingList" value="${manageEventBean.getUserFutureBookings(user.userId)}"/>
                                        
                                        <c:choose>
                                            <c:when test="${not empty bookingList}">
                                                <option value="-1">Select a booking</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="-1">No bookings available</option>
                                            </c:otherwise>
                                        </c:choose>
                                                
                                        <c:forEach items="${bookingList}" var="booking">
                                            <option value="${booking.id}">${booking.facility.name} 
                                                on <fmt:formatDate pattern="dd/MM @ hh:mm a" value="${booking.startDate}" /></option>
                                        </c:forEach>       
                            
                                    </stripes:select>
                                </div>
                           </div>                                 
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Details</label>
                                <div class="controls">
                                    <stripes:textarea id="event_description" class="wide" name="details" />
                                </div>
                            </div>
                        </div> 
                        <div class="control-group tagFriends">        
                            <label class="control-label">Tag Friends: </label>
                            <div class="control">
                                <input text="text"  id="tagFriendsBox" />
                                <stripes:hidden id="taggedFriends" name="eventTaggedFriends" />
                            </div>
                        </div>
                        <div class="pushBottom">Public Event <stripes:checkbox name="isPublicEvent" checked="true"/></div>

                        <c:set var="freshUser" value="${utilBean.refreshUser(user)}" /> 
                        <c:choose>
                            <c:when test="${not empty freshUser.facebookId}">
                                <div class="pushBottom">Share with Facebook Group <stripes:checkbox name="shareOnFacebook" checked="true"/></div>
                            </c:when>
                            <c:otherwise>
                                <div class="pushBottom">Share with Facebook Group <stripes:checkbox name="shareOnFacebook" checked="false" disabled="true"/></div>                        
                            </c:otherwise>
                       </c:choose>
                            
                        
                        

                            <stripes:hidden name="posterId" id="posterID" value='${sessionScope.user.userId}'/> 
                            <div class="centerText">
                                <stripes:submit id="submitPost" class="float_l btn btn-peace-1 bigFormSubmit" name="addEvent" value="Create Event"/> 
                            </div>
                        </stripes:form>
                    
                </div>
            </div>


            <c:forEach items="${manageEventBean.getAllPublicAndFriendEvents(10)}" var="post" varStatus="loop">


                <div id="post-${post.id}" class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic" />
                             <a href="profile.jsp?profileid=${post.user.userId}"><div class="name">${post.user.firstname} ${post.user.lastname}</div></a>
                            <div class="timestamp">${post.timeSincePost}</div>
                        </div>
                        <div class="postIcon wallicon DATE">
                            <div class="timeline"/></div>
                        </div>
                        <div class="wallDate"><fmt:formatDate pattern="dd MMM" value="${post.startTime}" /></div>
                </div>
                <div class="post span6">
                    <div class="baseContent">
                        <div class="title"><a href="profile.jsp?profileid=${post.user.userId}"><b>${post.user.firstname} ${post.user.lastname}</b></a> created an event</div>
                        <div class="content">"${post.details}"</div>
                        <div class="attachment event">
                            <div class="eventTitle"><a href="eventpage.jsp?eventid=${post.id}">${post.title}</a></div>
                            <c:if test="${post.booking != null}">
                                <div class="eventMeta">
                                    <b>Venue:</b> ${post.venue}
                                    <c:if test="${not empty post.booking.facility.name}">
                                        <span class="label label-info bookedLabel">${post.booking.facility.name} <b>(Booked)</b></span>
                                    </c:if>
                                        <br/>                                    
                                </div>
                            </c:if>
                            <b>Date/Time:</b> ${post.formattedEventTime}
                        </div>
                            
                            <c:set var="taggedUsers" value="${manageEventBean.getPendingInvites(post.id,-1)}"/>
                            <c:set var="attendingUsers" value="${manageEventBean.getAttendingUsers(post.id,-1)}"/>
                            
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
                            
                            <%-- Check if user likes this post --%>
                            <c:choose>
                                <c:when test="${manageEventBean.hasUserLikedEvent(post.id, sessionScope.user.userId)}">
                                    <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="unlikePost(${post.id})"><i class="iconLike icon-ok"></i> <span class="txt">You Like</span></a>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="likePost(${post.id})"><i class="iconLike icon-heart"></i> <span class="txt">Like</span</a>
                                </c:otherwise>    
                            </c:choose>     
                                    <%-- Check if user likes this post --%>
                                    <c:if test="${user.userId != post.user.userId}">
                            <c:choose>
                                <c:when test="${manageEventBean.hasUserJoinedEvent(post.id, sessionScope.user.userId)}">
                                    <a href="#join" onclick="unJoinEvent(${post.id})" class="joinEventBtn btn btn-info btn-mini"><i class="icon-check iconJoinEvent"></i> <span class="txt">You're going!</span></a>
                                </c:when>
                                <c:otherwise>
                                    <a href="#join" onclick="joinEvent(${post.id})" class="joinEventBtn btn btn-info btn-mini"><i class="icon-share iconJoinEvent"></i> <span class="txt">Join Event</span></a>
                                </c:otherwise>    
                            </c:choose>     
                                    </c:if>
                            
                            <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Event</a> -->
                            <a href="#flag" onclick="flagPostInappropriate(${post.id})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Flag as inappropriate</span></a>
                        </div>
                    </div>
                    <div class="commentArea">
                        <div class="comments">
                            <c:forEach items="${post.eventCommentsList}" var="comment" varStatus="loop">
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
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic float_l" />
                            <input class="float_l commentTextArea" data-post-id="${post.id}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                            <br class="clearfix"/>
                        </div>


                    </div>
                </div>
                
                <div class="span2 postSideBlock">
                    <c:set var="numPostLikes" value="${manageEventBean.getNumEventLikes(post.id)}"/>
                    <c:if test="${numPostLikes > 0}">
                        <div class="header">${numPostLikes} Likes</div>
                        <div class="likerSpace">
                        <c:forEach items="${manageEventBean.getLikersOfEvent(post.id,18)}" var="liker" varStatus="stat">
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
            var successStatus = "${SUCCESS}";
            if(successStatus == "true"){
                toastr.success("Event successfully created!");
            }else if(successStatus == "false"){
                toastr.error("There was a problem creating your event. Please try again later");
            }
    
               function retrieveCreateEventFormInfo(){
                    var eventDateStr = $("#eventDateRaw").val();
                    var startTimeStr = $("#eventTimeStartRaw").val();
                    var endTimeStr = $("#eventTimeEndRaw").val();

                    var eventDateStart = new Date(eventDateStr + " " + startTimeStr);
                    var eventDateEnd = new Date(eventDateStr + " " + endTimeStr);

                    $("#eventTimeStart").val(eventDateStart.getTime());
                    $("#eventTimeEnd").val(eventDateEnd.getTime());
                    
                    var now = new Date();
                    
                    if(!eventDateStr || !startTimeStr || !endTimeStr){
                        return false;
                    }
                    else if(eventDateStart < now){
                        toastr.errorSticky("You cannot create events in the past!");
                        return false;
                    }else if(eventDateEnd < eventDateStart){
                        toastr.errorSticky("Your event ends before it begins!");
                        return false;
                    }
                    else{
                        return true; 
                    }
               
                }
    
$(document).ready(function() {
                
                $("#postEventForm").validate({
                    rules:{
                        eventName: {
                            required: true
                        },
                        eventDate: {
                            required: true
                        },
                        eventTimeStart:{
                            required:true
                        },
                        eventTimeEnd:{
                            required:true
                        }
                    },                    
                    submitHandler: function(form){      
                        if(retrieveCreateEventFormInfo()){
                            form.submit();
                        }
                        else{
                            toastr.error("Please check your entry!");
                        }
                    },
                    errorClass: "help-inline",
                    errorElement: "span",
                    highlight:function(element, errorClass, validClass) {
                        $(element).parents('.control-group').addClass('error');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('error');
                        $(element).parents('.control-group').addClass('success');
                    }
                })                
            }); 
       
</script>                
<%@include file="/included/facebook/initfacebook.jsp"  %>
<script src="../js/jquery.validate.js"></script>
<script src="../js/jquery.validate.bootstrap.js"></script>                
</body>
</html>
