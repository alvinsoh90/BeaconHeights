<%-- 
    Document   : communitywall
    Created on : Jan 27, 2013, 11:36:07 PM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>My Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.general.admin.ManagePostBean"/>
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

    </head>
    <body>


        <!-- spitting out all posts in the db, up to you to style :) -->
        <div id="content">

            <div class="container">

                <!--<div class="span9">
                    <div class="widget widget-table">

                <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">
                    <b>${post.user.userName}</b></br>
                    ${post.message}</br>
                    ${post.date}
                    <hr>
                </c:forEach>
            </div>
        </div> -->

                <div class="postWrapper">
                    <div class="leftContent">
                        <div class="posterInfo">
                            <img style="height:75px;width:75px;border-radius:3px;background:black;"/>
                            <div class="name">Jocelyn Tan</div>
                            <div class="timestamp">about 23 minutes ago</div>
                        </div>
                        <div class="postIcon" style="height:60px;width:60px;background:green;border-radius:100px;"></div>
                    </div>
                    <div class="post">
                        <div class="baseContent">
                            <div class="title"><b>Jocelyn Tan</b> is looking for 2 more players for a tennis game</div>
                            <div class="content">"My boyfriend and i are looking for 2 more players to form a doubles team! Feel free to join us. We'll be there for a few hours this evening."</div>
                            <div class="attachment event">
                                <div class="eventTitle"><a href="#">Tennis Game Tonight, 7pm!</a></div>
                                <div class="eventMeta">
                                    <b>Venue:</b> Beacon Heights Tennis Court 2 <br/>
                                    <b>Date/Time:</b> 28 Sept '12 @ 7pm - 10pm
                                </div>
                            </div>
                            <div class="linkBar">
                                <a class="btn"><i class="icon-check"></i> I'm going!</a>
                                <a class="btn"><i class="icon-heart"></i> Like</a>
                                <a class="btn"><i class="icon-eye-open"></i> View Event</a>
                                <a href="#" class="float_r flagPost"><i class="icon-flag"></i> Flag as inappropriate</a>
                            </div>
                        </div>

                        <div class="commentArea">
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_r">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_r">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_r">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment replyArea">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <input class="float_l" placeholder="Say something here..."/>
                                <br class="clearfix"/>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
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
