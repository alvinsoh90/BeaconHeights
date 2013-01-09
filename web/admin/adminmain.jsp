<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<%@include file="/protectadmin.jsp"%>

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
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

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
                        $("#edit_email").val(user.email);
                        $("#edit_mobileno").val(user.mobileNo);
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
        <%@include file="include/mainnavigationbar.jsp"%>

        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="well hero-unit">
                    <h1>Welcome, Administrator.</h1>
                    <p>What would you like to do today?</p>
                    <p><a class="btn btn-success btn-large" href="users.jsp">Manage Users &raquo;</a></p>
                </div>
                <div class="row-fluid">
                    <div class="span3">
                        <h3>Total Users</h3>
                        <p><a href="users.jsp" class="badge badge-inverse">${approveUserBean.userListCount}</a></p>
                    </div>
                    <div class="span3">
                        <h3>New Users Today</h3>
                        <p><a href="users.jsp" class="badge badge-inverse">${approveUserBean.newUserListCount}</a></p>
                    </div>
                    <div class="span3">
                        <h3>Pending</h3>
                        <p><a href="users.jsp" class="badge badge-inverse">${approveUserBean.tempUserListCount}</a></p>
                    </div>
                    <div class="span3">
                        <h3>Roles</h3>
                        <p><a href="roles.html" class="badge badge-inverse">${approveUserBean.roleListCount}</a></p>
                    </div>
                </div>
                <br />
                <div class="row-fluid">
                    <div class="page-header">
                        <h1>Pending Users <small>Approve or Reject</small></h1>
                    </div>
                    <table class="table table-bordered">
                        <thead>
                            <tr>    
                                <th></th>
                                <th>ID</th>
                                <th>Username</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Role</th>
                                <th>Email</th>
                                <th>Mobile No.</th>
                                <th colspan="3">Address</th>

                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!--<tr class="pending-user">
                                    <td>564</td>
                                    <td>John S. Schwab</td>
                                    <td>johnschwab@provider.com</td>
                                    <td>402-xxx-xxxx</td>
                                    <td>Bassett, NE</td>
                                    <td>User</td>
                                    <td><span class="label label-important">Inactive</span></td>
                                    <td><span class="user-actions"><a href="javascript:void(0);" class="label label-success">Approve</a> <a href="javascript:void(0);" class="label label-important">Reject</a></span></td>
                            </tr>
                            <tr class="pending-user">
                                    <td>565</td>
                                    <td>Juliana M. Sheffield</td>
                                    <td>julianasheffield@provider.com</td>
                                    <td>803-xxx-xxxx</td>
                                    <td>Columbia, SC</td>
                                    <td>User</td>
                                    <td><span class="label label-important">Inactive</span></td>
                                    <td><span class="user-actions"><a href="javascript:void(0);" class="label label-success">Approve</a> <a href="javascript:void(0);" class="label label-important">Reject</a></span></td>
                            </tr> -->

                            <c:forEach items="${approveUserBean.tempUserList}" var="userTemp" varStatus="loop">
                            <script>
                                var user = new Object();
                                user.id = '${userTemp.userId}';
                                user.username = '${userTemp.userName}';
                                user.firstName = '${userTemp.firstname}';
                                user.lastName = '${userTemp.lastname}';
                                user.roleName = '${userTemp.role.name}';
                                user.email = '${userTemp.email}';
                                user.mobileNo = '${userTemp.mobileNo}';
                                user.blockName = '${userTemp.block.blockName}';
                                user.level = '${userTemp.level}';
                                user.unit = '${userTemp.unit}';
                                userList.push(user);
                            </script>
                            <tr class="pending-user">
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
                                <td>${userTemp.email}</td>
                                <td>${userTemp.mobileNo}</td>
                                <td>${userTemp.block.blockName}</td>                                                            
                                <td>${userTemp.level}</td>
                                <td>${userTemp.unit}</td>
                                <td>
                                    <span class="user-actionss">
                                        <a href="#approveUserModal" role="button" data-toggle="modal" onclick="populateApproveUserModal('${userTemp.userId}')" class="btn btn-success btn-mini">Approve</a> 

                                        <a href="#rejectUserModal" role="button" data-toggle="modal" onclick="populateRejectUserModal('${userTemp.userId}')" class="btn btn-danger btn-mini" >Reject</a>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <hr>

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
                        <label class="control-label">Email</label>
                        <div class="controls">
                            <stripes:text id="edit_email" name="email"/> 
                        </div>
                    </div>                              
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Mobile No.</label>
                        <div class="controls">
                            <stripes:text id="edit_mobileno" name="mobileno"/> 
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

        <%@include file="include/footer.jsp"%>
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

