<%-- 
    Document   : bookingpayment
    Created on : Mar 13, 2013, 2:14:25 AM
    Author     : fayannefoo
--%>
<%@page import="net.sourceforge.stripes.controller.FlashScope"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Make a Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- includes -->
        <%@include file="/protect.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="pragma" content="no-cache"/>
        <meta http-equiv="expires" content="0"/> 
        <meta http-equiv="cache-control" content="no-cache" />

        <!-- stylesheets -->
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">
        <link href="./css/adminia.css" rel="stylesheet"> 
        <link href="./css/adminia-responsive.css" rel="stylesheet"> 
        <link href="./css/residentscustom.css" rel="stylesheet"> 	
        <link href="./css/pages/dashboard.css" rel="stylesheet">  

        <!-- scripts -->
        <script type="text/javascript">
            $(document).bind("mobileinit", function(){
                $.mobile.loadingMessageTextVisible = true;
            }); 

        </script>
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery.mobile-1.1.0.min.js"></script>
        <script src="https://app.zooz.com/mobile/js/zooz-ext-web.js"></script> <!-- Include the ZooZ script that contains the zoozStartCheckout() function -->

        <!--Toastr Popup -->
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <script>
            $(document).ready(function(){
                //populate payment modal
                var booking = new Object();
                booking.userId ='${booking.user.userId}';
                booking.facilityId = '${booking.facility.id}';
                booking.bookingDate = '${booking.bookingTimeStamp}';
                booking.startDate = '${booking.startDate}';
                booking.endDate = '${booking.endDate}';
                booking.title = '${booking.title}';
                booking.level = '${booking.level}';
                booking.unit = '${booking.unit}';
                booking.amount = '${booking.facility.facilityType.bookingFees}';
                
                $("#facility").text("${booking.facility.name}");
                $("#date").text(booking.bookingDate);
                $("#startTime").text(booking.startDate);
                $("#endTime").text(booking.endDate);
                $("#amount").text("$"+ booking.amount);
    
                $('#checkoutButton').click(function() {
                    $.mobile.showPageLoadingMsg("b", "loading", false);
                    $.ajax({
                        url: '/PaymentController?cmd=openTrx'+"&amt="+booking.amount
                            +"&userId="+booking.userId +"&facilityId="+booking.facilityId
                            +"&bookingDate="+booking.bookingDate
                            +"&startDate="+booking.startDate+"&endDate="+booking.endDate
                            +"&title="+booking.title+"&level="+booking.level
                            +"&unit="+booking.unit, // A call to server side to initiate the payment process
                        dataType: 'html',
                        cache: false,
                        success: function(response) {
                            eval(response);
                            var path = window.location.protocol + "//" + window.location.host;
					
                            $.mobile.hidePageLoadingMsg();
					
                            zoozStartCheckout({
                                token : data.token,					// Session token recieved from server
                                uniqueId : "com.livingnet",				// unique ID as registered in the developer portal
                                isSandbox : true,					// true = Sandbox environment
                                returnUrl : path+"/PaymentController",      // return page URL
                                cancelUrl : path+"/residents/index.jsp"			// cancel page URL
						
                            });
                        }
                    });
                
                });
                $('#cancelButton').click(function() {
                    window.location.href="/residents/index.jsp?cancel=true";

                });
            })	;	

        </script>
    </head>
    <body>

        <div id="content">

            <div class="container">

                <div class="row">

                    <div class="span3">

                        <div class="account-container">
                            <!--  <h2>Now Booking</h2> -->


                        </div> <!-- /account-container -->
                        <div class="modal-backdrop fade in"></div>
                        <div id="paymentBookingModal" class="modal fade in">
                            <div id="myModal" class="modal-header">
                                <h3>Confirm Payment</h3>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <b>Facility: </b><span id="facility">
                                    </span><br/>
                                    <b>Date: </b><span id="date"><i><font size="2"> --</font></i></span> <br/>
                                    <b>Start Time: </b><span id="startTime"><i><font size="2"> --</font></i></span><br/>
                                    <b>End Time: </b><span id="endTime"><i><font size="2"> --</font></i></span><br/><br/>
                                    <font size="4"><b>Amount: </b><span id="amount"><i> --</i></span><br/></font>

                                </div>                                
                            </div>
                            <div class="modal-footer">
                                <button id ="cancelButton" class="btn btn-large btn-danger"/>Cancel</a> 
                                <button id ="checkoutButton" class="btn btn-large btn-peace-1"/>Proceed</a>
                            </div>
                        </div>


                    </div> <!-- /span3 -->


                </div> <!-- /container -->

            </div> <!-- /content -->
        </div>

        <%@include file="/footer.jsp"%>
        <script src="./js/bootstrap.js"></script>

</html>
