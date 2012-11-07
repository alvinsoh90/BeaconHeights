<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<html lang="en">
    <head>
        <title>Unicorn Admin</title>
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

        <!-- Populates the Edit User form -->
        <script>
            // Init an array of all users shown on this page
            var userList = [];
            
            //when this function is called, userList should already be populated
            function populateEditUserModal(userID){ 
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
        </script>

        <!-- Populates the Delete User Modal-->
        <script>
            // Init an array of all users shown on this page
            var userList = [];
            
            //when this function is called, userList should already be populated
            function populateDeleteUserModal(userID){ 
                userList.forEach(function(user){
                    if(user.id == userID){
                        $("#usernameDeleteLabel").text(user.username);
                        $("#delete_username").val(user.username);
                        $("#delete_firstname").text(user.firstName);
                        $("#delete_lastname").text(user.lastName);
                        $("#delete_id").val(user.id);
                    }
                });
                
            }
            
            //Loop through userList and output all into table for display
            function showUsers(userArr){
   
                var r = new Array(), j = -1;
                
                var tableHeaders = "<tr><th>ID</th><th>Username</th><th>First Name</th><th>Last Name</th><th>Role</th><th colspan='3'>Address</th><th>Action</th></tr>"
                
                for (var i=userArr.length-1; i>=0; i--){
                     r[++j] ='<tr><td>';
                     r[++j] = userArr[i].id;
                     r[++j] = '</td><td>';
                     r[++j] = userArr[i].username;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].firstName;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].lastName;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].roleName;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].blockName;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].level;
                     r[++j] = '</td><td >';
                     r[++j] = userArr[i].unit;
                     r[++j] = '</td><td >';
                     r[++j] = "<a href= '#editUserModal' role='button' data-toggle='modal' class='btn btn-primary btn-mini' onclick='populateEditUserModal(" + userList[i].id + ");loadValidate()'>Edit</a>\n\
                               <a href='#' class='btn btn-success btn-mini'>Reset Password</a>\n\
                               <a href='#deleteUserModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteUserModal(" + userList[i].id + ")'>Delete</a>";
                     r[++j] = '</td></tr>';
                }
                $('#userTable').html(tableHeaders + r.join('')); 
            }
            
            // This method is used to filter the user list shown to admin
            // when the filter selection is chosen
            function filterByBlockname(){
                
                var block = $('#blockSelect').val();
                
                var tempArr = [];
                
                for(var i=0;i<userList.length;i++){
                    console.log(name);
                    if(userList[i].blockName == block){
                        tempArr.push(userList[i]);
                    }
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No users found!");
                }
                else{
                    showUsers(tempArr);
                }
                
            }
            
            function filterByRole(){
                var role = $('#roleSelect').val();
                
                var tempArr = [];
                
                for(var i=0;i<userList.length;i++){
                    console.log(name);
                    if(userList[i].roleName == role){
                        tempArr.push(userList[i]);
                    }
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No users found!");
                }
                else{
                    showUsers(tempArr);
                    
                }
            }
            
        </script>
        
            <script src="../js/jquery.min.js"></script>
            <script src="../js/jquery.ui.custom.js"></script>
            <script src="../js/bootstrap.min.js"></script>

            <script src="../js/jquery.flot.min.js"></script>
            <script src="../js/jquery.flot.resize.min.js"></script>
            <script src="../js/jquery.peity.min.js"></script>

            <script src="../js/jquery.uniform.js"></script>
            <script src="../js/jquery.chosen.js"></script>
            <script src="../js/jquery.validate.js"></script>
            
    </head>
    <body onload="showUsers(userList)">


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
                <li class="submenu active open">
                    <a href="manageusers.jsp"><i class="icon icon-th-list"></i> <span>Users</span> <span class="label">3</span></a>
                    <ul>
                        <li class ="active"><a href="manageusers.jsp">Manage Users</a></li>
                        <li><a href="approveaccounts.jsp">Approve Pending Accounts</a></li>
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

        </div>



        <div id="content">
            <div id="content-header">
                <h1> Manage Users </h1>
                <div class="btn-group">
                    <a class="btn btn-large tip-bottom" title="Manage Files"><i class="icon-file"></i></a>
                    <a class="btn btn-large tip-bottom" title="Manage Users"><i class="icon-user"></i></a>
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
                <a href="#" class="current">Users</a>
            </div>
            <div class="container-fluid">

                <div class="row-fluid">
                    <div class="span12">
                        <c:if test = "${param.createsuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> There was an error creating a user. Please try again!
                            </div>
                        </c:if> 
                        <c:if test = "${param.createsuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.createmsg} was added to the user list!
                            </div>
                        </c:if>
                            <c:if test = "${param.deletesuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> The user could not be deleted.
                            </div>
                        </c:if> 
                        <c:if test = "${param.deletesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.deletemsg} was successfully deleted!
                            </div>
                        </c:if>
                        <c:if test = "${param.approvesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.approvemsg} was added to the user list!
                            </div>
                        </c:if>
                            
                        <!-- Add New User -->   
                        <div class="widget-box">
                            <div title="Click to add a new user" onclick="loadValidate()" data-target="#collapseTwo" data-toggle="collapse" class="widget-title clickable tip-top" id="newUserForm">
                                <span class="icon">
                                    <i class="icon-plus"></i>									
                                </span>
                                <h5>Add New User</h5>
                            </div>
                            <div class="addUser collapse" id="collapseTwo">
                                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageUsersActionBean" focus="" name="new_user_validate" id="new_user_validate">
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Role</label>
                                        <div class="controls">
                                            <stripes:select name="role">
                                                <stripes:options-collection collection="${manageUsersActionBean.roleList}" value="name" label="name"/>        
                                            </stripes:select>
                                        </div>
                                    </div>

                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Username</label>
                                        <div class="controls">
                                            <stripes:text name="username"/>
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Password</label>
                                        <div class="controls">
                                            <stripes:password name="password" id="password"/>
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Confirm Password</label>
                                        <div class="controls">
                                            <stripes:password  name="passwordconfirm" id="passwordconfirm"/>
                                        </div>
                                    </div>                             
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">First Name</label>
                                        <div class="controls">
                                            <stripes:text name="firstname"/> 
                                        </div>
                                    </div>                              
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Last Name</label>
                                        <div class="controls">
                                            <stripes:text name="lastname"/> 
                                        </div>
                                    </div>
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Block</label>
                                        <div class="controls">
                                            <stripes:text name="block"/> 
                                        </div>
                                    </div>  
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Level</label>
                                        <div class="controls">
                                            <stripes:text name="level"/>
                                        </div>
                                    </div>     
                                    <div class="control-group ${errorStyle}">
                                        <label class="control-label">Unit Number</label>
                                        <div class="controls">
                                            <stripes:text name="unitnumber"/>
                                        </div>
                                    </div> 

                                    <div class="form-actions">
                                        <input type="submit" name="createUserAccount" value="Add this user" class="btn btn-info btn-large">
                                    </div>                            
                                </stripes:form>

                            </div>
                        </div>						
                    </div>
                    <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon"><i class="icon-user"></i></span><h5>Users</h5>
                            <div class="float_r filterOptions">
                                 <h5>or</h5>
                                        <select id ="roleSelect" onChange="filterByRole()">
                                            <option>-Select Role-</option>
                                            <option>Resident</option>
                                            <option>MCST</option>
                                            <option>Administrator</option>
                                        </select>
                            </div>
                            <div class="float_r filterOptions">
                                 <h5> Filter By: </h5>
                                    <select id ="blockSelect" onChange="filterByBlockname()">
                                            <option>-Select Block-</option>
                                            <option>A</option>
                                            <option>B</option>
                                            <option>1</option>
                                            <option>blockname</option>
                                        </select>
                            </div>
                        </div>
                        <c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">
                            <script>
                                var user = new Object();
                                user.id = '${user.userId}';
                                user.username = '${user.userName}';
                                user.firstName = '${user.firstname}';
                                user.lastName = '${user.lastname}';
                                user.roleName = '${user.role.name}';
                                user.blockName = '${user.block.blockName}';
                                user.level = '${user.level}';
                                user.unit = '${user.unit}';
                                userList.push(user);
                            </script>
                                                        
                        </c:forEach>
                        
                        <div class="widget-content">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="widget-content nopadding">
                                        <ul class="recent-comments"> 
                                            <table id="userTable" class="table table-striped users">
                                                   <!-- Elements dynamically added in -->
                                            </table>    
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

                <div class="row-fluid">
                    <div id="footer" class="span12">

                    </div>
                </div>
            </div>

            <!-- Edit User Modal Form -->
            <div id="editUserModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Edit <span id="usernameLabel"></span>'s information</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditUserBean" focus="" name="edit_user_validate" id="edit_user_validate">
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Role</label>
                            <div class="controls">
                                <stripes:select name="role">
                                    <stripes:options-collection collection="${manageUsersActionBean.roleList}" value="id" label="name"/>        
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
                        <input type="submit" name="editUser" value="Confirm Edit" class="btn btn-primary"/>
                    </div>
                </stripes:form>
            </div>


            <script>
                function loadValidate(){
                    $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                    $('select').chosen();

                    $("#new_user_validate").validate({
                        rules:{
                            username:{
                                required: true,
                                minlength:5,
                                maxlength:20
                            },
                            password:{
                                required: true,
                                minlength:6,
                                maxlength:20
                            },
                            passwordconfirm:{
                                required:true,
                                minlength:6,
                                maxlength:20,
                                equalTo:"#password"
                            },firstname:{
                                required: true
                            },lastname:{
                                required: true
                            },block:{
                                required: true
                            },level:{
                                required: true,
                                digits:true
                            },unitnumber:{
                                required: true,
                                digits:true
                            }
                        },
                        errorClass: "help-inline",
                        errorElement: "span",
                        highlight:function(element, errorClass, validClass) {
                            $(element).parents('.control-group').addClass('error');
                        },
                        unhighlight: function(element, errorClass, validClass) {
                            $(element).parents('.control-group').removeClass('error');
                            $(element).parents('.control-group').addClass('success');
                        }
                    });
                    
                    $("#edit_user_validate").validate({
                        rules:{
                            username:{
                                required: true,
                                minlength:5,
                                maxlength:20
                            },
                            password:{
                                required: true,
                                minlength:6,
                                maxlength:20
                            },
                            passwordconfirm:{
                                required:true,
                                minlength:6,
                                maxlength:20,
                                equalTo:"#password"
                            },firstname:{
                                required: true
                            },lastname:{
                                required: true
                            },block:{
                                required: true
                            },level:{
                                required: true,
                                digits:true
                            },unitnumber:{
                                required: true,
                                digits:true
                            }
                        },
                        errorClass: "help-inline",
                        errorElement: "span",
                        highlight:function(element, errorClass, validClass) {
                            $(element).parents('.control-group').addClass('error');
                        },
                        unhighlight: function(element, errorClass, validClass) {
                            $(element).parents('.control-group').removeClass('error');
                            $(element).parents('.control-group').addClass('success');
                        }
                    });
                }
            </script>


            <!-- Delete User Modal -->
            <div id="deleteUserModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Deletion of <span id="usernameDeleteLabel"></span>'s account</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteUserBean" focus=""> 
                        You are now deleting <span id="delete_firstname"></span> <span id="delete_lastname"></span>'s account. Are you sure?
                    </div>
                    <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">Close</a>
                        <stripes:hidden id="delete_username" name="username"/>
                        <stripes:hidden id="delete_id" name="id"/>
                        <input type="submit" name="deleteUser" value="Confirm Delete" class="btn btn-danger"/>
                    </div>
                </stripes:form>
            </div>

            <!--<script src="js/excanvas.min.js"></script>-->


            <script src="../js/lin.manageusers.js"></script>
            <script src="../js/fullcalendar.min.js"></script>
            <script src="../js/unicorn.js"></script>
            <script src="../js/unicorn.dashboard.js"></script>
            <script src="../js/unicorn.form_common.js"></script>
    </body>

</html>
