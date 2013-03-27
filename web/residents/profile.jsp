<%-- 
    Document   : profile
    Created on : Jan 28, 2013, 13:36:07 PM
    Author     : jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

        <jsp:useBean id="manageUsersActionBean" scope="page"
                     class="com.lin.general.admin.ManageUsersActionBean"/>
        <jsp:useBean id="editUserBean" scope="page"
                     class="com.lin.general.admin.EditUserBean"/>
        <jsp:useBean id="registerActionBean" scope="page"
                     class="com.lin.general.login.RegisterActionBean"/>
        <jsp:useBean id="addFriendActionBean" scope="page"
                     class="com.lin.resident.AddFriendActionBean"/>
        <jsp:useBean id="utilBean" scope="page"
                     class="com.lin.utils.UtilityFunctionsBean"/>


        <%@include file="/protect.jsp"%>
        <%@include file="/header.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    

        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="../css/font-awesome.min.css" rel="stylesheet">

        <link href="./css/adminia.css" rel="stylesheet"> 
        <link href="./css/adminia-responsive.css" rel="stylesheet"> 
        <link href="./css/residentscustom.css" rel="stylesheet"> 

        <link href="./css/pages/dashboard.css" rel="stylesheet"> 

        

        <script src="/js/bootstrap-2.3.0.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <link href="/css/custom/lin.css" rel="stylesheet" />
        <link href="/css/pickadate.03.inline.css" rel="stylesheet" />
        <script src="../js/pickadate.js"></script>
        <script src="../js/pickadate.min.js"></script>
        <script src="../js/custom/lin.facebookfunctions.js"></script>

        <script>
            var success = "${SUCCESS}";
            var failure = "${FAILURE}";
            if(success != ""){
                toastr.success(success);
            }
            else if(failure){
                var msg = "<b>There was an error with submitting your form.</b><br/>";
                msg += "<ol>"
            <c:forEach var="message" items="${MESSAGES}">
                    msg += "<li>${message}</li>";
            </c:forEach>
                    msg += "</ol>";    
                    toastr.errorSticky(msg);
                }

                //load levels and units in the dropdown
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
                            //$('select').chosen();
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
                });
            
                function loadDatePicker(){
                
                    $('.picker_inline').pickadate({
                        format: 'yyyy-mm-dd',
                        formatSubmit: 'yyyy-mm-dd',
                        monthSelector: true,
                        yearSelector: 100,
                        dateMax: true
                    });
                
                }
            
                $(function(){
                    $('#file').change(function(){
                        var file=this.files[0];
                        if(file.fileSize > 3145728 || file.size > 3145728){
                            $("#uploadBtn").css("opacity","0.6");
                            $("#uploadBtn").css("pointer-events","none");
                            $("#fileInfoMsg").text("File size is too big, please limit your file size to 3mb.");
                        }else {
                            $("#uploadBtn").css("opacity","1");
                            $("#uploadBtn").css("pointer-events","auto");
                            $("#fileInfoMsg").text("");
                        }
                    })
                })
            
        </script>
    </head>
    <body onload="loadDatePicker()">


        <div id="content">

            <div class="container">
                <div class="row-fluid">
                    <div class="span"/>
                    <div class="span10 offset1">
                        <div id="personaldetails" class="profileTopWrapper">
                            <c:if test="${param.profileid!=null}">
                                <c:forEach items="${manageUsersActionBean.userList}" var="userObj" varStatus="loop">

                                    <c:if test="${userObj.userId==param.profileid}">

                                        <div class="profileMainImgArea span3">
                                            <img style="background:gray;width:200px;height:200px;" src="/uploads/profile_pics/${userObj.profilePicFilename}" />
                                            <c:if test="${user.userId==param.profileid}">
                                                <a href='#editPicModal' role="button" data-toggle='modal' class="btn btn-info btn-mini newProfilePicLink">Upload New Picture</a> 
                                            </c:if>
                                        </div>

                                        <div class="span4 profileContent">
                                            <h1>${userObj.firstname} ${userObj.lastname}</h3>
                                                <!-- give user the option to show these details -->
                                                <c:if test="${user.userId==param.profileid || addFriendActionBean.isFriend(user.userId,param.profileid)}">
                                                    <b>Member Since:</b> ${userObj.dob}<br/>
                                                    <b>Mobile No. :</b> ${userObj.mobileNo}<br/>
                                                    <b>Email:</b> ${userObj.email}<br/>
                                                    <b>Birthday:</b> ${userObj.birthday}<br/>
                                                    <b>Studied at:</b> ${userObj.studiedAt}<br/>
                                                    <b>Works at:</b> ${userObj.worksAt}<br/>
                                                    <b>About me:</b> ${userObj.aboutMe}<br/>
                                                </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>  
                             <%@include file="/included/facebook/initfacebook.jsp"  %>
                             <script>
                                 $(document).ready(function(){                                                                          
                                     FB.getLoginStatus(function(response) {
                                         if (response.status === 'connected') {
                                             // connected
                                             console.log("connected");
                                         } else if (response.status === 'not_authorized') {
                                             // not_authorized                                             
                                             
                                         } else {
                                             // not_logged_in                                             
                                         }
                                     });                                     
                                 })
                                 
                                 function login() {
                                    FB.login(function(response) {
                                        if (response.authResponse) {
                                            // connected
                                            console.log(response);
                                            //post to our server
                                            var dat = new Object();
                                            dat.accessToken = response.accessToken;
                                            dat.fbUserId = response.authResponse.userID;
                                            
                                            $.ajax({
                                                type: "POST",
                                                url: "/json/facebook/connectFacebook.jsp?isFirstConnect=true",
                                                data: dat,
                                                success: function(data, textStatus, xhr) {
                                                    if(xhr.status == 200 && data.success){
                                                        //connect facebook success, now replace div with connected info
                                                        toastr.success("Successfully connected facebook!");
                                                        setTimeout("window.location.reload()",2000);
                                                        showFacebookLoggedIn();
                                                    }
                                                    else if(xhr.status == 200 && data.isAlreadyConnected){
                                                        toastr.info("A facebook account is already connected to this account.");
                                                        showFacebookLoggedIn();
                                                    }
                                                    else{
                                                        //failed. 
                                                        toastr.error("There was an error connecting your facebook account. Please try again later.");
                                                    }
                                                }
                                            });
                                                                                        
                                        } else {
                                            toastr.warning("Facebook connect cancelled");
                                        }
                                    },{perms:'read_stream,publish_stream,user_groups,user_likes,user_groups,create_event'});
                                }
                                
                                function showFacebookLoggedIn(){
                                    FB.api('/me',{access_token: '${fb_access_token}'}, function(response) {
                                        
                                        if(!response.error){
                                           $("#fb-name").text("Connected as " + response.name);
                                            console.log(response);
                                            $('#fbImg').attr("src", "https://graph.facebook.com/" + response.id + "/picture"); 
                                            $("#ajax-spinner").css("opacity","0");
                                            $("#facebookConnectArea").slideDown(400);
                                        }
                                        else{
                                            console.log("responsefberror");
                                            console.log(response);
                                            refreshAndExtendToken();                                            
                                        }
                                    });
                                }
                               
                             </script>
                             
                             
                            
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
                                <div class="span3">
                                    <div class="facebookHolder alert alert-warning">
                                        <a href= '#editUserModal' role='button' data-toggle='modal' class='btn'><i class="icon-pencil"></i> Update Info</a> <br/>
                                    </div>
                                    
                                    <c:set var="freshUser" value="${utilBean.refreshUser(user)}" />
                                    <c:choose>
                                        <c:when test="${not empty freshUser.facebookId}">
                                            <div id="facebookConnectArea" class="accountInfoTile hide clearfix">
                                                <blockquote>
                                                    <img id="fbImg" class="pull-left"/>
                                                    <div class="pull-left">
                                                        <p>Facebook Connected <i id="ajax-spinner" class="icon-spinner icon-spin"></i></p>
                                                        <small id="fb-name"></small>
                                                    </div>
                                                </blockquote>
                                            </div>
                                            <script>
                                                $(document).ready(function(){
                                                    showFacebookLoggedIn();
                                                });
                                            </script>
                                        </c:when>
                                        <c:otherwise>
                                           
                                            <div class="accountInfoTile clearfix" style="display:none">
                                                <a href="#fbConnect" onclick="login()" class='btn btn-primary pull-left fbConnect'>Connect <i class="icon-facebook"></i></a>
                                                <blockquote>
                                                    <div class="pull-left">
                                                        <p>Facebook Connect</p>
                                                        <small>Not Connected</small>
                                                    </div>
                                                </blockquote>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>                                    
                                    <br/>                                    
                                    
                                </div>
                            </c:if>
                            <c:if test="${user.userId!=param.profileid}">
                                <div class="span2">
                                    <c:if test="${!addFriendActionBean.isFriend(user.userId,param.profileid)}">
                                        <c:if test="${!addFriendActionBean.isPending(user.userId,param.profileid)}">

                                            <div id="addFriend">
                                                <a href="#addFriendModal" role="button" data-toggle="modal" class="btn btn-info" onclick=''><i class="icon-user"></i> Friend This User</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${addFriendActionBean.isPendingRequester(user.userId,param.profileid)}">

                                            <div id="addFriend">
                                                <a href="#addFriendModal" role="button" data-toggle="modal" class="btn btn-info" onclick=''><i class="icon-user"></i> Pending Approval</a>
                                            </div>
                                        </c:if>
                                        <c:if test="${addFriendActionBean.isPendingReceiver(user.userId,param.profileid)}">

                                            <div id="addFriend">
                                                <a href="#addFriendModal" role="button" data-toggle="modal" class="btn btn-info" onclick=''><i class="icon-user"></i> Accept Request?</a>
                                            </div>
                                        </c:if>

                                    </c:if>
                                    <c:if test="${addFriendActionBean.isFriend(user.userId,param.profileid)}">

                                        <div id="addFriend">
                                            <a href='' role="button" class="btn"><i class="icon-user"></i> Friends</a>
                                        </div>

                                    </c:if>

                                </div>
                            </c:if>
                            <br class="clearfix"/>
                        </div>
                    </div>

                    <br class="clearfix"/>
                    <br class="clearfix"/>
                    <br class="clearfix"/>

                    <!-- Profile Wall -->
                    <!--  <c:if test="${user.userId==param.profileid || addFriendActionBean.isFriend(user.userId,param.profileid)}">
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
                    </c:if> -->

                </div>            

                <!-- Edit User Modal Form -->
                <div id="editUserModal" class="modal hide fade">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Edit <span id="usernameLabel">${user.firstname}</span>'s information</h3>
                    </div>
                    <div class="modal-body">
                        <span class="required">* Required</span>
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditUserBean" focus="" name="editUserProfile" id="edit_user_validate">

                            <div class="control-group ${errorStyle}">
                                <label class="control-label">First Name<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:text id="edit_firstname" name="firstname" value="${user.firstname}"/> 
                                </div>
                            </div>                              
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Last Name<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:text id="edit_lastname" name="lastname" value="${user.lastname}"/> 
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Block<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:select id="block" name="block" value="${user.block.blockName}">
                                        <stripes:options-collection collection="${registerActionBean.allBlocks}" value="blockName" label="blockName" />        
                                    </stripes:select>
                                </div>
                            </div> 
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Level<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:select name="level" id="level" value="${user.level}">
                                    </stripes:select>                            </div>
                            </div>     
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Unit Number<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:select name="unitnumber" id ="unitnumber" value="${user.unit}">
                                    </stripes:select>                             </div>
                            </div>    
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Mobile Number<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:text id="edit_mobileno" name="mobileno" value="${user.mobileNo}" />
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Email<span class="required"> *</span></label>
                                <div class="controls">
                                    <stripes:text id="edit_email" name="email" value="${user.email}" /> 
                                </div>
                            </div>  
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Birthday</label>
                                <div class="controls cal_width">
                                    <stripes:text class = "picker_inline input" id="edit_birthday" name="birthday" value="${user.birthday}" />
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Studied At</label>
                                <div class="controls">
                                    <stripes:text id="edit_studiedAt" name="studiedAt" value="${user.studiedAt}" />
                                </div>
                            </div>

                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Works At</label>
                                <div class="controls">
                                    <stripes:text id="edit_worksAt" name="worksAt" value="${user.worksAt}" />
                                </div>
                            </div> 
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">About Me</label>
                                <div class="controls">
                                    <stripes:textarea id="edit_aboutMe" name="aboutMe" value="${user.aboutMe}"/>
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
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Upload A New Profile Picture</h3>
                    </div>
                    <div class="modal-body">
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.UploadProfilePicActionBean" name="new_resource_validate" id="new_resource_validate">                 
                            <stripes:hidden name="user_id" value="${user.userId}" />
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">File:</label>
                                <div class="controls">
                                    <stripes:file name="file" id="file"/><div id="fileInfoMsg"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" name="upload" value="Upload" class="btn btn-info btn-large" id="uploadBtn"/>                                                           
                            </stripes:form>
                        </div>
                    </div>      
                </div>

                <!-- Add Friend Modal -->
                <div id="addFriendModal" class="modal hide fade">
                    <div id="myModal" class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Add ${manageUsersActionBean.getFirstnameFromId(param.profileid)} to Friends</span></h3>
                    </div>
                    <stripes:form class="form-horizontal" beanclass="com.lin.resident.AddFriendActionBean" name="addFriend" id="addFriend">                 

                        <div class="modal-body">
                            <stripes:hidden id="friend_id" name="friendId" value="${param.profileid}"/>
                            <stripes:hidden id="userId" name="userId" value="${user.userId}"/>
                            Add ${manageUsersActionBean.getFirstnameFromId(param.profileid)} as a friend?
                            <br/>
                            <br/>
                            Note: If you've already sent a friend request to ${manageUsersActionBean.getFirstnameFromId(param.profileid)}, this will withdraw your request!
                            <br/>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" name="add" value="Confirm" class="btn btn-info btn-large"/> 
                        </div>
                    </stripes:form>
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
    <%@include file="/footer.jsp"%>

</body>
</html>
