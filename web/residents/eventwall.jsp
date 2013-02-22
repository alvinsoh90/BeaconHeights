<%-- 
    Document   : eventwall
    Created on : Feb 22, 2013, 11:56:08 AM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Community Wall | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.resident.ManagePostBean"/>
        <jsp:useBean id="manageUsersActionBean" scope="page"
                     class="com.lin.general.admin.ManageUsersActionBean"/>
        <%@include file="/protect.jsp"%>


        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    

        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <%@include file="/header.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">

        <link href="./css/residentscustom.css" rel="stylesheet"> 

        <link rel="stylesheet" href="./css/fullcalendar.css" />	
        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        <script src="./js/unicorn.calendar.js"></script>
        <script src="/js/jquery-1.9.1.min.js"></script>

        <script src="/js/bootstrap-2.3.0.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <link href="/css/custom/lin.css" rel="stylesheet" />
        <link href="/css/pickadate.03.inline.css" rel="stylesheet" />
        <script src="../js/pickadate.js"></script>
        <script src="../js/pickadate.legacy.min.js"></script>
        <script src="../js/pickadate.legacy.js"></script>
        <script src="../js/pickadate.min.js"></script>

        <script>
            function loadDatePicker(){
                
                $('.picker_inline').pickadate({
                    format: 'yyyy-mm-dd',
                    formatSubmit: 'yyyy-mm-dd',
                    monthSelector: true,
                    yearSelector: 100,
                    //dateMax: true
                });
                
            }
            
            // Init an array of all users shown on this page
            var userList = [];
           
            //Loop through userList and output all into table for display
            function showUsers(userArr){           
                
                var r = new Array(), j = -1;
                var string = "<br>";
                var i = 0;
                for (i=userArr.length-1; i>=0; i--){
                    string += "<span class=\"label label-info\" onclick=confirm('"+ userArr[i].username + "')>"
                        + userArr[i].username + "</span>  ";
                    if(i%5==0){
                        string+="</br>"
                    }
                }
                $('#userList').html(string); 
            }
           
            //show confirmed list of users to the user as they select the guest
            function confirm(id){
                alert(id);
                $('#invited').html(id); 
            }
           
        </script>
    </head>

    <body onload="loadDatePicker()">
        <!-- should get friendList instead -->
        <c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">
            <script>
                var user = new Object();
                user.id = '${user.userId}';
                user.username = '${user.userName}';
                user.firstName = '${user.firstname}';
                user.lastName = '${user.lastname}';
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

        <div id="content">

            <div class="container">
                <div class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic" />
                            <div class="name">${user.userName}</div>
                        </div>
                        <div class="postIcon wallicon SHOUTOUT">
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post newSpan">
                        <div class="guestList">
                            <span>Invite:</span>             
                            <input id="searchterm" class="input-medium search-query" value="Search for friends via first name, last name, or email" onfocus="this.value = this.value=='Search for friends via first name, last name, or email'?'':this.value;" onblur="this.value = this.value==''?'Search for friends via first name, last name, or email':this.value;" style="width:350px;"/>
                            <div id="userList"></div>
                            <span>Invited</span>             
                            <hr></br>
                            <div id="invited"></div>
                        </div>
                        <div class="eventBasic">
                        <stripes:form id="makePostForm" beanclass="com.lin.resident.AddPostActionBean" focus="postContent" class ="form-horizontal">
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Name</label>
                                    <div class="controls ">
                                    <stripes:text id="event_name" name="eventname" value=""/> 
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Date</label>
                                <div class="controls cal_width">
                                    <stripes:text class = "picker_inline input" id="booking_date" name="booking_date" value="" />
                                </div>
                            </div>
                            <div class="float_time">
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Start Time</label>
                                    <div class="controls time ">
                                        <stripes:text class = "picker_inline input" id="booking_date" name="booking_date" value="" />
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">End Time</label>
                                    <div class="controls time">
                                        <stripes:text class = "picker_inline input" id="booking_date" name="booking_date" value="" />
                                    </div>
                                </div> 
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Event Details</label>
                                <div class="controls">
                                    <stripes:textarea id="event_description" name="postContent" />
                                </div>
                            </div>
                        </div>

                            <stripes:hidden name="posterId" id="posterID" value='${sessionScope.user.userId}'/> 
                            <stripes:submit id="submitPost" class="float_r btn btn-peace-1" name="addPost" value="Post to Wall"/> 
                        </stripes:form>
                    
                </div>
            </div>


            <script>
                $("#searchterm").keyup(function(e){
                    var q = $("#searchterm").val().toLowerCase();
                                      
                    var tempArr = [];
                    for(var i=0;i<userList.length;i++){
                        console.log(name);
                        var fName = userList[i].firstName.toLowerCase();
                        var lName = userList[i].lastName.toLowerCase()
                        var userEmail = userList[i].email;
                        var fullname = fName + " " + lName;
                        if(!q==''){
                            
                                
                            if(fName.indexOf(q) !== -1){
                                tempArr.push(userList[i]);
                            } else if (lName.indexOf(q)!== -1){
                                tempArr.push(userList[i]);
                            } else if (userEmail.indexOf(q)!== -1){
                                tempArr.push(userList[i]);
                            } else if (fullname.indexOf(q)!== -1){
                                tempArr.push(userList[i]);
                            }
                                
                                
                        }
                            
                    }
                    
                    showUsers(tempArr);
  
                });
            </script>

            <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">


                <div id="post-${post.postId}" class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic" />
                            <div class="name">${post.user.userName}</div>
                            <div class="timestamp">${post.timeSincePost}</div>
                        </div>
                        <div class="postIcon wallicon DATE"> 
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post span6">
                    <div class="baseContent">
                        <div class="title"><b>${post.user.userName}</b> created an event</div>
                        <div class="content">"${post.message}"</div>
                        <div class="attachment event hide">
                            <div class="eventTitle"><a href="#">Tennis Game Tonight, 7pm!</a></div>
                            <div class="eventMeta">
                                <b>Venue:</b> Beacon Heights Tennis Court 2 <br/>
                                <b>Date/Time:</b> 28 Sept '12 @ 7pm - 10pm
                            </div>
                        </div>
                        <div class="linkBar hide">
                            <a class="btn"><i class="icon-check"></i> I'm going!</a>
                            <a class="btn"><i class="icon-heart"></i> Like</a>
                            <a class="btn"><i class="icon-eye-open"></i> View Event</a>
                            <a href="#" class="float_r flagPost"><i class="icon-flag"></i> Flag as inappropriate</a>
                        </div>
                    </div>
                    <div class="commentArea">
                        <div class="comments">
                            <c:forEach items="${post.comments}" var="comment" varStatus="loop">
                                <div class="comment">
                                    <img src="/uploads/profile_pics/${comment.user.profilePicFilename}" class="profilePic float_l"/>
                                    <div class="content float_l">
                                        <b>${comment.user.userName}: </b>${comment.text}
                                        <div class="timestamp">${comment.timeSinceComment}</div>
                                    </div>
                                    <br class="clearfix"/>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="comment replyArea">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic float_l" />
                            <input class="float_l commentTextArea" data-post-id="${post.postId}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                            <br class="clearfix"/>
                        </div>


                    </div>
                </div>

            </div>
        </c:forEach>

    </div>
</div>
<div id="footer">

    <div class="container">				

        <p><center><a href="mailto:helpdesk@beaconheights.com.sg">
                Facing Technical Issues? Contact the LivingNet help desk</a></center></p>
    </div> <!-- /container -->

</div> <!-- /footer -->
<script>
    $(document).ready(function() { 
                
        $("#makePostForm").validate({
            rules: {
                postTitle: "required",
                postContent: "required"                        
            },
            messages :{
                postTitle: "",
                postContent: ""
            },
                        
            submitHandler: function(form) {
                formAjaxSubmit();     
                //slotDataHasError
            }
                        
        });
    });
            
       
</script>                

<script src="../js/jquery.validate.js"></script>
<script src="../js/jquery.validate.bootstrap.js"></script>                
</body>
</html>
