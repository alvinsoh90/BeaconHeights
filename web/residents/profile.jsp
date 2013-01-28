<%-- 
    Document   : profile
    Created on : Jan 28, 2013, 13:36:07 PM
    Author     : jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.general.admin.ManagePostBean"/>
        <jsp:useBean id="manageUsersActionBean" scope="page"
                     class="com.lin.general.admin.ManageUsersActionBean"/>
        <jsp:useBean id="editUserBean" scope="page"
                     class="com.lin.general.admin.EditUserBean"/>
        <jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>
        
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
        <script>
            var levels="";
            var units = "";
            window.onload = function() {
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
                            levelOptions += '<option value="' + i + '">' + i + '</option>';
                        };
                        for (var i=1;i<units+1;i++){
                            unitOptions += '<option value="' + i + '">' + i + '</option>';
                        };
                        $("select#level").html(levelOptions);
                        $("select#unitnumber").html(unitOptions);
                    }
                });
            };  
        </script>
        <!-- Populates the Edit User form -->       
        <script>
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
                        $("#edit_mobileno").val(user.mobileNo);
                        $("#edit_email").val(user.email);
                        $("#edit_birthday").val(user.birthday);
                        $("#edit_studiedAt").val(user.studiedAt);
                        $("#edit_worksAt").val(user.worksAt);
                        $("#edit_aboutMe").val(user.aboutMe);
                    }
                });
                
            }
        </script>
    </head>
    <body>

        
        <div id="content">

            <div class="container">
                <div class="span9">
                    <div id="personaldetails">
                        <div class="span1">
                            <img src="http://png.findicons.com/files/icons/756/ginux/64/user.png" />
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
                                user.mobileNo = '${user.mobileNo}';
                                user.birthday = '${user.birthday}';
                                user.email = '${user.email}';
                                user.studiedAt = '${user.studiedAt}';
                                user.worksAt = '${user.worksAt}';
                                user.aboutMe = '${user.aboutMe}';
                                userList.push(user);
                            </script>
                            <c:if test="${user.userId==param.profileId}">
                                <div class="span3">
                                    <h3>${user.firstname} ${user.lastname}</h3>
                                    <!-- give user the option to show these details -->
                                    <b>Member Since:</b> ${user.dob}<br/>
                                    <b>Mobile No. :</b> ${user.mobileNo}<br/>
                                    <b>Email:</b> ${user.email}<br/>
                                    <b>Birthday:</b> ${user.birthday}<br/>
                                    <b>Studied at:</b> ${user.studiedAt}<br/>
                                    <b>Works at:</b> ${user.worksAt}<br/>
                                    <b>About me:</b> ${user.aboutMe}<br/>
                                </div>
                            </c:if>
                        
                        </c:forEach>
                        <c:if test="${user.userId==param.profileId}">
                            <div class="span2">
                            <a href= '#editUserModal' role='button' data-toggle='modal' class='btn' onclick='populateEditUserModal(${param.profileId});loadValidate()'><i class="icon-pencil"></i> Update Info</a>
                            </div>
                        </c:if>
                        <c:if test="${user.userId!=param.profileId}">
                        <div class="span2">
                            <!-- should only appear if is not current user and is not if friends list-->
                            <div id="addFriend"><a href="#" class="btn btn-info"><i class="icon-user"></i> Friend This User</a></div>
                        </div>
                        </c:if>
                    </div>
                </div>
                        
                        
            <!-- Edit User Modal Form -->
            <div id="editUserModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Edit <span id="usernameLabel"></span>'s information</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditUserBean" focus="" name="editUserProfile" id="edit_user_validate">

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
                                <stripes:select name="level" id="level">
                                </stripes:select>                            </div>
                        </div>     
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Unit Number</label>
                            <div class="controls">
                                <stripes:select name="unitnumber" id ="unitnumber">
                                </stripes:select>                             </div>
                        </div>    
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Mobile Number</label>
                            <div class="controls">
                                <stripes:text id="edit_mobileno" name="mobileno"/>   
                            </div>
                        </div>  
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Email</label>
                            <div class="controls">
                                <stripes:text id="edit_email" name="email"/> 
                            </div>
                        </div>  
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Birthday</label>
                            <div class="controls">
                                <stripes:text id="edit_birthday" name="birthday"/>
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Studied At</label>
                            <div class="controls">
                                <stripes:text id="edit_studiedAt" name="studiedAt"/>
                            </div>
                        </div>
                         
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Works At</label>
                            <div class="controls">
                                <stripes:text id="edit_worksAt" name="worksAt"/>
                            </div>
                        </div> 
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">About Me</label>
                            <div class="controls">
                                <stripes:textarea id="edit_aboutMe" name="aboutMe"/>
                            </div>
                        </div>
                    </div> 
                    
                    <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">Close</a>
                        <stripes:hidden id="role" name="role" value="${user.role.id}"/>
                        <stripes:hidden id="username" name="username" value="${user.userName}"/>
                        <stripes:hidden id="id" name="id" value="${user.userId}"/>
                        <stripes:hidden id="facebookId" name="facebookId" value="${user.facebookId}"/>
                        <input type="submit" name="editUserProfile" value="Confirm Edit" class="btn btn-primary"/>
                    </div>
                </stripes:form>
            </div>



                <div class="span9">
                    <div class="widget widget-table">
                        <!-- should be the same as community wall's posts, except it only has user's posts -->
                        <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">
                            <b>${post.user.userName}</b></br>
                            ${post.message}</br>
                            ${post.date}
                            <hr>
                        </c:forEach>
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
