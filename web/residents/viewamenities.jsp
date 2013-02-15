<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">

        <title>View Amenities | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageAmenityBean" scope="page"
                     class="com.lin.general.admin.ManageAmenityBean"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
            #map_canvas { height: 100% }
        </style>
        <%@include file="/protect.jsp"%>
        <%@include file="/header.jsp"%>

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

        <script type="text/javascript" src="http://gothere.sg/jsapi?sensor=false"> </script>
        <script type="text/javascript">
            
            gothere.load("maps");
            var amenityList = [];
            var map;
            var amenities;
            var geocoder;
            var latlng;
            function initialize() {
                if (GBrowserIsCompatible()) {
                    
                    // Create the Gothere map object.
                    map = new GMap2(document.getElementById("map_canvas"));
                    geocoder = new GClientGeocoder();
                    latlng = new GLatLng(1.326401, 103.862253);
    
                    // Set the center of the map.
                    map.setCenter(latlng, 15);
                    // Add zoom controls on the top left of the map.
                    map.addControl(new GSmallMapControl());
                    // Add a scale bar at the bottom left of the map.
                    map.addControl(new GScaleControl());
                }
                
                amenities = new GAmenities(map, document.getElementById("panel"));
            }
            gothere.setOnLoadCallback(initialize);
            
            function getAmenities(category) {
                map.closeInfoWindow();
                amenities.clear();
                map.clearOverlays();
                var categoryToRequest;
                switch(category) {
                    case "Supermarkets":
                        categoryToRequest = GAmenities.AMENITY_SUPERMARKET;
                        placeMarkers(category);
                        break;
                    case "Clinics":
                        categoryToRequest = GAmenities.AMENITY_CLINIC;
                        placeMarkers(category);
                        break;
                    case "Post Offices":
                        categoryToRequest = GAmenities.AMENITY_POST_OFFICE;
                        placeMarkers(category);
                        break;
                    case "Schools":
                        categoryToRequest = GAmenities.AMENITY_SCHOOL;
                        placeMarkers(category);
                        break;
                    case "ATMs":
                        categoryToRequest = GAmenities.AMENITY_ATM;
                        placeMarkers(category);
                        break;
                    case "Banks":
                        categoryToRequest = GAmenities.AMENITY_BANK;
                        placeMarkers(category);
                        break;
                    case "Petrol Kiosks":
                        categoryToRequest = GAmenities.AMENITY_PETROL_KIOSK;
                        placeMarkers(category);
                        break;
                    case "Bus Stops":
                        categoryToRequest = GAmenities.AMENITY_BUS_STOP;
                        placeMarkers(category);
                        break;
                    case "-":
                    default:
                        placeMarkers(category);
                        break;
                }
                amenities.clearCategories();
                amenities.addCategory(categoryToRequest, GAmenities.LARGE_RESULTSET);
                amenities.load(latlng);

                var pinkIcon = new GIcon(G_DEFAULT_ICON);
                pinkIcon.image = "/img/lin/m_pink.png";
                var markerOptions = { icon:pinkIcon };
                var homeMarker = new GMarker(latlng,markerOptions);

                map.addOverlay(homeMarker);

            }
        
            gothere.setOnLoadCallback(initialize);
            
            function placeMarkers(category){
                console.log(category);
                // Create a geocoder.
                var geocoder = new GClientGeocoder();
                for(var i = 0;i<amenityList.length;i++){
                    console.log(amenityList.length);
                    console.log(amenityList[i].category + "YIPPE");
                    if(category == amenityList[i].category){
                        var name = amenityList[i].name;
                        var streetName = amenityList[i].streetName;
                        var unitNo = amenityList[i].unitNo;
                        var description = amenityList[i].description;
                        var contactNo = amenityList[i].contactNo;
                        
                        // Send a geocoding request.
                        geocoder.getLatLng(streetName, function(latlng) {
                            if (latlng) {
                                // Add a marker to the map.
                                var greenIcon = new GIcon(G_DEFAULT_ICON);
                                var markerOptions = { icon:greenIcon };
                                var marker = new GMarker(latlng);
                                marker.bindInfoWindowHtml("<b>"+name+"</b></br>"+
                                    description+"</br>"+unitNo+" "+streetName+ 
                                    "</br>Tel: " + contactNo);
                                map.addOverlay(marker);
                                
                            }
                        })
                    }
                }
            }
        </script>

    </head>
    <body onload="initialize()">
        <c:forEach items="${manageAmenityBean.amenityList}" var="amenity" varStatus="loop">
            <script>
                var amenity = new Object();
                amenity.name = '${amenity.escapedName}';
                amenity.description = '${amenity.escapedDescription}';
                amenity.unitNo = '${amenity.unitNo}';
                amenity.streetName = '${amenity.streetName}';
                amenity.contactNo = '${amenity.contactNo}';
                amenity.category = '${amenity.amenityCategory.name}';
                amenityList.push(amenity);
            </script>
        </c:forEach>
        <div id="content" style="width:100%; height:100%">

            <div class="container" style="width:100%; height:100%">

                <div class="row" style="width:100%; height:100%">

                    <div class="span3">

                        <div class="account-container" style="margin-left:20px">

                            <h2>View Amenities</h2>
                            <ul class="nav nav-list bs-docs-sidenav affix">
                                <!-- for each category, Print out an LI!-->
                                <c:forEach items = "${manageAmenityBean.categoryListNames}"
                                           var="category" varStatus="loop">
                                    <li>
                                        <a href="#${category}" onclick="getAmenities('${category}');">${category}</a> 
                                    </li>

                                </c:forEach>

                            </ul>

                        </div> <!-- /account-container -->
                    </div>
                    <div class="span9">

                        <h1 class="page-title">
                            <i class="icon-calendar"></i>
                            View Amenities					
                        </h1>
                        <br/>

                        <div class="widget widget-table" style="width:100%; height: 100%">

                            <div class="widget-header">
                                <i class="icon-map-marker"></i>
                                <h3> Map View </h3>

                            </div> <!-- /widget-header -->

                            <div class="widget-content" style="width:100%; height:500px">
                                <div id="map_canvas" style="width:100%; height:100%"></div>
                            </div>
                        </div>


                    </div> <!-- /row -->

                </div> <!-- /container -->

            </div> <!-- /content -->
            <%@include file="/footer.jsp"%>
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