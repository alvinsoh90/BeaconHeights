<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>
<%@include file="/protect.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Users | Strass</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">

    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">        
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Populates the Booking Modals-->
        <script>
            // Init an array of all bookings shown on this page
            var bookingList = [];
            
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
            
            //Loop through bookingList and output all into table for display
            function showBookings(bookingArr){
   
                var r = new Array(), j = -1;
                
                var tableHeaders = "<tr><th>ID</th><th>Username</th><th>Name</th><th>Facility</th><th>Start</th><th>End</th><th>Paid</th><th>Transaction ID</th><th>Action</th></tr>"
                
                for (var i=bookingArr.length-1; i>=0; i--){
                    r[++j] ='<tr><td>';
                    r[++j] = bookingArr[i].id;
                    r[++j] = '</td><td>';
                    r[++j] = bookingArr[i].username;
                    r[++j] = '</td><td >';
                    r[++j] = bookingArr[i].firstName + " " + bookingArr[i].lastName;
                    r[++j] = '</td><td >';
                    r[++j] = bookingArr[i].facilityType + " " + bookingArr[i].facilityId;
                    r[++j] = '</td><td >';
                    r[++j] = bookingArr[i].startDate;
                    r[++j] = '</td><td >';
                    r[++j] = bookingArr[i].endDate;
                    r[++j] = '</td><td >';

                    if(bookingArr[i].isPaid == "true"){
                        r[++j] = "Paid";
                    }else{
                        r[++j] = "Pending";
                    }
                    
                    r[++j] = '</td><td >';
                    r[++j] = bookingArr[i].transactionID;
                    r[++j] = '</td><td >';
                    
                    if(bookingArr[i].isPaid == "true"){
                        r[++j] = "<a href= '#' role='button' data-toggle='modal' class='btn btn-primary btn-mini'>Edit</a>\n\
                               <a href='#pendingBookingModal' role='button' data-toggle='modal' class='btn btn-info btn-mini' onclick='populatePendingBookingModal(" + bookingList[i].id + ")'>Pending</a>\n\
                               <a href='#deleteBookingModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteBookingModal(" + bookingList[i].id + ")'>Delete</a>";
                    }else{
                        r[++j] = "<a href= '#' role='button' data-toggle='modal' class='btn btn-primary btn-mini'>Edit</a>\n\
                               <a href='#payBookingModal' role='button' data-toggle='modal' class='btn btn-success btn-mini' onclick='populatePayBookingModal(" + bookingList[i].id + ")'>Paid</a>\n\
                               <a href='#deleteBookingModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteBookingModal(" + bookingList[i].id + ")'>Delete</a>";
                    }
                    r[++j] = '</td></tr>';
                }
                $('#bookingTable').html(tableHeaders + r.join('')); 
            }
            
            // This method is used to filter the booking list shown to admin
            // when the filter selection is chosen
            function filterByUsername(){
                var username = $('#usernameSelect').val();
                
                var tempArr = [];
                
                for(var i=0;i<bookingList.length;i++){
                    console.log(name);
                    if(bookingList[i].username == username){
                        tempArr.push(bookingList[i]);
                    }
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No bookings found!");
                }
                else{
                    showBookings(tempArr);
                }
            }
            
            function filterByFacility(){
                var facilityType = $('#facilitySelect').val();
                
                var tempArr = [];
                
                for(var i=0;i<bookingList.length;i++){
                    console.log(name);
                    if(bookingList[i].facilityType == facilityType){
                        tempArr.push(bookingList[i]);
                    }
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No bookings found!");
                }
                else{
                    showBookings(tempArr);
                }
            }
            
            function filterByStatus(){
                var status = $('#statusSelect').val();
                
                var tempArr = [];
                
                if(status == "Paid"){
                
                    for(var i=0;i<bookingList.length;i++){
                        console.log(name);
                        if(bookingList[i].isPaid == "true"){
                            tempArr.push(bookingList[i]);
                        }
                    }
                    
                }else{
                    for(var i=0;i<bookingList.length;i++){
                        console.log(name);
                        if(bookingList[i].isPaid == "false"){
                            tempArr.push(bookingList[i]);
                        }
                    }
                    
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No bookings found!");
                }
                else{
                    showBookings(tempArr);
                }
                
                
            }
            
            function filterReset(){
                showBookings(bookingList);
            }
        </script>
        <%--Load up bookings --%>
        <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                            <script>
                                var booking = new Object();
                                booking.id = '${booking.id}';
                                booking.username = '${booking.user.userName}';
                                booking.firstName = '${booking.user.firstname}';
                                booking.lastName = '${booking.user.lastname}';
                                booking.facilityType = '${booking.facility.facilityType.name}';
                                booking.facilityId = '${booking.facility.id}';
                                booking.startDate = '${booking.startDate}';
                                booking.endDate = '${booking.endDate}';
                                booking.isPaid = '${booking.isPaid}';
                                booking.transactionID = '${booking.transactionId}';
                                bookingList.push(booking);
                            </script>

                        </c:forEach>
                            
  </head>
  <body onload="showBookings(bookingList)">
      
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
                      
                      <div class='userFilterBar float_r'>
                          <h5 class="inlineblock"> Filter By: </h5>
                            <div class="inlineblock filterOptions">
                                <select id ="usernameSelect" onChange="filterByUsername()">
                                    <option>-Select Username-</option>
                                    <c:forEach items="${manageBookingsActionBean.userList}" var="user" varStatus="loop">
                                        <option>${user.userName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="inlineblock filterOptions">
                                <h5 class="inlineblock">or</h5>
                                <select id ="statusSelect" onChange="filterByStatus()">
                                    <option>-Select Status-</option>
                                    <option>Paid</option>
                                    <option>Pending</option>
                                </select>
                            </div>
                            <div class="inlineblock filterOptions">
                                <h5 class="inlineblock">or</h5>                                
                                <select id ="facilitySelect" onChange="filterByFacility()">
                                    <option>-Select Facility-</option>
                                    <c:forEach items="${manageBookingsActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                                        <option>${facilityType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                          <div class="inlineblock filterOptions"><button class="btn" onClick="filterReset()">View All</button></div>                          
                      </div>
                      
			<table id="bookingTable" class="table table-striped table-bordered table-condensed">
				
			</table>
			<div class="pagination">
				<ul>
					<li><a href="#">Prev</a></li>
					<li class="active">
						<a href="#">1</a>
					</li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">Next</a></li>
				</ul>
			</div>
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
                <h3>Update Payment of <span id="usernamePayLabel"></span>'s booking</h3>
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
                <h3>Update Payment of <span id="usernamePendingLabel"></span>'s booking</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.PayBookingBean" focus=""> 
                    You are now changing booking status to pending. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <stripes:hidden id="pending_username" name="username"/>
                    <stripes:hidden id="pending_id" name="id"/>
                    <input type="submit" name="payBooking" value="Change to Pending" class="btn btn-primary"/>
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

    </div>

    <script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
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
  </body>
</html>