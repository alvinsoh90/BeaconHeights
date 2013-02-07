<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>My Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageBookingsActionBean" scope="page"
                     class="com.lin.general.admin.ManageBookingsActionBean"/>
        <jsp:setProperty name = "manageBookingsActionBean"  property = "currentUser"  value = "${user}" />
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
        <script src="./js/unicorn.calendar.js"></script>
        <script src="./js/jquery-1.7.2.min.js"></script>
        <!-- Scripts -->

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script>
            
            var bookingList = [];
            
            //populate delete booking modal
            function populateDeleteBookingModal(bookingID){ 
                bookingList.forEach(function(booking){
                    if(booking.id == bookingID){
                        console.log(booking.id);
                        $("#delete_facilityType").text(booking.facilityType);
                        $("#delete_startDate").text(booking.startDate);
                        $("#delete_endDate").text(booking.endDate);
                        $("#delete_id").val(booking.id);
                    }
                });
            }
        </script>

        <!--populate user current bookings -->
        <c:forEach items="${manageBookingsActionBean.userCurrentBookingList}" var="booking" varStatus="loop">
            <script>
                var booking = new Object();
                booking.id = '${booking.id}';
                booking.facilityType = '${booking.facility.facilityType.name}';
                booking.startDate = '${booking.startDate}';
                bookingList.push(booking);
            </script>
        </c:forEach>
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
                                    ( function($) {
                                        $(document).ready( function() { 
                                            $('#history').hide();
                                        } );
                                    } ) ( jQuery );
                                    
                                    function displayVals() {
                                        var singleValues = $("#view").val();
                                        $("h3").html(singleValues);
                                    }

                                    $("select").change(displayVals);
                                    displayVals();
                                    $("select").change(function() {
                                        if($(this).val() == 'Current Bookings') {
                                            $('#current').show();
                                            $('#history').hide();
                                        }else{
                                            $('#history').show();                                            
                                            $('#current').hide();
                                        }
                                    });

                                </script>
                            </div> <!-- /widget-header -->

                            <div class="widget-content">

                                <table class="table table-striped table-bordered" id="current">
                                    <c:if test="${manageBookingsActionBean.userCurrentBookingList.size()!=0}">     
                                        <thead>
                                        <th>No.</th>
                                        <th>Booking Placed</th>
                                        <th>Event</th>
                                        <th>Facility</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Status</th>
                                        <th>Payment</th>
                                        <th>Action</th>
                                        </thead>
                                        <tbody style="font-size: 11px">
                                            <%int count = 1;%>
                                            <c:forEach items="${manageBookingsActionBean.userCurrentBookingList}" var="booking" varStatus="loop">
                                                <tr>
                                                    <td><%= count++%></td>
                                                    <td nowrap><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                    value="${booking.bookingTimeStamp}"/></td>
                                                    <td nowrap>${booking.title}</td>
                                                    <td nowrap>${booking.facility.name}</td>
                                                    <td nowrap><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                    value="${booking.startDate}"/></td>
                                                    <td nowrap><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                    value="${booking.endDate}"/></td> 
                                                    <td><c:if test= "${booking.isDeleted == 'true'}"><font color="red">Deleted</font></c:if>
                                                        <c:if test= "${booking.isDeleted == 'false'}"><font color="green">Confirmed</font></c:if>
                                                    </td>
                                                    <td><c:if test= "${booking.isDeleted == 'true'}">
                                                            -
                                                        </c:if>
                                                        <c:if test= "${booking.isDeleted == 'false'}">
                                                            <c:if test= "${booking.facility.facilityType.needsPayment == 'true'}">
                                                                <c:out value="${booking.isPaid ? 'Paid': 'Not Paid'}"/>
                                                            </c:if>
                                                            <c:if test= "${booking.facility.facilityType.needsPayment == 'false'}">
                                                                N/A
                                                            </c:if>

                                                        </c:if>
                                                        </td>
                                                        <td class="action-td">
                                                            <c:if test= "${booking.isDeleted == 'true'}">
                                                                -
                                                            </c:if>
                                                            <c:if test= "${booking.isDeleted == 'false'}">
                                                                <a href="#deleteBookingModal" role ="button" data-toggle="modal" 
                                                                   class="btn btn-small btn-warning"
                                                                   onclick="populateDeleteBookingModal(${booking.id})">
                                                                    <i class="icon-remove"></i>							
                                                                </a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${manageBookingsActionBean.userCurrentBookingList.size()==0}">
                                        <thead>
                                        <th> You have no current bookings</th>
                                        </thead>
                                    </c:if>
                                </table>


                                <table class="table table-striped table-bordered" id="history">
                                    <c:if test="${manageBookingsActionBean.userHistoricalBookingList.size()!=0}">     
                                        <thead>
                                        <th>No.</th>
                                        <th>Booking Placed</th>
                                        <th>Event</th>
                                        <th>Facility</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        </thead>

                                        <% int countHistory = 1;%>
                                        <tbody style="font-size: 11px">
                                        <c:forEach items="${manageBookingsActionBean.userHistoricalBookingList}" var="booking" varStatus="loop">
                                            <tr>
                                                <td><%=countHistory++%></td>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                value="${booking.bookingTimeStamp}"/></td>
                                                <td>${booking.title}</td>
                                                <td>${booking.facility.facilityType.name} </td>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                value="${booking.startDate}"/></td>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                                value="${booking.endDate}"/></td>            
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                        </tbody>
                                    <c:if test="${manageBookingsActionBean.userHistoricalBookingList.size()==0}">
                                        <thead>
                                        <th> You have no bookings</th>
                                        </thead>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>


                </div> <!-- /row -->

            </div> <!-- /container -->

        </div> <!-- /content -->

        <div id="deleteBookingModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Delete Booking</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageBookingsActionBean" focus=""> 
                    You are now deleting the booking of <b><span id="delete_facilityType"></span> on <b><span id="delete_startDate"></span></b>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <jsp:setProperty name = "manageBookingsActionBean"  property = "id"  value = "${booking.id}" />
                    <stripes:hidden id="delete_id" name="id"/>
                    <stripes:submit class="btn btn-danger" name="deleteBooking" value="Delete"/>                                                           						
                </div>
            </stripes:form>
        </div>

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
