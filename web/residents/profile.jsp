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
        <jsp:useBean id="addFriendActionBean" scope="page"
                     class="com.lin.resident.AddFriendActionBean"/>


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
            
            function populateAddFriendModal(userID){ 
                userList.forEach(function(user){
                    if(user.id == userID){
                        $("#friend_username").text(user.username);
                        $("#friend_id").val(user.id);
                        $("#friend_username").val(user.username);
                        $("#friend_name").text(user.firstName + " " + user.lastName);
                    }
                });
                
            }
            
            
        </script>
    </head>
    <body>


        <div id="content">

            <div class="container">
                <div class="row-fluid">
                    <div class="span"/>
                    <div class="span10 offset1">
                        <div id="personaldetails" class="profileTopWrapper">

                            <c:forEach items="${manageUsersActionBean.userList}" var="userObj" varStatus="loop">
                                <script>
                                    var user = new Object();
                                    user.id = '${userObj.userId}';
                                    user.username = '${userObj.userName}';
                                    user.firstName = '${userObj.firstname}';
                                    user.lastName = '${userObj.lastname}';
                                    user.roleName = '${userObj.role.name}';
                                    user.blockName = '${userObj.block.blockName}';
                                    user.level = '${userObj.level}';
                                    user.unit = '${userObj.unit}';
                                    user.mobileNo = '${userObj.mobileNo}';
                                    user.birthday = '${userObj.birthday}';
                                    user.email = '${userObj.email}';
                                    user.studiedAt = '${userObj.studiedAt}';
                                    user.worksAt = '${userObj.worksAt}';
                                    user.aboutMe = '${userObj.aboutMe}';
                                    user.profilePicFilename = '${userObj.profilePicFilename}';
                                    userList.push(user);
                                </script>
                                <c:if test="${userObj.userId==param.profileid}">
                                    <c:if test="${param.profileid!=null}">
                                        <div class="profileMainImgArea span3">
                                            <img style="background:gray;width:200px;height:200px;" src="/uploads/profile_pics/${userObj.profilePicFilename}" />
                                            <c:if test="${user.userId==param.profileid}">
                                                <a href='#editPicModal' role="button" data-toggle='modal' onclick='loadValidate()' class="btn btn-info btn-mini newProfilePicLink">Upload New Picture</a> 
                                            </c:if>
                                        </div>

                                        <div class="span4 profileContent">
                                            <h1>${userObj.firstname} ${userObj.lastname}</h3>
                                                <!-- give user the option to show these details -->
                                                <b>Member Since:</b> ${userObj.dob}<br/>
                                                <b>Mobile No. :</b> ${userObj.mobileNo}<br/>
                                                <b>Email:</b> ${userObj.email}<br/>
                                                <b>Birthday:</b> ${userObj.birthday}<br/>
                                                <b>Studied at:</b> ${userObj.studiedAt}<br/>
                                                <b>Works at:</b> ${userObj.worksAt}<br/>
                                                <b>About me:</b> ${userObj.aboutMe}<br/>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <c:if test="${param.profileid==null}">
                                <div class="span4">
                                    <img src="/uploads/profile_pics/${user.profilePicFilename}" />
                                    <a href='#editPicModal' role="button" data-toggle='modal' onclick='loadValidate()' id="newProfilePicLink" class="btn btn-info btn-mini">Upload New Picture</a> 
                                </div>

                                <div class="span4">
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
                            <c:if test="${user.userId==param.profileid}">
                                <div class="span2">
                                    <a href= '#editUserModal' role='button' data-toggle='modal' class='btn' onclick='populateEditUserModal(${param.profileid});loadValidate()'><i class="icon-pencil"></i> Update Info</a>
                                </div>
                            </c:if>
                            <c:if test="${user.userId!=param.profileid}">
                                <div class="span2">
                                    <!-- if friendController.isFriend() -->
                                    <div id="addFriend"><a href="#addFriendModal" role="button" data-toggle="modal" class="btn btn-info" onclick='populateAddFriendModal(${param.profileid});loadValidate()'><i class="icon-user"></i> Friend This User</a></div>
                                    <!-- else 
                                    <a href='' role="button" class="btn"><i class="icon-user"></i> Friends</a>
                                    -->

                                </div>
                            </c:if>
                            <br class="clearfix"/>
                        </div>
                    </div>

                    <br class="clearfix"/>
                    <br class="clearfix"/>
                    <br class="clearfix"/>
                    <!-- Profile Wall -->

                    <div class="postWrapper offset1">
                        <div class="leftContent span2">
                            <div class="posterInfo">
                                <img style="height:75px;width:75px;border-radius:3px;background:black;"/>
                                <div class="name">Jocelyn Tan</div>

                            </div>

                            <div class="postIcon wallicon shoe">
                                <div class="timeline"/></div>
                        </div>
                    </div>
                    <div class="post span6">
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
                                <div class="content float_l">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_l">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_l">
                                    <b>Shamus Ming: </b>hey jocelyn! my gf is over at my place again but we're really bored, so this is perfect! what's is your skill level? We're not so great but will come anyway!
                                </div>
                                <br class="clearfix"/>
                            </div>
                            <div class="comment">
                                <img style="margin-top: 3px;background:blue;height:35px;width:35px;" class="float_l"/>
                                <div class="content float_l">
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
                        <input type="submit" name="editUserProfile" value="Confirm Edit" class="btn btn-info"/>
                    </div>
                </stripes:form>
            </div>
            <!-- Edit Pic Modal Form -->
            <div id="editPicModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Upload A New Profile Picture</h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.UploadProfilePicActionBean" name="new_resource_validate" id="new_resource_validate">                 
                        <stripes:hidden name="user_id" value="${user.userId}" />
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">File:</label>
                            <div class="controls">
                                <stripes:file name="file"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" name="upload" value="Upload" class="btn btn-info btn-large"/>                                                           
                        </stripes:form>
                    </div>
                </div>      
            </div>

            <!-- Add Friend Modal -->
            <div id="addFriendModal" class="modal hide fade">
                <div id="myModal" class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                    <h3>Add <span id="friend_username" name=""></span></h3>
                </div>
                <div class="modal-body">
                    <stripes:form class="form-horizontal" beanclass="com.lin.resident.AddFriendActionBean" name="addFriend" id="addFriend">                 
                        <stripes:hidden id="friend_id" name="friendId" />
                        <stripes:hidden id="userId" name="userId" value="${user.userId}"/>
                        Add <span id="friend_name"></span> as a friend?
                        <br/>
                        <input type="submit" name="add" value="Add Friend" class="btn btn-info btn-large"/>                                                          
                    </stripes:form>
                </div>
            </div>      
        </div>





        <!--<div class="span9">
            <div class="widget widget-table">
        <!-- should be the same as community wall's posts, except it only has user's posts 
        <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">
            <b>${post.user.userName}</b></br>
            ${post.message}</br>
            ${post.date}
            <hr>
        </c:forEach>
    </div>
</div>
</div> -->


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
