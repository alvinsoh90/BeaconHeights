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

        <!-- Scripts -->
        <script>
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
                            <h2>Now Booking</h2>
                            <select id ="choosefacility">
                                <c:forEach items="${manageFacilitiesActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                                    <option value="${facilityType.name}">${facilityType.name}</option>
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
                                    Date: <span id="date"><i><font size="2"> --</font></span> <br/>
                                    Time: <span id="time"><i><font size="2"> --</font></i></span>
                                </div>
                                
                                <!--This is the form used to parse the facility type over to the action bean -->
                                <stripes:form beanclass="com.lin.general.admin.ManageBookingsActionBean" id="ftype" focus="">
                                    <stripes:text name="facilityType" id="facilitytype" />
                                </stripes:form>

                                <div class="inviteFriends comingsoon">
                                    <div class="header">Invite Friends</div>
                                    <input class="span2" type="text" placeholder="Type a friend's name"/>
                                    <button class="btn btn-peace-2 btnmod">Invite</button>
                                    <!--Invited: 
                                    <span class="inviteLabel label label-success"></span>-->                             
                                </div>
                                <div class="shareBooking centerText comingsoon">
                                    <h4>Share this event with your friends</h4>
                                    <!--<button class="socialIcons iconFacebook icon-facebook"></button> -->
                                </div>
                                <stripes:form beanclass="com.lin.facilitybooking.BookFacilityActionBean" focus="">
                                    <stripes:text name="facilityID" id="facilityid" class="hide" />
                                    <stripes:text name="startDateString" id="starttimemillis" class="hide" />   
                                    <stripes:text name="endDateString" id="endtimemillis" class="hide"  /> 
                                    <stripes:text name="title" id="title" class="hide"/>
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
                            Current Bookings :
                            <span id ="sub">${param.ftype} </sub> </h1>
                            <!-- I'm using this to field to store the param, so that I can use jquery to populate the other booking details-->
                        </h1>
                        <br/>
                    </div>	


                    <!--To display facility selected in the dropdown box, in the booking details-->                    
                    <script>      
                        function displayVals() {
                            var singleValues = $("select").val();
                            $("#venue").html(singleValues);
                            $("#sub").html(singleValues);
                            $("#facilitytype").val(singleValues);
                        }
                        $("select").change(displayVals);
                        //displayVals;
                        $("select").change(function(){
                            document.forms["ftype"].submit();
                        });

                        
                    </script>

                    <!-- Check if the parameter is empty, if it is not, then reload the fields using the param value-->
                    <c:if test="${not empty param.ftype}">
                        <script>
                            function loadFtype() {
                                var singleValues = $('#sub').html();
                                $("#venue").html(singleValues);
                                $("#sub").html(singleValues);
                                $("select").val("BB").attr("selected", "selected");
                                $("#facilitytype").val($("select").val());
                                alert($('#facility').contains(singleValues));   
                            }
                            loadFtype();
                        </script>
                    </c:if>


                    <div class="span9">
                        <div class="widget-content nopadding calendarContainer">
                            <div id="fullcalendar" class="calendarWidth"></div>
                        </div>
                    </div>


                    <!-- Need to set facilityType, as when page reloads, when you get bookingListByFacilityType, the facility type is null-->
                    <jsp:setProperty name = "manageBookingsActionBean"  property = "facilityType"  value = "${param.ftype}" />
                    <c:if test= "${manageBookingsActionBean.allBookingsByFacilityType.size()
                                   !=0}">
                        <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                            <script>
                                var booking = new Object();
                                booking.id = '${booking.id}';
                                booking.start = new Date(${booking.startTimeInSeconds});
                                booking.end = new Date(${booking.endTimeInSeconds});
                                booking.title = '${booking.title}';
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
