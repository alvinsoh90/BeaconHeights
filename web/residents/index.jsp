<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Make a Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:useBean id="manageBookingsActionBean" scope="page"
                     class="com.lin.general.admin.ManageBookingsActionBean"/>
        <jsp:useBean id="manageFacilitiesActionBean" scope="page"
                     class="com.lin.general.admin.ManageFacilitiesActionBean"/>
        <%@include file="/protect.jsp"%>
        <%@include file="/header.jsp"%>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    

        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">

        <link href="./css/adminia.css" rel="stylesheet"> 
        <link href="./css/adminia-responsive.css" rel="stylesheet"> 
        <link href="./css/residentscustom.css" rel="stylesheet"> 

        <link rel="stylesheet" href="./css/fullcalendar.css" />	
        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="./js/unicorn.calendar.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <!-- Scripts -->
        <script>
            // Retrieve booking events from DB
            var bookingList = [];
            
            function showFacilityBookingsByFacilityID(facilityID){
                //this method is called when page is fully loaded, 
                //bookingList is populated as page loads
                
                //                var eventSource = bookingList;
                //                $('#fullcalendar').fullCalendar( 'addEventSource', eventSource );
                
                //clear previous events
                $('#fullcalendar').fullCalendar( 'removeEvents');
                
                //add new event source
                var eventSource = "/json/bookingevents.jsp?facilityid=" 
                    + facilityID +"&userid="+${sessionScope.user.userId};
                
                $('#fullcalendar').fullCalendar( 'addEventSource', eventSource );               
            }
        </script> 

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

    </head>

    <body>



        <div id="content">

            <div class="container">

                <div class="row">

                    <div class="span3">

                        <div class="account-container">
                            <h2>Now Booking</h2>
                            <select id ="facilityDropDown">
                                <c:forEach items="${manageFacilitiesActionBean.facilityList}" var="facility" varStatus="loop">
                                    <option value="${facility.id}">${facility.name}</option>
                                </c:forEach>
                            </select>

                        </div> <!-- /account-container -->

                        <hr />

                        <ul id="main-nav" class="nav nav-tabs nav-stacked">
                            <h2>Your Booking Details</h2>
                            <div class="widget-content widget-nopad">
                                <div class="bookingDetails">
                                    Venue: <span id="venue">Choose facility
                                    </span><br/>
                                    Date: <span id="date"><i><font size="2"> --</font></i></span> <br/>
                                    Time: <span id="time"><i><font size="2"> --</font></i></span>
                                </div>
                                <!--<div class="inviteFriends comingsoon">
                                    <div class="header">Invite Friends</div>
                                    <input class="span2" type="text" placeholder="Type a friend's name"/>
                                    <button class="btn btn-peace-2 btnmod">Invite</button>
                                <!--Invited: 
                                <span class="inviteLabel label label-success"></span>                         
                            </div>
                            <div class="shareBooking centerText comingsoon">
                                <h4>Share this event with your friends</h4>-->
                                <!--<button class="socialIcons iconFacebook icon-facebook"></button>
                            </div>-->
                                <stripes:form beanclass="com.lin.facilitybooking.BookFacilityActionBean" focus="">
                                    <stripes:hidden name="facilityID" id="facilityid" />
                                    <stripes:hidden name="startDateString" id="starttimemillis"  />   
                                    <stripes:hidden name="endDateString" id="endtimemillis"   /> 
                                    <stripes:text name="title" id="title" value="Enter an optional event name"/>
                                    <stripes:hidden name="currentUserID" id="userID" value='${sessionScope.user.userId}'/> 
                                 
                                    <div class="centerText">
                                        <stripes:submit class="inlineblock btn-large btn btn-peace-1" name="placeBooking" value="Place Booking"/>
                                    </div>
                                </div>
                            </stripes:form>

                            <hr />

                            <div class="sidebar-extra">
                                <!--<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.</p>-->
                            </div>  <!-- .sidebar-extra -->

                            <br />

                    </div> <!-- /span3 -->


                    <div class="span9">

                        <h1 class="page-title">
                            <i class="icon-home"></i>

                            <span id ="sub"></span> 
                            Bookings
                            <span id ="legend">
                                <i class="icon-stop" style="color: #E0BEC1"></i> Your booking (awaiting payment) &nbsp;
                                <i class="icon-stop" style="color: #206F77"></i> Your booking (paid)</span>

                        </h1>
                        <br/>
                    </div>	

                    <script>
                        $(document).ready(function(){
                            // To display facility selected in the dropdown box, in the booking details
                            function displayVals() {
                                var singleValues = $("#facilityDropDown option:selected").text();

                                //set venue texts
                                $("#venue").text(singleValues); 
                                $("#sub").text(singleValues);  
                                //set hidden field facility id
                                $("#facilityid").val($("#facilityDropDown").val());

                                //reload calendar when dropdown is changed
                                var currFacilityID = $("#facilityDropDown option:selected").val();
                                showFacilityBookingsByFacilityID(currFacilityID);
                            }
                            //attach handler
                            $("#facilityDropDown").change(displayVals);
                            
                            // if there is a specific facility's booking to load, then 
                            // change the dropdown to the correct facility
                            var facilityID = "${param.fid}";

                            if (facilityID != ""){
                                $("#facilityDropDown").val("${param.fid}");
                            }
                            //  display default bookings as per whats in the dropdown
                            displayVals();
                        });
                        
                        //if successful booking, show message
                        var successBookingID = "${SUCCESS}";
                        var failure = "${FAILURE}";
                        if(successBookingID != ""){
                            toastr.success("Your booking is confirmed. Booking ID: " + successBookingID);
                        }
                        else if(failure){
                            var msg = "<b>There was an error with your booking.</b><br/>";
                            msg += "<ol>"
                            <c:forEach var="message" items="${MESSAGES}">
                                msg += "<li>${message}</li>";
                            </c:forEach>
                            msg += "</ol>";    
                            toastr.errorSticky(msg);
                        }
                        
                    </script>
                       
                    
                    <div class="span9">
                        <div class="widget-content nopadding calendarContainer">
                            <div id="ajax-spinner" class="ajaxSpinner hide"></div>
                            <div id="fullcalendar" class="calendarWidth"></div>
                        </div>
                        <c:if test="${manageBookingsActionBean.bookingList.size()!=0}">     
                            <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                                <script>
                                    var booking = new Object();
                                    booking.id = '${booking.id}';
                                    booking.start = new Date(${booking.startTimeInSeconds});
                                    booking.end = new Date(${booking.endTimeInSeconds});
                                    booking.title 
                                        = '${booking.facility.facilityType.name} ${booking.facility.id}';
                                    booking.allDay = false;
                                    bookingList.push(booking);
                                </script>
                            </c:forEach>
                        </c:if>

                    </div> <!-- /row -->

                </div> <!-- /container -->

            </div> <!-- /content -->


            <div id="footer">

                <div class="container">				
                    <hr>
                    <p>Beacon Heights Condominium</p>
                </div> <!-- /container -->

            </div> <!-- /footer -->


            <!-- Le javascript
            ================================================== -->
            <!-- Placed at the end of the document so the pages load faster -->

            <script src="./js/excanvas.min.js"></script>
            <script src="./js/jquery.flot.js"></script>
            <script src="./js/jquery.flot.pie.js"></script>
            <script src="./js/jquery.flot.orderBars.js"></script>
            <script src="./js/jquery.flot.resize.js"></script>
            <script src="./js/fullcalendar.min.js"></script>

            <script src="./js/bootstrap.js"></script>
            <script src="./js/charts/bar.js"></script>

    </body>
</html>
