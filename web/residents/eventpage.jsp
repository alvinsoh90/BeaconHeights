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

    </head>
    <body>


        <div id="content">

            <c:set var="event" value="${manageEventBean.getEvent(param.eventid)}"/>
            <c:if test="${manageEventBean.getIsInvited(param.eventid,-1,user.userId)}">



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
                        <div class="title"><a href="profile.jsp?profileid=${event.user.userId}"><b>${event.user.firstname} ${event.user.lastname}</b></a> created an event</div>
                        <div class="content">"${event.details}"</div>
                        <div class="attachment event">
                            <div class="eventTitle"><a href="#">${event.title}</a></div>
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
                    </div>
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
                        <div class="comment replyArea">
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic float_l" />
                            <input class="float_l commentTextArea" data-post-id="${event.id}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                            <br class="clearfix"/>
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


</body>
</html>
