<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.entities.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<jsp:useBean id="manageUsersActionBean" scope="page"
                     class="com.lin.general.admin.ManageUsersActionBean"/>
<html lang="en">
    <head>
        <title>Unicorn Admin</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="css/fullcalendar.css" />	
        <link rel="stylesheet" href="css/unicorn.main.css" />
        <link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />
    </head>
    <body>
        
        <div id="header">
            <h1><a href="./dashboard.html">Beacon Heights Admin</a></h1>		
        </div>

        <div id="search">
            <input type="text" placeholder="Search here..."/><button type="submit" class="tip-right" title="Search"><i class="icon-search icon-white"></i></button>
        </div>
        <div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                <li class="btn btn-inverse" ><a title="" href="#"><i class="icon icon-user"></i> <span class="text">Profile</span></a></li>
                <li class="btn btn-inverse dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">Messages</span> <span class="label label-important">5</span> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a class="sAdd" title="" href="#">new message</a></li>
                        <li><a class="sInbox" title="" href="#">inbox</a></li>
                        <li><a class="sOutbox" title="" href="#">outbox</a></li>
                        <li><a class="sTrash" title="" href="#">trash</a></li>
                    </ul>
                </li>
                <li class="btn btn-inverse"><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>
                <li class="btn btn-inverse"><a title="" href="login.html"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
            </ul>
        </div>

        <div id="sidebar">
            <a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
            <ul>
                <li class="submit"><a href="#"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>
                <li class="active">
                    <a href="#"><i class="icon icon-user"></i> <span>Users</span></a>
                </li>
            </ul>

        </div>

        <div id="style-switcher">
            <i class="icon-arrow-left icon-white"></i>
            <span>Style:</span>
            <a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
            <a href="#blue" style="background-color: #2D2F57;"></a>
            <a href="#red" style="background-color: #673232;"></a>
        </div>

        <div id="content">
            <div id="content-header">
                <h1> ${manageUsersActionBean.test} </h1>
                <div class="btn-group">
                    <a class="btn btn-large tip-bottom" title="Manage Files"><i class="icon-file"></i></a>
                    <a class="btn btn-large tip-bottom" title="Manage Users"><i class="icon-user"></i></a>
                    <a class="btn btn-large tip-bottom" title="Manage Comments"><i class="icon-comment"></i><span class="label label-important">5</span></a>
                    <a class="btn btn-large tip-bottom" title="Manage Orders"><i class="icon-shopping-cart"></i></a>
                </div>
            </div>
            <div id="breadcrumb">
                <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
                <a href="#" class="current">Users</a>
            </div>
            <div class="container-fluid">

                <div class="row-fluid">
                    <div class="span12">

                        <div class="widget-box recent-comments">
                            <div class="widget-title">
                                <span class="icon"><i class="icon-user"></i></span><h5>Users</h5></div>
                            <div class="widget-content">
                                <div class="row-fluid">

                                    <div class="span12"><!--span12-->
                                        <div class="widget-content nopadding">
                                            <ul class="recent-comments"> 
                                                <% HashMap<String,User> hm = manageUsersActionBean.getUserList();
                                                for(Map.Entry<String,User> entry : hm.entrySet()){ %>
                                                
                                                <!--CAN'T SEEM TO GET JSTL TO WORK!!SO FOR NOW I'M ACCESSING THE ACTION BEAN DIRECTLY-->
                                                <!--<c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">-->
                                                    
                                                    <li>
                                                        <div class="user-thumb">
                                                            <img width="40" height="40" alt="" src="img/demo/av1.jpg">
                                                        </div>
                                                        <div class="comments">
                                                            <span class="username">
                                                                <b><%=entry.getKey()%></b><br/>
                                                                First Name: <%=entry.getValue().getFirst_name()%></br>
                                                                Last Name: <%=entry.getValue().getLast_name()%></br>
                                                                Role: <%=entry.getValue().getRole().getName()%></br>
                                                            </span>
                                                            <span class="user-address">
                                                                Block: <%=entry.getValue().getBlock().getBlock_name()%></br>
                                                                Level: <%=entry.getValue().getLevel()%></br>
                                                                Unit: <%=entry.getValue().getUnit()%></br>
                                                            </span>           
                                                                
                                                            </span>
                                                            <a href="#" class="btn btn-primary btn-mini">Edit</a> <a href="#" class="btn btn-success btn-mini">Approve</a> <a href="#" class="btn btn-warning btn-mini">Mark as spam</a> <a href="#" class="btn btn-danger btn-mini">Delete</a>
                                                        </div>
                                                    </li>
                                                <!--</c:forEach>-->
                                                <%}%>    
                                                <li class="viewall">
                                                    <a class="tip-top" href="#" data-original-title="View all comments"> + View all + </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>	
                                </div>							
                            </div>
                        </div>					
                    </div>
                </div>

                <div class="row-fluid">
                    <div id="footer" class="span12">
                        2012 &copy; Unicorn Admin. Brought to you by <a href="https://wrapbootstrap.com/user/diablo9983">diablo9983</a>
                    </div>
                </div>
            </div>
        </div>


        <!--<script src="js/excanvas.min.js"></script>-->
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.ui.custom.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script src="js/jquery.flot.min.js"></script>
        <script src="js/jquery.flot.resize.min.js"></script>
        <script src="js/jquery.peity.min.js"></script>
         
        <script src="js/fullcalendar.min.js"></script>
        <script src="js/unicorn.js"></script>
        <script src="js/unicorn.dashboard.js"></script>
    </body>
    
</html>
