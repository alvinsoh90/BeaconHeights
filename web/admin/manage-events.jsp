<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:useBean id="manageEventBean" scope="page"
             class="com.lin.resident.ManageEventBean"/>

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Events</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">        
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        <link rel="stylesheet" href="/css/token-input.css" type="text/css" />
        <link rel="stylesheet" href="/css/token-input-facebook.css" type="text/css" />
        <link rel="stylesheet" href="/css/tipsy.css" type="text/css" />
        <link href="/css/custom/lin.css" rel="stylesheet" />
        <!--<link href="/residents/css/residentscustom.css" rel="stylesheet" />-->


        <script src="../js/jquery-1.9.1.min.js"></script>
        <script src="../js/bootstrap.min-2.3.0.js"></script>
        <script src="/js/toastr.js"></script>


        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Booking Modals-->
        <script>
            var eventList = [];             
                
            function populateDeleteEventModal(eventID){ 
                eventList.forEach(function(event){
                    if(event.id == eventID){
                        $("#usernameDeleteLabel").text(event.firstName + " " + event.lastName);
                        $("#delete_firstName").text(event.firstName);
                        $("#delete_lastName").text(event.lastName);
                        $("#delete_eventDate").text(event.startTime);
                        $("#delete_eventVenue").text(event.venue);
                        $("#delete_id").val(event.id);
                    }
                });
                
            }
            
            function populateDeleteCommentModal(commentEventID,commentID){ 
                eventList.forEach(function(event){
                    if(event.id == commentEventID){
                        $("#usernameDeleteLabel").text(event.firstName + " " + event.lastName);
                        $("#delete_id").val(commentID);
                    }
                });
                
            }
            

        </script>

        <%--Load up events --%>

        <c:if test="${manageEventBean.flaggedList.size()!=0}">   

            <c:forEach items="${manageEventBean.flaggedList}" var="event" varStatus="loop">
                <script>
                    
                    var event = new Object();
                    event.id = '${event.id}';
                    event.username = '${event.user.escapedUserName}';
                    event.firstName = '${event.user.escapedFirstName}';
                    event.lastName = '${event.user.escapedLastName}';
                    event.title = '${event.escapedTitle}';
                    event.details = '${event.escapedDetails}';
                    event.startTime = '<fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                        value="${event.startTime}"/>';
                    event.endTime = '<fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                        value="${event.endTime}"/>';
                    event.venue = '${event.venue}';
                    eventList.push(event);
                </script>
            </c:forEach>
        </c:if>


    </head>

    <body >
        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>   

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>

                    <div class="page-header">
                        <h1>Events <small> Manage flagged events</small></h1>
                    </div>
                    <div class="container">

                        <c:forEach items="${manageEventBean.flaggedList}" var="post" varStatus="loop">
                            <div id="post-${post.id}" class="postWrapper row-fluid">
                            </div>
                            <div class="post span6">
                                <div class ="eventHeader">
                                    <div class="delete"><a href="#deleteEventModal" role ="button" data-toggle="modal" 
                                                           class="btn btn-smallnew btn-warning"
                                                           onclick="populateDeleteEventModal(${post.id})">
                                            <i class="icon-remove"></i>							
                                        </a></div>
                                    <div class="title"><b>Event Owner:</b> <a href="profile.jsp?profileid=${post.user.userId}"><b>${post.user.firstname} ${post.user.lastname}</b><br/></a>
                                        <b>Date Created:</b> <fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                        value="${post.timestamp}"/>
                                    </div>
                                </div>
                                <div class="baseContent">
                                    <div class="content"><b>Event Details:</b> "${post.details}"</div>
                                    <b>Event Title:</b> <a href="#">${post.title}</a><br/>
                                    <b>Venue:</b> ${post.venue}<br/>
                                    <c:if test="${post.booking != null}">
                                        <c:if test="${not empty post.booking.facility.name}">
                                            <span class="label label-info bookedLabel">${post.booking.facility.name} <b>(Booked)</b></span>
                                        </c:if>
                                        <br/>                                    
                                    </c:if>
                                    <b>Date/Time:</b> ${post.formattedEventTime}

                                    <c:set var="taggedUsers" value="${manageEventBean.getPendingInvites(post.id,-1)}"/>
                                    <c:set var="attendingUsers" value="${manageEventBean.getAttendingUsers(post.id,-1)}"/>

                                    <c:if test="${not empty taggedUsers}">

                                        ${fn:length(taggedUsers)} <br/><b>Guests Invited:</b>
                                        <c:forEach items="${taggedUsers}" var="tagged" varStatus="status">
                                            <code>${tagged.firstname} ${tagged.lastname}</code>
                                        </c:forEach>                                    

                                    </c:if>
                                    <c:if test="${not empty attendingUsers}">

                                        <c:if test="${not empty attendingUsers && not empty taggedUsers}"><span class="gap"></span></c:if>
                                        <br/><b>Guests Attending:</b>
                                        <c:forEach items="${attendingUsers}" var="tagged" varStatus="status">
                                            <code>${tagged.firstname} ${tagged.lastname}</code>
                                        </c:forEach>    
                                    </c:if>
                                    <br/>     
                                </div>
                                <c:if test ="${not empty post.eventCommentsList}">
                                    <div class="linkBar">
                                        <center><b>Event Comments</b></center>
                                    </div>
                                </c:if>

                                <div class="commentArea">
                                    <div class="comments">
                                        <c:forEach items="${post.eventCommentsList}" var="comment" varStatus="loop">
                                            <div class="comment">
                                                <div class="delete"><a href="#deleteEventCommentModal" role ="button" data-toggle="modal"
                                                                       onclick="populateDeleteEventModal(${post.id},${comment.commentId}">
                                                        <i class="icon-remove"></i>							
                                                    </a></div>
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



                        </c:forEach>
                    </div>

                </div>
            </div>


        </div>

        <hr>

        <%@include file="include/footer.jsp"%>



        <!-- Delete Event Modal -->
        <div id="deleteEventModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Deletion of <span id="usernameDeleteLabel"></span>'s event</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManageEventBean" focus=""> 
                    You are now deleting <b><span id="delete_firstName"></span> 
                        <span id="delete_lastName"></span>'s</b> event on the <b>
                        <span id="delete_eventDate"></span>
                    </b> at <b><span id="delete_eventVenue"></span></b>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <stripes:hidden id="delete_id" name="id"/>
                    <input type="submit" name="adminDeleteEvent" value="Confirm Delete" class="btn btn-danger"/>
                </div>
            </stripes:form>
        </div>




        <script>
            $(document).ready(function() {
                // Init
                $('.dropdown-menu li a').hover(
                function() {
                    $(this).children('i').addClass('icon-white');
                },
                function() {
                    $(this).children('i').removeClass('icon-white');
                });
		
                if($(window).width() > 760)
                {
                    $('tr.list-users td div ul').addClass('pull-right');
                }
            });
            
        </script>

        <script src="../js/jquery.validate.js"></script>


        <%@include file="/analytics/analytics.jsp"%>

    </body>
</html>
