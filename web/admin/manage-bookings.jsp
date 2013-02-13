<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>
<jsp:useBean id="manageFacilitiesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilitiesActionBean"/>


<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Bookings</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">        
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="js/jquery.js"></script>        
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>

        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Booking Modals-->
        <script>
            
            //an array of all bookings shown on this page
            var bookingList = [];
            
            $(document).ready(function() {

                $('#bookingTable').dataTable( {
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                } );
            });
 
                
            //when this function is called, bookingList should already be populated
            function populateDeleteBookingModal(bookingID){ 
                bookingList.forEach(function(booking){
                    if(booking.id == bookingID){
                        $("#usernameDeleteLabel").text(booking.username);
                        $("#delete_username").val(booking.username);
                        $("#delete_firstName").text(booking.firstName);
                        $("#delete_lastName").text(booking.lastName);
                        $("#delete_facilityType").text(booking.facilityType);
                        $("#delete_facilityId").text(booking.facilityId);
                        $("#delete_startDate").text(booking.startDate);
                        $("#delete_endDate").text(booking.endDate);
                        $("#delete_id").val(booking.id);
                    }
                });
                
            }
            
            function populateEditBookingModal(bookingID){ 
                console.log("REACHED");
                bookingList.forEach(function(booking){
                    if(booking.id == bookingID){
                        $("#usernameEditLabel").text(booking.username);
                        $("#edit_username").val(booking.username);
                        $("#edit_facilityType").text(booking.facilityType);
                        $("#edit_facilityId").text(booking.facilityId);
                        $("#edit_startDate").val(booking.startDate);
                        $("#edit_endDate").val(booking.endDate);
                        $("#edit_id").val(booking.id);
                        $("#edit_displayid").val(booking.id);
                    }
                });
                
            }

            
            function populatePayBookingModal(bookingID){ 
                bookingList.forEach(function(booking){
                    if(booking.id == bookingID){
                        $("#usernamePayLabel").text(booking.username);
                        $("#pay_username").val(booking.username);
                        $("#pay_id").val(booking.id);
                    }
                });
                
            }
            function populatePendingBookingModal(bookingID){ 
                bookingList.forEach(function(booking){
                    if(booking.id == bookingID){
                        $("#usernamePendingLabel").text(booking.username);
                        $("#pending_username").val(booking.username);
                        $("#pending_id").val(booking.id);
                    }
                });
                
            }
            
            

        </script>

        <%--Load up bookings --%>
        <c:if test="${manageBookingsActionBean.bookingList.size()!=0}">   
            <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                <script>
                    var booking = new Object();
                    booking.id = '${booking.id}';
                    booking.username = '${booking.user.escapedUserName}';
                    booking.firstName = '${booking.user.escapedFirstName}';
                    booking.lastName = '${booking.user.escapedLastName}';
                    booking.facilityType = '${booking.facility.escapedName}';
                    booking.facilityId = '${booking.facility.id}';
                    booking.startDate = '${booking.startDate}';
                    booking.endDate = '${booking.endDate}';
                    booking.isDeleted = '${booking.isDeleted}';
                    booking.isPaid = '${booking.isPaid}';
                    booking.transactionID = '${booking.transactionId}';
                    bookingList.push(booking);
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
                        <h1>Bookings <small>View and manage current facility bookings</small></h1>
                    </div>

                    <table id="bookingTable" class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Name</th>
                                <th>Facility</th>
                                <th>Start</th>
                                <th>End</th>
                                <th>Status</th>
                                <th>Paid</th>
                                <th>Transaction ID</th>
                                <th nowrap>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                                <tr>
                                    <td>${booking.id}</td>
                                    <td nowrap>${booking.user.escapedUserName}</td>
                                    <td >${booking.user.escapedFirstName} ${booking.user.escapedLastName}</td>
                                    <td nowrap>${booking.facility.escapedName}</td>

                                    <td><fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                                    value="${booking.startDate}"/></td>
                                    <td><fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                                    value="${booking.endDate}"/></td>

                                    <c:choose>
                                        <c:when test="${booking.isDeleted == 'true'}">
                                            <td><font color="red">Deleted</font></td>
                                            <td>-</td>
                                            <td >-</td>
                                            <td>-</td>
                                        </c:when>

                                        <c:when test="${booking.facility.facilityType.needsPayment == 'false'}">
                                            <td><font color="green">Confirmed</font></td>
                                            <td>NA</td>
                                            <td >NA</td>
                                            <td>
                                                <div class="btn-group" style="visibility:visible !important;">
                                                    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="#editBookingModal" role="button" data-toggle="modal" onclick="populateEditBoookingModal('${booking.id}');loadValidate()"><i class="icon-pencil"></i> Edit</a></li>
                                                        <li><a href="#deleteBookingModal" role="button" data-toggle="modal" onclick="populateDeleteBookingModal('${booking.id}')"><i class="icon-trash"></i> Delete</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </c:when>
                                        <c:when test="${booking.isPaid=='true'}">
                                            <td><font color="green">Confirmed</font></td>
                                            <td>Revert</td>
                                            <td>${booking.transactionId}</td>
                                            <td>
                                                <div class="btn-group" style="visibility:visible !important;">
                                                    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="#editBookingModal" role="button" data-toggle="modal" onclick="populateEditBoookingModal('${booking.id}');loadValidate()"><i class="icon-pencil"></i> Edit</a></li>
                                                        <li><a href="#pendingBookingModal" role="button" data-toggle="modal" onclick="populatePendingBookingModal('${booking.id}')"><i class="icon-refresh"></i> Revert</a></li>
                                                        <li><a href="#deleteBookingModal" role="button" data-toggle="modal" onclick="populateDeleteBookingModal('${booking.id}')"><i class="icon-trash"></i> Delete</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><font color="green">Confirmed</font></td>
                                            <td>Pending</td>
                                            <td>-</td>
                                            <td>
                                                <div class="btn-group" style="visibility:visible !important;">
                                                    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="#editBookingModal" role="button" data-toggle="modal" onclick="populateEditBoookingModal('${booking.id}');loadValidate()"><i class="icon-pencil"></i> Edit</a></li>
                                                        <li><a href="#payBookingModal" role="button" data-toggle="modal" onclick="populatePayBookingModal('${booking.id}')"><i class="icon-check"></i> Record</a></li>
                                                        <li><a href="#deleteBookingModal" role="button" data-toggle="modal" onclick="populateDeleteBookingModal('${booking.id}')"><i class="icon-trash"></i> Delete</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </c:otherwise> 
                                    </c:choose>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <a href="#" class="btn btn-success">New Booking</a>
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
        <div id="editBookingModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Edit <span id="usernameEditLabel"></span>'s booking</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditBookingBean" focus="" id="edit_booking_validate" name="edit_booking_validate">
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Booking ID</label>

                        <div class="controls">
                            <stripes:text id="edit_displayid" name="displayid" disabled="true"/>
                            <stripes:hidden id="edit_id" name="id"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Start Time</label>
                        <div class="controls">
                            <stripes:text id="edit_startDate" name="startDate"/> 
                        </div>
                    </div>    
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">End Time</label>
                        <div class="controls">
                            <stripes:text id="edit_endDate" name="endDate"/> 
                        </div>
                    </div>                              
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <input type="submit" name="editBooking" value="Confirm Edit" class="btn btn-primary"/>
                </div>
            </stripes:form>
        </div>


        <!-- Delete Booking Modal -->
        <div id="deleteBookingModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Deletion of <span id="usernameDeleteLabel"></span>'s booking</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteBookingBean" focus=""> 
                    You are now deleting <b><span id="delete_firstName"></span> <span id="delete_lastName"></span>'s</b> booking of <b><span id="delete_facilityType"></span> <span id="delete_facilityId"></span></b> on <b><span id="delete_startDate"></span></b>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <stripes:hidden id="delete_username" name="username"/>
                    <stripes:hidden id="delete_id" name="id"/>
                    <input type="submit" name="deleteBooking" value="Confirm Delete" class="btn btn-danger"/>
                </div>
            </stripes:form>
        </div>


        <script src="js/bootstrap.min.js"></script>

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

    </body>
</html>
