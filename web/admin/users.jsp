<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<%@include file="/protect.jsp"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Users | Strass</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">

    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
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
                    r[++j] ='<tr class="list-users"><td>';
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
                                        
                    r[++j] = '<div class="btn-group" style="visibility:visible !important;">'
		    r[++j] =      '<a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>'
		    r[++j] =					'<ul class="dropdown-menu">'
		    r[++j] =						"<li><a href='#editUserModal' role='button' data-toggle='modal' onclick='populateEditUserModal(" + userList[i].id + ");loadValidate()'><i class='icon-pencil'></i> Edit</a></li>"
			r[++j] =					"<li><a href='#deleteUserModal' role='button' data-toggle='modal' onclick='populateDeleteUserModal(" + userList[i].id + ")'><i class='icon-trash'></i> Delete</a></li>"
			r[++j] =					'<li><a href="#"><i class="icon-user"></i> Details</a></li>'
			r[++j] =					'<li class="nav-header">Permissions</li>'
			r[++j] =					'<li><a href="#"><i class="icon-lock"></i> Make <strong>Admin</strong></a></li>'
			r[++j] =					'<li><a href="#"><i class="icon-lock"></i> Make <strong>Moderator</strong></a></li>'
			r[++j] =					'<li><a href="#"><i class="icon-lock"></i> Make <strong>User</strong></a></li>'
			r[++j] =				'</ul>'
			r[++j] =			'</div>'                     
                                        
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
        <%-- Load users from database into javascript array --%>
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
        
  </head>
  <body  onload="showUsers(userList)">
    <%@include file="include/mainnavigationbar.jsp"%>
    
    <div class="container-fluid">
        
      <%@include file="include/sidemenu.jsp"%>
      
        <div class="span9">

		  <div class="row-fluid">
                      <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>
                      
			<div class="page-header">
				<h1>Users <small>All users</small></h1>
			</div>
                        <!-- User Filter Dropdown Boxes -->
                        <div class="userFilterBar float_r">
                            <div class="inlineblock filterOptions">
                                <h5 class="inlineblock"> Filter By: </h5>
                                
                                <select id ="roleSelect" onChange="filterByRole()">
                                    <option>-Select Role-</option>
                                    <option>Resident</option>
                                    <option>MCST</option>
                                    <option>Administrator</option>
                                </select>
                            </div>
                                <h5 class="inlineblock">or</h5>
                            
                            <div class="inlineblock filterOptions">
                                <select id ="blockSelect" onChange="filterByBlockname()">
                                    <option>-Select Block-</option>
                                    <option>A</option>
                                    <option>B</option>
                                    <option>1</option>
                                    <option>blockname</option>
                                </select>
                            </div>
                        </div>
                      
			<table id="userTable" class="table table-striped table-bordered table-condensed">
				
			</table>
			<div class="pagination">
				<ul>
					<li><a href="#">Prev</a></li>
					<li class="active">
						<a href="#">1</a>
					</li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">Next</a></li>
				</ul>
			</div>
			<a href="new-user.jsp" class="btn btn-success">New User</a>
		  </div>
        </div>
      </div>

      <hr>
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
                                <stripes:select name="block">
                                    <stripes:options-collection collection="${registerActionBean.allBlocks}" value="blockName" label="blockName"/>        
                                </stripes:select>
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

      <footer class="well">
        &copy; Strass
      </footer>

    </div>

    <script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
		$('.dropdown-menu li a').hover(
		function() {
			$(this).children('i').addClass('icon-white');
		},
		function() {
			$(this).children('i').removeClass('icon-white');
		});
		
		if($(window).width() > 760)
		{
			$('tr.list-users td div ul').addClass('pull-right');
		}
	});
	</script>
        
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
  </body>
</html>