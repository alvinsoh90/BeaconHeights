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
<html lang="en">
    <head>
        <title>Admin | Living Integrated Network</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap.min.css" />
        <link rel="stylesheet" href="../css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="../css/fullcalendar.css" />	
        <link rel="stylesheet" href="../css/unicorn.main.css" />
        <link rel="stylesheet" href="../css/custom/lin.css" />
        <link rel="stylesheet" href="../css/uniform.css" />
        <link rel="stylesheet" href="../css/chosen.css" />	
        <link rel="stylesheet" href="../css/unicorn.grey.css" class="skin-color" />
        <style>.starthidden { display:none; }</style>

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

        <script src="../js/jquery.min.js"></script>
        <script src="../js/jquery.ui.custom.js"></script>
        <script src="../js/bootstrap.min.js"></script>

        <script src="../js/jquery.flot.min.js"></script>
        <script src="../js/jquery.flot.resize.min.js"></script>
        <script src="../js/jquery.peity.min.js"></script>

        <script src="../js/jquery.uniform.js"></script>
        <script src="../js/jquery.chosen.js"></script>
        <script src="../js/jquery.validate.js"></script>

    </head>
    <body onload="showBookings(bookingList)">


        <div id="header">
            <h1><a href="./dashboard.html">Beacon Heights Admin</a></h1>		
        </div>

        <!--<div id="search">
            <input type="text" placeholder="Search here..."/><button type="submit" class="tip-right" title="Search"><i class="icon-search icon-white"></i></button>
        </div> -->

        <div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                <li class="btn btn-inverse" ><a title="" href="#"><i class="icon icon-user"></i> <span class="text">Profile</span></a></li>
                <!--<li class="btn btn-inverse dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">Messages</span> <span class="label label-important">5</span> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a class="sAdd" title="" href="#">new message</a></li>
                        <li><a class="sInbox" title="" href="#">inbox</a></li>
                        <li><a class="sOutbox" title="" href="#">outbox</a></li>
                        <li><a class="sTrash" title="" href="#">trash</a></li>
                    </ul>
                </li> -->
                <li class="btn btn-inverse"><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>
                <li class="btn btn-inverse"><a title="" href="../login.jsp"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
            </ul>
        </div>

        <div id="sidebar">
            <a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
            <ul>
                <li class="submit"><a href="#"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>
                <li class="submenu">
                    <a href="manageusers.jsp"><i class="icon icon-th-list"></i> <span>Users</span>  <span class="right-icon"><i id="users-nav-icon" class="icon icon-chevron-down"></span></i></a>
                    <ul>
                        <li><a href="manageusers.jsp">Manage Users</a></li>
                        <li><a href="approveaccounts.jsp">Approve Pending Accounts</a></li>
                        <!--<li><a href="form-wizard.html">Wizard</a></li> -->
                    </ul>
                </li>
                <li class="submenu">
                    <a href="managefacilities.jsp"><i class="icon icon-th-list"></i> <span>Facilities</span> <span class="right-icon"><i id="users-nav-icon" class="icon icon-chevron-down"></span></i></a>
                    <ul>
                        <li><a href="managefacilities.jsp">Manage Facilities</a></li>
                    </ul>
                </li>
                <li class="submenu active open">
                    <a href="managebookings.jsp"><i class="icon icon-th-list"></i> <span>Bookings</span> <span class="right-icon"><i id="users-nav-icon" class="icon icon-chevron-down"></span></i></a>
                    <ul>
                        <li class ="active"><a href="managebookings.jsp">Manage Bookings</a></li>
                    </ul>
                </li>
            </ul>
        </div>



        <div id="content">
            <div id="content-header">
                <h1> Manage Bookings </h1>
                <div class="btn-group">
                    <a href="approveaccounts.jsp" class="btn btn-large tip-bottom" title="Pending Accounts"><i class="icon-user"></i>
                        <c:if test = "${approveUserBean.tempUserListCount > 0}">
                            <span class="label label-important">${approveUserBean.tempUserListCount}</span>
                        </c:if>
                    </a>
                    <a class="btn btn-large tip-bottom" title="Flagged Comments"><i class="icon-comment"></i><span class="label label-important">5</span></a>
                    <a class="btn btn-large tip-bottom" title="Flagged Events"><i class="icon-calendar"></i></a>
                    <a class="btn btn-large tip-bottom" title="Forms Pending Approval"><i class="icon-file"></i></a>
                    <a class="btn btn-large tip-bottom" title="Feedback & Enquries"><i class="icon-bell"></i></a>
                </div>
            </div>
            <div id="breadcrumb">
                <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
                <a href="#" class="tip-bottom">Bookings</a>
                <a href="#" class="current">Manage Bookings</a>
            </div>
            <div class="container-fluid">

                <div class="row-fluid">
                    <div class="span12">
                        <c:if test = "${param.createsuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> There was an error creating a user. Please try again!
                            </div>
                        </c:if> 
                        <c:if test = "${param.createsuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.createmsg} was added to the user list!
                            </div>
                        </c:if>
                        <c:if test = "${param.deletesuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> ${param.deletemsg}'s booking could not be deleted.
                            </div>
                        </c:if> 
                        <c:if test = "${param.deletesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.deletemsg}'s booking was successfully deleted!
                            </div>
                        </c:if>
                        <c:if test = "${param.paysuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.paymsg}'s payment was updated!
                            </div>
                        </c:if>
                            <c:if test = "${param.paysuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> ${param.paymsg}'s payment could not be updated.
                            </div>
                        </c:if> 

                        <!-- Add New User -->   
                        <div class="widget-box">
                            <div title="Click to add a new user" onclick="loadValidate()" data-target="#collapseTwo" data-toggle="collapse" class="widget-title clickable tip-top" id="newUserForm">
                                <span class="icon">
                                    <i class="icon-plus"></i>									
                                </span>
                                <h5>Add New User</h5>
                            </div>
                            <div class="addUser collapse" id="collapseTwo">
                                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageUsersActionBean" focus="" name="new_user_validate" id="new_user_validate">
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Role</label>
                                        <div class="controls">
                                            <stripes:select name="role">
                                                <stripes:options-collection collection="${manageUsersActionBean.roleList}" value="name" label="name"/>        
                                            </stripes:select>
                                        </div>
                                    </div>

                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Username</label>
                                        <div class="controls">
                                            <stripes:text name="username"/>
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Password</label>
                                        <div class="controls">
                                            <stripes:password name="password" id="password"/>
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Confirm Password</label>
                                        <div class="controls">
                                            <stripes:password  name="passwordconfirm" id="passwordconfirm"/>
                                        </div>
                                    </div>                             
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">First Name</label>
                                        <div class="controls">
                                            <stripes:text name="firstname"/> 
                                        </div>
                                    </div>                              
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Last Name</label>
                                        <div class="controls">
                                            <stripes:text name="lastname"/> 
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Block</label>
                                        <div class="controls">
                                            <stripes:select name="block">
                                                <stripes:options-collection collection="${registerActionBean.allBlocks}" value="blockName" label="blockName"/>        
                                            </stripes:select>
                                        </div>
                                    </div> 
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Level</label>
                                        <div class="controls">
                                            <stripes:text name="level"/>
                                        </div>
                                    </div>     
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Unit Number</label>
                                        <div class="controls">
                                            <stripes:text name="unitnumber"/>
                                        </div>
                                    </div> 

                                    <div class="form-actions">
                                        <input type="submit" name="createUserAccount" value="Add this user" class="btn btn-info btn-large">
                                    </div>                            
                                </stripes:form>

                            </div>
                        </div>						
                    </div>
                    <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon"><i class="icon-user"></i></span><h5>Bookings</h5>
                            <div class="float_r filterOptions"><button class="btn" onClick="filterReset()">View All</button></div>
                            <div class="float_r filterOptions">
                                <h5>or</h5>
                                <select id ="usernameSelect" onChange="filterByUsername()">
                                    <option>-Select Username-</option>
                                    <c:forEach items="${manageBookingsActionBean.userList}" var="user" varStatus="loop">
                                        <option>${user.userName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="float_r filterOptions">
                                <h5>or</h5>
                                <select id ="statusSelect" onChange="filterByStatus()">
                                    <option>-Select Status-</option>
                                    <option>Paid</option>
                                    <option>Pending</option>
                                </select>
                            </div>
                            <div class="float_r filterOptions">
                                <h5> Filter By: </h5>
                                <select id ="facilitySelect" onChange="filterByFacility()">
                                    <option>-Select Facility-</option>
                                    <c:forEach items="${manageBookingsActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                                        <option>${facilityType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
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

                        <div class="widget-content">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="widget-content nopadding">
                                        <ul class="recent-comments"> 
                                            <table id="bookingTable" class="table table-striped users">
                                                <!-- Elements dynamically added in -->
                                            </table>    
                                            <!--<li class="viewall">
                                                <a class="tip-top" href="#" data-original-title="View all comments"> + View all + </a>
                                            </li>-->
                                        </ul>
                                    </div>
                                </div>	
                            </div>							
                        </div>
                    </div>




                </div>

                <div class="row-fluid">
                    <div id="footer" class="span12">

                    </div>
                </div>
            </div>

           
        </div>
        
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

            <!--<script src="js/excanvas.min.js"></script>-->


            <script src="../js/lin.manageusers.js"></script>
            <script src="../js/fullcalendar.min.js"></script>
            <script src="../js/unicorn.js"></script>
            <script src="../js/unicorn.dashboard.js"></script>
            <script src="../js/unicorn.form_common.js"></script>
    </body>

</html>
