<%-- 
    Document   : header
    Created on : Dec 19, 2012, 10:08:46 PM
    Author     : fayannefoo
--%>

<%@page import="com.lin.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="notificationBean" scope="page"
             class="com.lin.resident.ManageNotificationBean"/>
<head>
    <link href="./css/adminia.css" rel="stylesheet"> 
    <link href="./css/adminia-responsive.css" rel="stylesheet"> 
    <link href="./css/residentscustom.css" rel="stylesheet"> 
    <script src="/js/underscore-min.js"></script>
    <script src="/js/json2.js"></script>
</head>

<div class="navbar navbar-fixed-top">

    <div class="navbar-inner">

        <div class="container">

            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 
                <span class="icon-bar"></span> 				
            </a>

            <a class="brand" href="/residents/index.jsp">Beacon Heights

            </a>
            <div class="nav-collapse">
                <ul class="nav pull-left">

                    <li class="dropdown">

                        <a href="/residents/communitywall.jsp" data-toggle="dropdown" class="dropdown-toggle ">
                            Community
                            <b class="caret"></b>							
                        </a>
                        <ul class="dropdown-menu hoverShow">
                            <li>
                                <a href="/residents/communitywall.jsp"> Community Wall</a>
                                <a href="/residents/usersearch.jsp"> Search Friends</a>
                            </li>
                        </ul>
                    </li>
                </ul>

                <ul class="nav pull-left">

                    <li class="dropdown">

                        <a href="/residents/eventwall.jsp" data-toggle="dropdown" class="dropdown-toggle ">
                            Events
                            <b class="caret"></b>							
                        </a>
                        <ul class="dropdown-menu hoverShow">
                            <li>
                                <a href="/residents/eventwall.jsp"> Event Wall</a>
                                <a href="/residents/viewmyevents.jsp"> View My Events</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav pull-left">

                    <li class="dropdown">

                        <a data-target ="#" href="/residents/index.jsp" data-toggle="dropdown" class="dropdown-toggle ">
                            Facility Booking
                            <b class="caret"></b>							
                        </a>
                        <ul class="dropdown-menu hoverShow">
                            <li>
                                <a href="/residents/index.jsp"> Book Facilities</a>
                            </li>

                            <li>
                                <a href="/residents/mybookings.jsp"> View My Bookings</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <ul class="nav pull-left">

                    <li class="dropdown">

                        <a href="#services" data-toggle="dropdown" class="dropdown-toggle ">
                            Services
                            <b class="caret"></b>							
                        </a>

                        <ul class="dropdown-menu hoverShow">
                            <li>
                                <a href="/residents/viewamenities.jsp"> View Amenities</a>
                            </li>
                            <li>
                                <a href="/residents/viewresources.jsp"> Download Resources</a>
                            </li>

                            <li>
                                <a href="/residents/submitonlineforms.jsp"> Submit Online Forms</a>
                            </li>

                        </ul>

                    </li>
                </ul>
           </div>     


            <div class="nav-collapse">

                <ul class="nav pull-right">
                    <li class="divider-vertical"></li>
                    <li>

                        <img class="profilePic" src="/uploads/profile_pics/${user.profilePicFilename}" />
                    </li>
                    <li>
                        <a href="profile.jsp?profileid=${user.userId}">${user.firstname}</a>
                    </li>

                    <li class="dropdown">

                        <a data-toggle="dropdown" class="dropdown-toggle " href="#">
                            <i class="icon-cog"></i>
                            <b class="caret"></b>							
                        </a>

                        <ul class="dropdown-menu hoverShow">
                            <!--<li>
                                <a href="./account.html"><i class="icon-user"></i> Account Setting  </a>
                            </li>
                                
                            <li>
                                <a href="./change_password.html"><i class="icon-lock"></i> Change Password</a>
                            </li>-->

                            <c:if test= "${user.role.id==1}">
                                <li>
                                    <a href="/admin/adminmain.jsp"><i class="icon-forward"></i>Admin Page</a>
                                </li>
                            </c:if>
                            <li>
                                <a href="profile.jsp?profileid=${user.userId}"><i class="icon-forward"></i>Profile</a>
                            </li>
                            <li>
                                <a href="/residents/changepassword.jsp"><i class="icon-forward"></i>Change Password</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                            <stripes:link href="/stripes/LogoutActionBean.action"><i class="icon-off"></i>Logout</stripes:link>
                    </li>
                </ul>
                </li>

                </ul>
                            
                           <%@include file="/notificationsWidget.jsp"%>
                            
                <ul class="nav pull-right">

                    <li class="dropdown">

                        <a href="/residents/myenquiries.jsp"> <i>Enquiries</i></a>
                        </a>
                        <ul class="dropdown-menu">
                        </ul>
                    </li>
                </ul>
                            
            </div> <!-- /nav-collapse -->

        </div> <!-- /container -->

    </div> <!-- /navbar-inner -->

</div> <!-- /navbar -->


<!-- XY IS AWESOME! --->