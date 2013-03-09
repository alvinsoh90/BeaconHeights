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
            
            function populateEditEventModal(bookingID){ 
                console.log("REACHED");
                eventList.forEach(function(booking){
                    if(booking.id == bookingID){
                        $("#usernameEditLabel").text(booking.username);
                        $("#edit_username").val(booking.username);
                        $("#edit_facilityType").text(booking.facilityType);
                        $("#edit_facilityId").text(booking.facilityId);
                        
                        
                        $("#editBookingStartDate").val(
                        Date.parse(booking.startDate.substring(0,10)).toString("MMM, dd yyyy"));
                        $("#editBookingEndDate").val(
                        Date.parse(booking.endDate.substring(0,10)).toString("MMM, dd yyyy"));
                        $("#editBookingStartTime").val(booking.startDate.substring(11,19));
                        $("#editBookingEndTime").val(booking.endDate.substring(11,19));
                        
                        $("#edit_id").val(booking.id);
                        $("#edit_displayid").val(booking.id);
                    }
                });
                
            }

        </script>

        <%--Load up events --%>

        <c:if test="${manageEventsBean.flaggedList.size()!=0}">   
            
            <c:forEach items="${manageEventsBean.flaggedList}" var="event" varStatus="loop">
                <script>
                    var event = new Object();
                    event.id = '${event.id}';
                    event.username = '${event.user.escapedUserName}';
                    event.firstName = '${event.user.escapedFirstName}';
                    event.lastName = '${event.user.escapedLastName}';
                    event.title = '${event.escapedTitle}';
                    event.details = '${event.escapedDetails}';
                    event.startTime = '${event.startTime}';
                    event.endTime = '${event.endTime}';
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

                        <c:forEach items="${manageEventBean.getAllPublicAndFriendEvents(10)}" var="post" varStatus="loop">

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
                                    <c:if test="${post.booking != null}">
                                        <b>Venue:</b> ${post.venue}
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
                                <div class="linkBar">
                                    <center><b>Event Comments</b></center>
                                </div>

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


                        </div>
                    </c:forEach>
                </div>
            </div>


        </div>

<hr>

<%@include file="include/footer.jsp"%>


<!-- Pay Booking Modal -->
<div id="payBookingModal" class="modal hide fade">
    <div id="myModal" class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>Record Payment of <span id="usernamePayLabel"></span>'s booking</h3>
    </div>
    <div class="modal-body">
        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.PayBookingBean" focus=""> 
            <div class="control-group ${errorStyle}">
                <label class="control-label">Transaction ID</label>
                <div class="controls">
                    <stripes:text id="pay_transactionId" name="transactionId"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a data-dismiss="modal" class="btn">Close</a>
            <stripes:hidden id="pay_username" name="username"/>
            <stripes:hidden id="pay_id" name="id"/>
            <input type="submit" name="payBooking" value="Update" class="btn btn-primary"/>
        </div>
    </stripes:form>
</div>

<!-- Pending Booking Modal -->
<div id="pendingBookingModal" class="modal hide fade">
    <div id="myModal" class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>Revert Payment of <span id="usernamePendingLabel"></span>'s booking</h3>
    </div>
    <div class="modal-body">
        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.PayBookingBean" focus=""> 
            You are now reverting the booking status to pending. Are you sure?
        </div>
        <div class="modal-footer">
            <a data-dismiss="modal" class="btn">Close</a>
            <stripes:hidden id="pending_username" name="username"/>
            <stripes:hidden id="pending_id" name="id"/>
            <input type="submit" name="payBooking" value="Change to Pending" class="btn btn-primary"/>
        </div>
    </stripes:form>
</div>


