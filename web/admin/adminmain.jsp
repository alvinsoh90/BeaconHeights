<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageFacilitiesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilitiesActionBean"/>
<jsp:useBean id="manageEventBean" scope="page"
             class="com.lin.resident.ManageEventBean"/>
<jsp:useBean id="managePostBean" scope="page"
             class="com.lin.resident.ManagePostBean"/>
<jsp:useBean id="manageEnquiryActionBean" scope="page"
             class="com.lin.resident.ManageEnquiryActionBean"/>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>

<%@include file="/protectadmin.jsp"%>
<%@include file="/analytics/analytics.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin Main | Living Integrated Network</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <script src="js/jquery.js"></script>  
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        <script src="http://d3js.org/d3.v3.min.js"></script>
        <link href="/css/font-awesome.min.css" rel="stylesheet">
        
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

<!--        G3 styles-->
        
        <style>

/*        body {
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        position: relative;
        width: 960px;
        }*/

        .axis text {
        font: 10px sans-serif;
        }

        .axis path,
        .axis line {
        fill: none;
        stroke: #000;
        shape-rendering: crispEdges;
        }

        .bar {
        fill: steelblue;
        fill-opacity: .9;
        }

        .x.axis path {
        display: none;
        }

        label {
        position: absolute;
        top: 10px;
        right: 10px;
        }
        
        .line {
        fill: none;
        stroke: steelblue;
        stroke-width: 1.5px;
        }
        h3{
            text-align: center;
        }
        h2.analyticsHeader{
            color: #0D361A;
            text-align: center;
        }
        div.weekly-stats{
            margin-top: 8px;
            text-align: center;
            font-size: 30px;
            line-height: 36px;
            color: #0D361A;
            font-weight: bold;
        }
        div.analyticsHeader{
            text-align: center;
        }
        span.weekly-gain{
            color:#21fc00;
            font-size: 25px;
            margin-left: 10px;
            font-weight: normal;
        }
        span.weekly-loss{
            color:#f90025;
            font-size: 25px;
            margin-left: 10px;
            font-weight: normal;
        }
        span.weekly-no-change{
            font-size: 18px;
            margin-left: 1px;
            font-weight: normal;
        }
        i.weekly-gain{
            margin-top: 9px; 
            color: #21fc00;
        }
        i.weekly-loss{
            margin-top: 9px; 
            color: #f90025;
        }
        a.badge-urgent{
            padding: 1px 15px 2px;
            font-size: 13px;
            line-height: 18px;
            background-color: #f90025;
        }
        
        </style>
        
        <!-- Populates the Edit User form -->
        <script>
            // Init an array of all users shown on this page
            var userList = [];
            
            
            $(document).ready(function(){
                var success = "${SUCCESS}";
                var failure = "${FAILURE}";
                if(success != ""){
                    toastr.success(success);
                }
                else if(failure){
                    var msg = "<b>There was an error processing your request.</b><br/>";
                    msg += "<ol>"
                <c:forEach var="message" items="${MESSAGES}">
                        msg += "<li>${message}</li>";
                </c:forEach>
                    msg += "</ol>";    
                    toastr.errorSticky(msg);
                }
                
                loadBookingsGraph();
                loadEventsGraph();
                loadPostsGraph();

            });
        </script>

    </head>
    <body>
        <%@include file="include/mainnavigationbar.jsp"%>

        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <div class="page-header">
                        <h1>LivingNet <small>Urgent Matters</small></h1>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span3 analyticsHeader">
                        <h3>User Pending Approval</h3>
                        <p><a href="approveusers.jsp" class="badge badge-urgent">${approveUserBean.tempUserListCount}</a></p>
                    </div>
                    <div class="span3 analyticsHeader">
                        <h3>Flagged Posts</h3>
                        <p><a href="manage-posts.jsp" class="badge badge-urgent">${managePostBean.numberOfFlaggedPosts}</a></p>
                    </div>
                    <div class="span3 analyticsHeader">
                        <h3>Flagged Events</h3>
                        <p><a href="manage-events.jsp" class="badge badge-urgent">${manageEventBean.numberOfFlaggedEvents}</a></p>
                    </div>
                    <div class="span3 analyticsHeader">
                        <h3>Unresolved Enquiries</h3>
                        <p><a href="manage-enquiries.jsp" class="badge badge-urgent">${manageEnquiryActionBean.numberOfUnresolvedEnquiries}</a></p>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="page-header">
                        <h1><small>Weekly Statistics</small></h1>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span4  well well-large">
                        <c:set var="bookingPercentChange" value="${manageBookingsActionBean.percentChange}" /> 
                        <div class="row-fluid">
                            <h2 class="analyticsHeader">New Facility Bookings this week</h2>
                        </div>
                        <div class="row-fluid">
                            <div class="weekly-stats">${manageBookingsActionBean.numberOfNewBookingsThisWeek}
                                    <c:choose>
                                        <c:when test="${bookingPercentChange > 0}">
                                            <span class="weekly-gain"><i class="icon-arrow-up weekly-gain"></i>${bookingPercentChange}%</span>
                                        </c:when>
                                        <c:when test="${bookingPercentChange<0}">
                                            <span class="weekly-loss"><i class="icon-arrow-down weekly-loss"></i>${bookingPercentChange}%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="weekly-no-change">(no change)</span>
                                        </c:otherwise>
                                    </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="span4 well well-large">
                        <c:set var="postPercentChange" value="${managePostBean.percentChange}" /> 
                        <div class="row-fluid">
                            <h2 class="analyticsHeader">New Community Posts this week</h2>
                        </div>
                        <div class="row-fluid">
                            <div class="weekly-stats">${managePostBean.numberOfNewPostsThisWeek}
                                <c:choose>
                                    <c:when test="${postPercentChange > 0}">
                                        <span class="weekly-gain"><i class="icon-arrow-up weekly-gain"></i>${postPercentChange}%</span>
                                    </c:when>
                                    <c:when test="${postPercentChange < 0}">
                                        <span class="weekly-loss"><i class="icon-arrow-down weekly-loss"></i>${postPercentChange}%</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="weekly-no-change">(no change)</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="span4 well well-large">
                        <c:set var="eventPercentChange" value="${manageEventBean.percentChange}" /> 
                        <div class="row-fluid">
                            <h2 class="analyticsHeader">New Community Events this week</h2>
                        </div>
                        <div class="row-fluid">
                            <div class="weekly-stats">${manageEventBean.numberOfEventsCreatedThisWeek}
                                <c:choose>
                                    <c:when test="${eventPercentChange > 0}">
                                        <span class="weekly-gain"><i class="icon-arrow-up weekly-gain"></i>${eventPercentChange}%</span>
                                    </c:when>
                                    <c:when test="${eventPercentChange < 0}">
                                        <span class="weekly-loss"><i class="icon-arrow-down weekly-loss"></i>${eventPercentChange}%</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="weekly-no-change">(no change)</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span4">
                        <div class="row-fluid">
                            <h3>Last Month's Bookings</h3>
                            <div id="graph-bookings"></div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="row-fluid">
                            <h3>Last Month's Posts</h3>
                            <div id="graph-posts"></div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="row-fluid">
                            <h3>Last Month's Events</h3>
                            <div id="graph-events"></div>
                        </div>
                    </div>
                </div>
