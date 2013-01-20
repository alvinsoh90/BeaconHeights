<!DOCTYPE html>
<html>
    <head>
        <title>View Amenities | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageAmenityBean" scope="page"
                     class="com.lin.general.admin.ManageAmenityBean"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
            html { height: 100% }
            body { height: 100%; margin: 0; padding: 0 }
            #map_canvas { height: 100% }
        </style>
        <script type="text/javascript"
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCcheNxGqIFkGkl_P1eXnTDoWh1n7Pfbak&sensor=false">
        </script>
        <script type="text/javascript">
            function initialize() {
                var mapOptions = {
                    center: new google.maps.LatLng(1.326401, 103.862254),
                    zoom: 14,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById("map_canvas"),
                mapOptions);
            }
        </script>
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">

        <link href="./css/adminia.css" rel="stylesheet"> 
        <link href="./css/adminia-responsive.css" rel="stylesheet"> 
        <link href="./css/residentscustom.css" rel="stylesheet"> 
        <link href="./css/docs.css" rel="stylesheet"> 


        <link rel="stylesheet" href="./css/fullcalendar.css" />	
        <link href="./css/pages/dashboard.css" rel="stylesheet"> 

        <script src="./js/jquery-1.7.2.min.js"></script>
        <%@include file="/protect.jsp"%>
        <%@include file="/header.jsp"%>
    </head>
    <body onload="initialize()">

        <div id="content" style="width:100%; height:100%">

            <div class="container" style="width:100%; height:100%">

                <div class="row" style="width:100%; height:100%">

                    <div class="span3">

                        <div class="account-container" style="margin-left:20px">

                            <h2>View Bookings</h2>
                            <ul class="nav nav-list bs-docs-sidenav affix">
                                <!-- for each category, Print out an LI!-->
                                <c:forEach items = "${manageAmenityBean.categoryList}"
                                           var="category" varStatus="loop">
                                    <li>
                                        <a href="#${category}">${category}</a> 
                                    </li>

                                </c:forEach>

                            </ul>

                        </div> <!-- /account-container -->
                    </div>
                    <div class="span9">

                        <h1 class="page-title">
                            <i class="icon-calendar"></i>
                            My Bookings					
                        </h1>
                        <br/>

                        <div class="widget widget-table" style="width:100%; height: 100%">

                            <div class="widget-header">
                                <i class="icon-th-list"></i>
                                <h3> View Amenities </h3>

                            </div> <!-- /widget-header -->

                            <div class="widget-content" style="width:100%; height:500px">
                                <div id="map_canvas" style="width:100%; height:100%"></div>
                            </div>
                        </div>


                    </div> <!-- /row -->

                </div> <!-- /container -->

            </div> <!-- /content -->

    </body>
</html>