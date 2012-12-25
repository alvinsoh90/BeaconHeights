<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>My Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:useBean id="manageBookingsActionBean" scope="page"
                     class="com.lin.general.admin.ManageBookingsActionBean"/>
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

        <!-- Scripts -->
        <script>
            $(document).ready(function(){
                $('#history').hide();
            });


            // Retrieve booking events from DB
            var bookingList = [];
            
            function addEvents(){
                	
                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();
                
                var e = new Object();
                e.title = 'blaaa';
                
                /*
                var event1 = {id: 997,
                    title: 'Repeating Event',
                    start: new Date(y, m, d+1, 16, 0),
                    allDay: false
                };

                var event2 = {id: 998,
                    title: 'Repeating Event',
                    start: new Date(y, m, d+2, 16, 0),
                    allDay: false
                };

                var event3 = {id: 999,
                    title: 'Repeating Event',
                    start: new Date(y, m, d+3, 16, 0),
                    allDay: false
                };*/
            
                var eventSource = bookingList;
                $('#fullcalendar').fullCalendar( 'addEventSource', eventSource );
            }
            // Format into JSON
            // addEventSource
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
                            <h2>View Bookings</h2>
                            <select id ="view">
                                <option value="Current Bookings">Current Bookings</option>
                                <option value="Booking History">Booking History</option>
                            </select>

                        </div> <!-- /account-container -->
                    </div>
                    <div class="span9">

                        <h1 class="page-title">
                            <i class="icon-calendar"></i>
                            My Bookings					
                        </h1>
                        <br/>

                        <div class="widget widget-table">

                            <div class="widget-header">
                                <i class="icon-th-list"></i>
                                <h3> Current Bookings </h3>

                                <script>
                                    function displayVals() {
                                        var singleValues = $("#view").val();
                                        $("h3").html(
                                        singleValues);
                                    }

                                    $("select").change(displayVals);
                                    displayVals();
                                    $("select").change(function() {
                                        if($(this).val() == 'Current Bookings') {
                                            $('#current').show();
                                            $('#history').hide();
                                        }else{
                                            $('#current').hide();
                                            $('#history').show();                                            
                                        }
                                    });

                                </script>
                            </div> <!-- /widget-header -->

                            <div class="widget-content">

                                <table class="table table-striped table-bordered" id="current">
                                    <thead>
                                    <th>No.</th>
                                    <th>Date</th>
                                    <th>Booking Title</th>
                                    <th>Facility</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${manageBookingsActionBean.userCurrentBookingList}" var="booking" varStatus="loop">
                                            <tr>
                                                <td>${booking.id}</td>
                                                <td>${booking.bookingTimeStamp}</td>
                                                <td>${booking.title}</td>
                                                <td>${booking.facility.facilityType.name}</td>
                                                <td>${booking.startDate}</td>
                                                <td>${booking.endDate}</td>
                                                <td><c:out value="${booking.isPaid ? 'Paid': 'Not Paid'}"/>
                                                </td>
                                                <td class="action-td">
                                                    <a href="javascript:;" class="btn btn-small btn-warning">
                                                        <i class="icon-heart"></i>								
                                                    </a>					
                                                    <a href="javascript:;" class="btn btn-small">
                                                        <i class="icon-trash"></i>						
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                </table>

                                <table class="table table-striped table-bordered" id="history">
                                    <thead>
                                    <th>No.</th>
                                    <th>Date</th>
                                    <th>Booking Title</th>
                                    <th>Facility</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    </thead>
                                    <c:forEach items="${manageBookingsActionBean.userHistoricalBookingList}" var="booking" varStatus="loop">
                                        <tr>
                                            <td>${booking.id}</td>
                                            <td>${booking.bookingTimeStamp}</td>
                                            <td>${booking.title}</td>
                                            <td>${booking.facility.facilityType.name}</td>
                                            <td>${booking.startDate}</td>
                                            <td>${booking.endDate}</td>            
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                        <script>
                            var booking = new Object();
                            booking.id = '${booking.id}';
                            booking.start = new Date(${booking.startTimeInSeconds});
                            booking.end = new Date(${booking.endTimeInSeconds});
                            booking.title = 'hi';
                            booking.allDay = false;
                            bookingList.push(booking);
                        </script>
                    </c:forEach>


                </div> <!-- /row -->

            </div> <!-- /container -->

        </div> <!-- /content -->


        <div id="footer">

            <div class="container">				
                <hr>
                <p>&copy; 2012 Go Ideate.</p>
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
