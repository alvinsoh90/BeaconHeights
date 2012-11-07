<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<html lang="en">
    <head>
        <title>Admin | Living Integrated Network</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap.min.css" />
        <link rel="stylesheet" href="../css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="../css/fullcalendar.css" />	
        <link rel="stylesheet" href="../css/unicorn.main.css" />
        <link rel="stylesheet" href="../css/custom/lin.css" />
        <link rel="stylesheet" href="../css/uniform.css" />
        <link rel="stylesheet" href="../css/chosen.css" />	
        <link rel="stylesheet" href="../css/unicorn.grey.css" class="skin-color" />
        <style>.starthidden { display:none; }</style>
           
        <script src="../js/jquery.min.js"></script>
        <script src="../js/jquery.ui.custom.js"></script>
        <script src="../js/bootstrap.min.js"></script>
                
        <script src="../js/jquery.uniform.js"></script>
        <script src="../js/jquery.chosen.js"></script>
        <script src="../js/jquery.validate.js"></script>
                
        <script src="../js/unicorn.js"></script>
        <script src="../js/unicorn.dashboard.js"></script>
        <script src="../js/unicorn.form_common.js"></script>
        
        <!-- Populates the Edit User form -->
        <script>
            // Init an array of all users shown on this page
            var userList = [];
            
            //when this function is called, userList should already be populated
            function populateApproveUserModal(userID){ 
                userList.forEach(function(user){
                    if(user.id == userID){
                        $("#usernameLabel").text(user.username);
                        $("#editid").val(user.id);
                        $("#edit_username").val(user.username);
                        $("#edit_firstname").val(user.firstName);
                        $("#edit_lastname").val(user.lastName);
                        $("#edit_block").val(user.blockName);
                        $("#edit_role").val(user.roleName);
                        $("#edit_level").val(user.level);
                        $("#edit_unit").val(user.unit);
                    }
                });
                
            }
            
            //when this function is called, userList should already be populated
            function populateRejectUserModal(userID){ 
                userList.forEach(function(user){
                    if(user.id == userID){
                        $("#usernameRejectLabel").text(user.username);
                        $("#reject_id").val(user.id);
                        $("#reject_username").val(user.username);
                        $("#reject_firstname").text(user.firstName);
                        $("#reject_lastname").text(user.lastName);
                    }
                });
            }
        </script>

        
    </head>
    <body>
        <!-- Approve User Modal Form -->
            <div id="approveUserModal" class="modal hide fade">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Edit <span id="usernameLabel"></span>'s information</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ApproveUserBean" focus="" name="registration_validate">
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Role</label>
                            <div class="controls">
                                <stripes:select name="role">
                                    <stripes:options-collection collection="${approveUserBean.roleList}" value="id" label="name"/>        
                                </stripes:select>
                            </div>
                        </div> 
                        <stripes:text class="hide" name="id" id="editid" />
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Username</label>
                            <div class="controls">
                                <stripes:text id="edit_username" name="username"/>
                            </div>
                        </div>

                        <div class="control-group ${errorStyle}">
                            <label class="control-label">First Name</label>
                            <div class="controls">
                                <stripes:text id="edit_firstname" name="firstname"/> 
                            </div>
                        </div>                              
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Last Name</label>
                            <div class="controls">
                                <stripes:text id="edit_lastname" name="lastname"/> 
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Block</label>
                            <div class="controls">
                                <stripes:text id="edit_block" name="block"/> 
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Level</label>
                            <div class="controls">
                                <stripes:text id="edit_level" name="level"/>
                            </div>
                        </div>     
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Unit Number</label>
                            <div class="controls">
                                <stripes:text id="edit_unit" name="unitnumber"/>
                            </div>
                        </div>                     

                    </div>
                    <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">Close</a>
                        <input type="submit" name="approveUserAction" value="Confirm Approval" class="btn btn-primary"/>
                    </div>
                </stripes:form>
            </div>
        
        <!-- Reject User Modal -->
            <div id="rejectUserModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Rejecting of <span id="usernameRejectLabel"></span>'s account</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.RejectUserBean" focus=""> 
                        You are now rejecting <span id="reject_firstname"></span> <span id="reject_lastname"></span>'s account. Are you sure?
                    </div>
                    <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">Close</a>
                        <stripes:hidden name="id" id="reject_id" />
                        <stripes:hidden id="reject_username" name="username"/>
                        <input type="submit" name="rejectUser" value="Confirm Rejection" class="btn btn-danger"/>
                    </div>
                </stripes:form>
            </div>
        
        <div id="header">
            <h1><a href="../dashboard.html">Beacon Heights Admin</a></h1>		
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
                <li class="submenu active open">
                    <a href="manageusers.jsp"><i class="icon icon-th-list"></i> <span>Users</span> <span class="label">3</span></a>
                    <ul>
                        <li><a href="manageusers.jsp">Manage Users</a></li>
                        <li class="active"><a href="approveaccounts.jsp">Approve Pending Accounts</a></li>
                        <!--<li><a href="form-wizard.html">Wizard</a></li> -->
                    </ul>
                </li>
                <li class="submenu">
                    <a href="managefacilities.jsp"><i class="icon icon-th-list"></i> <span>Facilities</span> <span class="label">3</span></a>
                    <ul>
                        <li><a href="managefacilities.jsp">Manage Facilities</a></li>
                        <!--<li><a href="approveaccounts.jsp">Approve Pending Accounts</a></li> -->
                    </ul>
                </li>
            </ul>
        </div>

        
        <div id="content">
            <div id="content-header">
                <h1> Approve Pending Accounts </h1>
                <div class="btn-group">
                    <a class="btn btn-large tip-bottom" title="Manage Files"><i class="icon-file"></i></a>
                    <a href="approveaccounts.jsp" class="btn btn-large tip-bottom" title="Manage Pending Accounts"><i class="icon-user"></i>
                    <c:if test = "${approveUserBean.tempUserListCount > 0}">
                            <span class="label label-important">${approveUserBean.tempUserListCount}</span>
                    </c:if>
                    </a>
                    <a class="btn btn-large tip-bottom" title="Manage Comments"><i class="icon-comment"></i><span class="label label-important">5</span></a>
                    <a class="btn btn-large tip-bottom" title="Manage Orders"><i class="icon-shopping-cart"></i></a>
                </div>
            </div>
            <div id="breadcrumb">
                <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
                <a href="manageusers.jsp" class="current">Users</a>
                <a href="approveaccounts.jsp" class="current">Approve Pending Accounts</a>
            </div>
            <div class="container-fluid">
             
                <div class="row-fluid">
                    <div class="span12">
                        <c:if test = "${param.approvesuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> There was an error approving the user. Please try again!
                            </div>
                        </c:if>
                        <c:if test = "${param.success == 'false'}">
                        <div><br/></div>
                        <div class="login alert alert-error container">
                            <b>Whoops.</b> There was an error creating a user. Please try again!
                        </div>
                    </c:if> 
                    <c:if test = "${param.success == 'true'}">
                        <div><br/></div>
                        <div class="login alert alert-success container">
                            <b>Awesome!</b> ${param.msg} was added to the user list!
                        </div>
                    </c:if>
                    <c:if test = "${param.rejectsuccess == 'true'}">
                        <div><br/></div>
                        <div class="login alert alert-success container">
                            <b>Awesome!</b> ${param.rejectmsg} was successfully rejected!
                        </div>
                    </c:if>
                    <c:if test = "${param.rejectsuccess == 'false'}">
                        <div><br/></div>
                        <div class="login alert alert-error container">
                            <b>Whoops.</b> There was an error rejecting the user. Please try again!
                        </div>
                    </c:if> 
                    
                    <!-- Users Pending Approval -->
                     <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon"><i class="icon-user"></i></span><h5>Accounts Pending Approval</h5></div>
                        <div class="widget-content">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="widget-content nopadding">
                                        <ul class="recent-comments"> 
                                            <table class="table table-striped users">
                                                <tr>
                                                    <th></th>
                                                    <th>ID</th>
                                                    <th>Username</th>
                                                    <th>First Name</th>
                                                    <th>Last Name</th>
                                                    <th>Role</th>
                                                    <th colspan="3">Address</th>
                                                    <th>Action</th>
                                                </tr>

                                                <c:forEach items="${approveUserBean.tempUserList}" var="userTemp" varStatus="loop">
                                                    <script>
                                                        var user = new Object();
                                                        user.id = '${userTemp.userId}';
                                                        user.username = '${userTemp.userName}';
                                                        user.firstName = '${userTemp.firstname}';
                                                        user.lastName = '${userTemp.lastname}';
                                                        user.roleName = '${userTemp.role.name}';
                                                        user.blockName = '${userTemp.block.blockName}';
                                                        user.level = '${userTemp.level}';
                                                        user.unit = '${userTemp.unit}';
                                                        userList.push(user);
                                                    </script>
                                                    <tr>
                                                        <td>
                                                            <div class="user-thumb">
                                                                <img width="40" height="40" alt="" src="../img/demo/av1.jpg">
                                                            </div>
                                                        </td>
                                                        <!--<div class="comments">
                                                            <span class="username">-->
                                                        <td><b>${userTemp.userId}</b></td>
                                                        <td><b>${userTemp.userName}</b></td>
                                                        <td>${userTemp.firstname}</td>
                                                        <td>${userTemp.lastname}</td>
                                                        <td>${userTemp.role.name}</td>
                                                        <td>${userTemp.block.blockName}</td>                                                            
                                                        <td>${userTemp.level}</td>
                                                        <td>${userTemp.unit}</td>
                                                        <td>
                                                            <a href="#approveUserModal" role="button" data-toggle="modal" onclick="populateApproveUserModal('${userTemp.userId}')" class="btn btn-success btn-mini">Approve</a> 
                                                            <a href="#rejectUserModal" role="button" data-toggle="modal" onclick="populateRejectUserModal('${userTemp.userId}')" class="btn btn-danger btn-mini" >Reject</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>    
                                            <li class="viewall">
                                                <a class="tip-top" href="#" data-original-title="View all users"> + View all + </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>	
                            </div>							
                        </div>
                    </div>
                    
                    
                </div>

                <div class="row-fluid">
                    <div id="footer" class="span12">
                     
                    </div>
                </div>
            </div>
            

            <!--<script src="js/excanvas.min.js"></script>-->

    </body>

</html>
