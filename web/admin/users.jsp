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
<%@include file="/protectadmin.jsp"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Users</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <script src="js/jquery.js"></script>
                <script src="js/bootstrap.min.js"></script>
        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="/datatables/media/js/jquery.dataTables.js"></script>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <script src="/js/custom/lin.register.js"></script>
        <script src="/js/jquery.validate.js"></script>

        

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
                        $("#edit_email").val(user.email);
                        $("#edit_mobileno").val(user.mobileNo);
                        $("#edit_role").val(user.roleName);
                        $("#edit_level").val(user.level);
                        $("#edit_unit").val(user.unit);
                        $("#edit_vehicleType").val(user.vehicleType);
                        $("#edit_vehicleNumberPlate").val(user.vehicleNumberPlate);
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
            
        </script>
        <%-- Load users from database into javascript array --%>
        <c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">
            <script>
                                
                var user = new Object();
                user.id = '${user.userId}';
                user.username = '${user.escapedUserName}';
                user.firstName = '${user.escapedFirstName}';
                user.lastName = '${user.escapedLastName}';
                user.roleName = '${user.role.name}';
                user.email = '${user.email}';
                user.mobileNo= '${user.mobileNo}';
                user.blockName = '${user.block.blockName}';
                user.level = '${user.level}';
                user.unit = '${user.unit}';
                user.vehicleNumberPlate = '${user.vehicleNumberPlate}';
                user.vehicleType = '${user.vehicleType}';
                userList.push(user);
            </script>
        </c:forEach>
        <script>
            var levels="";
            var units = "";
            
            function loadLevelsAndUnits() {
                console.log("loading");
                var source = "/json/loadblockproperties.jsp?blockName="+$('select#block').val();
                $.ajax({
                    url: "/json/loadblockproperties.jsp",
                    type: "GET",
                    data:"blockName="+$('select#block').val(),
                    dataType: 'text',
                    success: function (data) {
                        var obj = jQuery.parseJSON(data);
                        levels = obj.levels;
                        units = obj.units;
                        
                        var levelOptions="";
                        var unitOptions = "";
                        for (var i=1;i<levels+1;i++){
                            if(i<10){
                                levelOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                levelOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        for (var i=1;i<units+1;i++){
                            if(i<10){
                                unitOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                unitOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        $("select#level").html(levelOptions);
                        $("select#unitnumber").html(unitOptions);
                        
                        // only after successful loading should we load this 'sexy chosen' plugin	
                        $('select').chosen();
                    }
                });
            };
            
            $(document).ready(function(){    
            
                // When document loads fully, load level and unit options via AJAX
                loadLevelsAndUnits();

                // if dropdown changes, we want to reload the unit and level options.
                $("#block").change(function(){
                    loadLevelsAndUnits();
                });
                
                 $('#userDataTable').dataTable({
                     "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                 });

            });
            
        </script>
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
                    
                    <table id="userDataTable" class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Mobile No.</th>
                            <th>Level</th>
                            <th>Unit</th>
                            <th>Action</th>
                            </tr>
                        </thead>
                         <tbody>
                    <c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">

                        <tr>
                        <td>${user.userId}</td>
                        <td>${user.userName}</td>
                        <td>${user.firstname}</td>
                        <td>${user.lastname}</td>
                        <td>${user.role.name}</td>
                        <td>${user.email}</td>
                        <td>${user.mobileNo}</td>
                        <td>${user.level}</td>
                        <td>${user.unit}</td>
                        <td>
                            <div class="btn-group" style="visibility:visible !important;">
                                <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#">Actions <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                    <li><a href="#editUserModal" role="button" data-toggle="modal" onclick="populateEditUserModal(${user.userId});loadValidate()"><i class="icon-pencil"></i> Edit</a></li>
                                    <li><a href="#deleteUserModal" role="button" data-toggle="modal" onclick="populateDeleteUserModal(${user.userId})"><i class="icon-trash"></i> Delete</a></li>
                                </ul>
                            </div>
                        </td>

                        </tr>

                    </c:forEach>
                        </tbody>
                    </table>    

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
                            <stripes:select name="block" id ="block">
                                <stripes:options-collection collection="${registerActionBean.allBlocks}" value="blockName" label="blockName"/>        
                            </stripes:select>
                        </div>
                    </div> 
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Level</label>
                        <div class="controls">
                            <stripes:select name="level" id="level">
                            </stripes:select>                             </div>
                    </div>     
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Unit Number</label>
                        <div class="controls">
                            <stripes:select name="unitnumber" id ="unitnumber">
                            </stripes:select>                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Vehicle Number Plate</label>
                        <div class="controls">
                            <stripes:text id="edit_vehicleNumberPlate" name="vehicleNumberPlate"/> 
                        </div>
                    </div> 
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Vehicle Type</label>
                        <div class="controls">
                            <stripes:text id="edit_vehicleType" name="vehicleType"/> 
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
            &copy; Charis
        </footer>



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
                $('select').chosen();
         
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