<!--                dropdown containing a list of all the facilities-->
<!--                <div class="row-fluid">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.login.RegisterActionBean" focus="" name="registration_validate" id="registration_validate">
                        <stripes:select name="Facilities" id ="facilities">
                            <stripes:options-collection collection="${manageFacilitiesActionBean.facilityList}" value="id" label="name"/>        
                        </stripes:select>
                            <a  role="button" data-toggle="modal" class="btn btn-warning btn-mini" onclick="setFid()" >Show</a>
                        </stripes:form>
                    <div id="bigGraph"></div>
                </div>-->
                
                <br />
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>

    //=============================== BIG GRAPH START =================================
    
    var fid;

    function setFid(){
        console.log(document.getElementById('facilities').value);
        fid = document.getElementById('facilities').value;
        reload();
    }
    function reload(){
        d3.select("#graph").remove();
        var responsiveWidth = $("#bigGraph").width();
        var margin = {top: 20, right: 20, bottom: 150, left: 40},
        width = responsiveWidth - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

        var formatPercent = d3.format(".0%");

        var x = d3.scale.ordinal()
            .rangeRoundBands([0, width], .1, 1);

        var y = d3.scale.linear()
            .range([height, 0]);

        var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

        var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left")
            .tickFormat(formatPercent);

        var svg = d3.select("#bigGraph").append("svg")
            .attr("width", "100%")
            .attr("id","graph")
            .attr("height", height + margin.top + margin.bottom)
        .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        d3.json("/json/testResponseJson.jsp?FId="+fid, function(error, data) {
        console.log(data);
        data.forEach(function(d) {
            d.frequency = +d.frequency;
        });

        x.domain(data.map(function(d) { return d.letter; }));
        y.domain([0, d3.max(data, function(d) { return d.frequency; })]);

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis)
                .selectAll("text")  
                    .style("text-anchor", "end")
                    .attr("dx", "-.8em")
                    .attr("dy", ".15em")
                    .attr("transform", function(d) {
                        return "rotate(-65)" 
                        });

        svg.append("g")
            .attr("class", "y axis")
            .call(yAxis)
            .append("text")
            .attr("transform", "rotate(-90)")
            .attr("y", 6)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .text("Frequency");

        svg.selectAll(".bar")
            .data(data)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.letter); })
            .attr("width", x.rangeBand())
            .attr("y", function(d) { return y(d.frequency); })
            .attr("height", function(d) { return height - y(d.frequency); });

        d3.select("input").on("change", change);

        var sortTimeout = setTimeout(function() {
            d3.select("input").property("checked", true).each(change);
        }, 2000);

        function change() {
            clearTimeout(sortTimeout);

            // Copy-on-write since tweens are evaluated after a delay.
            var x0 = x.domain(data.sort(this.checked
                ? function(a, b) { return b.frequency - a.frequency; }
                : function(a, b) { return d3.ascending(a.letter, b.letter); })
                .map(function(d) { return d.letter; }))
                .copy();

            var transition = svg.transition().duration(750),
                delay = function(d, i) { return i * 50; };

            transition.selectAll(".bar")
                .delay(delay)
                .attr("x", function(d) { return x0(d.letter); });

            transition.select(".x.axis")
                .call(xAxis)
                .selectAll("text")  
                    .style("text-anchor", "end")
                    .attr("dx", "-.8em")
                    .attr("dy", ".15em")
                    .attr("transform", function(d) {
                        return "rotate(-65)" 
                        })
            .selectAll("g")
                .delay(delay);
        }
        });
    }

    //=============================== BIG GRAPH END =================================
    
    //=============================== BOOKINGS GRAPH START =================================
        function loadBookingsGraph(){
            var responsiveWidthBookings = $("#graph-bookings").width();
            var margin = {top: 20, right: 20, bottom: 30, left: 50},
                width = responsiveWidthBookings - margin.left - margin.right,
                height = 200 - margin.top - margin.bottom;

            var x = d3.scale.linear()
                .range([0, width]);

            var y = d3.scale.linear()
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");

            var line = d3.svg.line()
                .x(function(d) { return x(d.date); })
                .y(function(d) { return y(d.count); });

            var svg = d3.select("#graph-bookings").append("svg")
                .attr("id","bookings")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
            .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            d3.json("/json/bookingsGraph.jsp", function(error, data) {
            console.log(data);
            data.forEach(function(d) {
                d.date = d.date;
                d.count = +d.count;
            });

            x.domain(d3.extent(data, function(d) { return d.date; }));
            y.domain(d3.extent(data, function(d) { return d.count; }));

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("No. of Bookings");

            svg.append("path")
                .datum(data)
                .attr("class", "line")
                .attr("d", line);
            });
        }
    
    //=============================== BOOKINGS GRAPH END =================================
    
    
    
    //=============================== POSTS GRAPH START =================================
        function loadPostsGraph(){
            var responsiveWidthBookings = $("#graph-posts").width();
            var margin = {top: 20, right: 20, bottom: 30, left: 50},
                width = responsiveWidthBookings - margin.left - margin.right,
                height = 200 - margin.top - margin.bottom;

            var x = d3.scale.linear()
                .range([0, width]);

            var y = d3.scale.linear()
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");

            var line = d3.svg.line()
                .x(function(d) { return x(d.date); })
                .y(function(d) { return y(d.count); });

            var svg = d3.select("#graph-posts").append("svg")
                .attr("id","posts")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
            .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            d3.json("/json/postsGraph.jsp", function(error, data) {
            console.log(data);
            data.forEach(function(d) {
                d.date = d.date;
                d.count = +d.count;
            });

            x.domain(d3.extent(data, function(d) { return d.date; }));
            y.domain(d3.extent(data, function(d) { return d.count; }));

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("No. of Posts");

            svg.append("path")
                .datum(data)
                .attr("class", "line")
                .attr("d", line);
            });
        }
       
    
    //=============================== POSTS GRAPH END =================================
    
    
    
    //=============================== EVENTS GRAPH START =================================
        function loadEventsGraph(){
            var responsiveWidthBookings = $("#graph-events").width();
            var margin = {top: 20, right: 20, bottom: 30, left: 50},
                width = responsiveWidthBookings - margin.left - margin.right,
                height = 200 - margin.top - margin.bottom;

            var x = d3.scale.linear()
                .range([0, width]);

            var y = d3.scale.linear()
                .range([height, 0]);

            var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");

            var line = d3.svg.line()
                .x(function(d) { return x(d.date); })
                .y(function(d) { return y(d.count); });

            var svg = d3.select("#graph-events").append("svg")
                .attr("id","events")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
            .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            d3.json("/json/eventsGraph.jsp", function(error, data) {
            console.log(data);
            data.forEach(function(d) {
                d.date = d.date;
                d.count = +d.count;
            });

            x.domain(d3.extent(data, function(d) { return d.date; }));
            y.domain(d3.extent(data, function(d) { return d.count; }));

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("No. of Events");

            svg.append("path")
                .datum(data)
                .attr("class", "line")
                .attr("d", line);
            });
        }
        
    
    //=============================== EVENTS GRAPH END =================================

    </script>
</body>
</html>