<!-- Edit Booking Modal Form -->
<div id="editBookingModal" class="modal hide fade" style="overflow: visible;">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3>Edit <span id="usernameEditLabel"></span>'s booking</h3>
    </div>
    <div class="modal-body">

        <div class="alert alert-info">
            <b>Note! </b> Manually editing booking timings may cause this booking to overlap with other bookings, or booking in invalid time slots. Do check if the desired timing is valid and available beforehand. 
        </div>

        <form class="form-horizontal" id="edit_booking_validate" name="edit_booking_validate">
            <div class="control-group ${errorStyle}">
                <label class="control-label">Booking ID</label>

                <div class="controls">
                    <input type="text" id="edit_displayid" name="displayid" class="shorty" disabled/>
                </div>
            </div>
            <div class="control-group ${errorStyle}">
                <label class="control-label">Start Date</label>
                <div class="controls">
                    <input type="hidden" id="edit_startDateTime" name="startDateTime"/>
                    <input type="text" id="editBookingStartDate" class="datepicker"/> 
                </div>
            </div>
            <div class="control-group ${errorStyle}">
                <label class="control-label">Start Time</label>
                <div class="controls">
                    <input type="text" id="editBookingStartTime" class="timepicker"/> 
                </div>
            </div>    

            <div class="control-group ${errorStyle}">
                <label class="control-label">End Date</label>
                <div class="controls">
                    <input type="hidden" id="edit_endDateTime" name="endDateTime"/>
                    <input type="text" id="editBookingEndDate" class="datepicker"/> 
                </div>
            </div>
            <div class="control-group ${errorStyle}">
                <label class="control-label">End Time</label>
                <div class="controls">
                    <input type="text" id="editBookingEndTime" class="timepicker"/> 
                </div>
            </div>     
    </div>
    <div class="modal-footer">
        <a data-dismiss="modal" class="btn">Close</a>
        <input type="submit" name="editBooking" value="Confirm Edit" class="btn btn-primary"/>
    </div>

</form>
</div>


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
                </b> on <b><span id="delete_eventVenue"></span></b>. Are you sure?
        </div>
        <div class="modal-footer">
            <a data-dismiss="modal" class="btn">Close</a>
            <stripes:hidden id="delete_id" name="id"/>
            <input type="submit" name="deleteEvent" value="Confirm Delete" class="btn btn-danger"/>
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



<script>        
    function retrieveEditBookingFormInfo(){
        var startDateStr = $("#editBookingStartDate").val();
        var endDateStr = $("#editBookingEndDate").val();
        var startTimeStr = $("#editBookingStartTime").val();
        var endTimeStr = $("#editBookingEndTime").val();
                
        var startDate = new Date(startDateStr + " " + startTimeStr);
        var endDate = new Date(endDateStr + " " + endTimeStr);
        console.log("sd: "+startDate.getTime());
        console.log("sd2: "+endDate);
        $("#edit_startDateTime").val(startDate.getTime());
        $("#edit_endDateTime").val(endDate.getTime());
                
        if(!startDate || !endDate){
            toastr.error("Please check your entry!");
            return false;
        }
        else{
            return true; 
        }
               
    }
            
    $(document).ready(function() {
                
               
        $("#edit_booking_validate").validate({
            rules:{
                startTime: {
                    required: true
                },
                endTime: {
                    required: true
                },
                startDate:{
                    required:true
                },
                endDate:{
                    required:true
                }
            },                    
            submitHandler: function(){      
                if(retrieveEditBookingFormInfo()){
                    var dat = new Object();
                    dat.bookingid = $("#edit_displayid").val();
                    dat.startDateTime = $("#edit_startDateTime").val();
                    dat.endDateTime = $("#edit_endDateTime").val();
                    console.log(JSON.stringify(dat));
                    $.ajax({
                        type: "POST",
                        url: "/json/admin/editBookingJSON.jsp",
                        data: dat,
                        success: function(data, textStatus, xhr) {
                            console.log(xhr.status);
                        },
                        complete: function(xhr, textStatus) {
                            if(xhr.status === 200){
                                window.location.href="/admin/manage-bookings.jsp?bookingId=" + $("#edit_displayid").val();
                            }
                            else{
                                toastr.error("There was an error editing the booking");
                            }
                        } 
                    });
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

    function filterBookingTableById(id){
        $("input[aria-controls]").val(id);
        $("input[aria-controls]").keyup();
    }
</script>
<%@include file="/analytics/analytics.jsp"%>

</body>
</html>
