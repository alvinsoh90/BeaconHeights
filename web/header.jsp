<%-- 
    Document   : header
    Created on : Dec 19, 2012, 10:08:46 PM
    Author     : fayannefoo
--%>

<%@page import="com.lin.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Make a Booking | Beacon Heights</title>
        
    </head>
    <body>
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
                    <ul class="nav pull-left">

                        <li class="dropdown">

                            <a data-toggle="dropdown" class="dropdown-toggle ">
                                Facility Booking
                                <b class="caret"></b>							
                            </a>

                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/residents/index.jsp"> Book Facilities</a>
                                </li>

                                <li>
                                    <a href="/residents/mybookings.jsp"> View My Bookings</a>
                                </li>


                        </li> </ul></li></ul>

                    <div class="nav-collapse">

                        <ul class="nav pull-right">
                            <li class="divider-vertical"></li>
                            <li>
                                <img class="profilePic" src="http://png.findicons.com/files/icons/756/ginux/64/user.png"/>
                            </li>



                            <li class="dropdown">

                                <a data-toggle="dropdown" class="dropdown-toggle " href="#">
                                    ${user.firstname}
                                    <b class="caret"></b>							
                                </a>

                                <ul class="dropdown-menu">
                                    <!--<li>
                                        <a href="./account.html"><i class="icon-user"></i> Account Setting  </a>
                                    </li>

                                    <li>
                                        <a href="./change_password.html"><i class="icon-lock"></i> Change Password</a>
                                    </li>-->

                                    <c:if test= "${user.role.id==1}">
                                        <li>
                                            <a href="/admin/adminmain.jsp"><i class="icon-forward"></i>Go to Admin</a>
                                        </li>
                                    <li class="divider"></li>
                                    </c:if>
                                    <li>
                                    <stripes:link href="/stripes/LogoutActionBean.action"><i class="icon-off"></i>Logout</stripes:link>

                            </li>
                        </ul>
                        </li>

                        </ul>

                    </div> <!-- /nav-collapse -->

                </div> <!-- /container -->

            </div> <!-- /navbar-inner -->

        </div> <!-- /navbar -->
    </body>
</html>
