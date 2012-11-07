<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageFacilitiesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilitiesActionBean"/>
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

        <!-- Populates the Edit Facilities form -->
        <script>
            // Init an array of all facilities shown on this page
            var facilityList = [];
            
            //when this function is called, facilityList should already be populated
            function populateEditFacilityModal(facilityID){ 
                facilityList.forEach(function(facility){
                    if(facility.id == facilityID){
                        $("#facilityLabel").text(facility.type + " " + facility.id);
                        $("#editid").val(facility.id);
                        $("#edit_type").val(facility.type);
                        $("#edit_longitude").val(facility.longitude);
                        $("#edit_latitude").val(facility.latitude);

                    }
                });
                
            }
        </script>


        <script>
            function loadValidate(){
                $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                $('select').chosen();

                $("#new_facility_validate").validate({
                    rules:{
                        type:{
                            required:true
                        },
                        longitude:{
                            required:true,
                            digits:true
                        },
                        latitude:{
                            required:true,
                            digits: true
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
        
        <script>
            //This chunk manages onclick styles
           // $("users-nav-icon").toggle(function(){
           //     $("body").css("background-color","green")
           // });
            
        </script>

    </head>
    <body>


        <div id="header">
            <h1><a href="./dashboard.html">Beacon Heights Admin</a></h1>		
        </div>

                <!--<div id="search">
            <input type="text" placeholder="Search here..."/><button type="submit" class="tip-right" title="Search"><i class="icon-search icon-white"></i></button>
        </div> -->
        
        <div id="user-nav" class="navbar navbar-inverse">
            <ul class="nav btn-group">
                <li class="btn btn-inverse" ><a title="" href="#"><i class="icon icon-user"></i> <span class="text">Profile</span></a></li>
                <!--<li class="btn btn-inverse dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">Messages</span> <span class="label label-important">5</span> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a class="sAdd" title="" href="#">new message</a></li>
                        <li><a class="sInbox" title="" href="#">inbox</a></li>
                        <li><a class="sOutbox" title="" href="#">outbox</a></li>
                        <li><a class="sTrash" title="" href="#">trash</a></li>
                    </ul>
                </li> -->
                <li class="btn btn-inverse"><a title="" href="#"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>
                <li class="btn btn-inverse"><a title="" href="login.html"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
            </ul>
        </div>

        <div id="sidebar">
            <a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
            <ul>
                <li class="submit"><a href="#"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>
                <li class="submenu">
                    <a href="manageusers.jsp"><i class="icon icon-th-list"></i> <span>Users</span>  <span class="right-icon"><i id="users-nav-icon" class="icon icon-chevron-down"></span></i></a>
                    <ul>
                        <li><a href="manageusers.jsp">Manage Users</a></li>
                        <li><a href="approveaccounts.jsp">Approve Pending Accounts</a></li>
                        <!--<li><a href="form-wizard.html">Wizard</a></li> -->
                    </ul>
                </li>
                <li class="submenu active open">
                    <a href="managefacilities.jsp"><i class="icon icon-th-list"></i> <span>Facilities</span> <span class="right-icon"><i id="users-nav-icon" class="icon icon-chevron-down"></span></i></a>
                    <ul>
                        <li class ="active"><a href="managefacilities.jsp">Manage Facilities</a></li>
                    </ul>
                </li>
            </ul>
        </div>



        <div id="content">
            <div id="content-header">
                <h1> Approve Pending Accounts </h1>
                <div class="btn-group">
                    <a href="approveaccounts.jsp" class="btn btn-large tip-bottom" title="Pending Accounts"><i class="icon-user"></i>
                    <c:if test = "${approveUserBean.tempUserListCount > 0}">
                            <span class="label label-important">${approveUserBean.tempUserListCount}</span>
                    </c:if>
                    </a>
                    <a class="btn btn-large tip-bottom" title="Flagged Comments"><i class="icon-comment"></i><span class="label label-important">5</span></a>
                    <a class="btn btn-large tip-bottom" title="Flagged Events"><i class="icon-calendar"></i></a>
                    <a class="btn btn-large tip-bottom" title="Forms Pending Approval"><i class="icon-file"></i></a>
                    <a class="btn btn-large tip-bottom" title="Feedback & Enquries"><i class="icon-bell"></i></a>
                </div>
            </div>
            <div id="breadcrumb">
                <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
                <a href="#" class="current">Facilities</a>
            </div>
            <div class="container-fluid">


                <!-- Messages -->
                <div class="row-fluid">
                    <div class="span12">
                        <c:if test = "${param.createsuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> There was an error creating a facility. Please try again!
                            </div>
                        </c:if> 
                        <c:if test = "${param.createsuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.createmsg} was added to the facilities list!
                            </div>
                        </c:if>
                        <c:if test = "${param.editsuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Fantastic!</b> ${param.editmsg} was updated successfully!
                            </div>
                        </c:if>
                        <c:if test = "${param.editsuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> ${param.editmsg} was unable to be updated. Please try again!
                            </div>
                        </c:if>
                        <c:if test = "${param.deletesuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error container">
                                <b>Whoops.</b> The facility could not be deleted.
                            </div>
                        </c:if> 
                        <c:if test = "${param.deletesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success container">
                                <b>Awesome!</b> ${param.deletemsg} was successfully deleted!
                            </div>
                        </c:if>
                    </div>

                    <!-- Add New Facility -->   
                    <div class="widget-box">
                        <div title="Click to add a new facility" onclick="loadValidate()" data-target="#collapseTwo" data-toggle="collapse" class="widget-title clickable tip-top" id="newFacilityForm">
                            <span class="icon">
                                <i class="icon-plus"></i>									
                            </span>
                            <h5>Add New Facility</h5>
                        </div>
                        <div class="addUser collapse" id="collapseTwo">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageFacilitiesActionBean" name="new_facility_validate" id="new_facility_validate">
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Type</label>
                                    <div class="controls">
                                        <stripes:select name="type">
                                            <stripes:options-collection collection="${manageFacilitiesActionBean.facilityTypeList}" label="name" value="name"/>        
                                        </stripes:select>
                                    </div>
                                </div>

                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Latitude</label>
                                    <div class="controls">
                                        <stripes:text name="latitude"/>
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Longitude</label>
                                    <div class="controls">
                                        <stripes:text name="longitude"/>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <input type="submit" name="createFacility" value="Add this facility" class="btn btn-info btn-large"/>
                                </div>                            
                            </stripes:form>

                        </div>
                    </div>		



                    <!-- Facilities Display -->
                    <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon"><i class="icon-user"></i></span><h5>Facilities</h5></div>
                        <div class="widget-content">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="widget-content nopadding">
                                        <ul class="recent-comments"> 
                                            <table class="table table-striped users">
                                                <tr>
                                                    <th></th>
                                                    <th>ID</th>
                                                    <th>Facility Type</th>
                                                    <th>Latitude</th>
                                                    <th>Longitude</th>
                                                    <th>Action</th>
                                                </tr>

                                                <c:forEach items="${manageFacilitiesActionBean.facilityList}" var="facility" varStatus="loop">
                                                    <script>
                                                        var facility = new Object();
                                                        facility.id = '${facility.id}';
                                                        facility.type = '${facility.facilityType.name}';
                                                        facility.latitude = '${facility.facilityLat}';
                                                        facility.longitude = '${facility.facilityLng}';
                                                        
                                                        facilityList.push(facility);
                                                    </script>
                                                    <tr>
                                                        <td>
                                                            <div class="user-thumb">
                                                                <img width="40" height="40" alt="" src="../img/demo/av1.jpg">
                                                            </div>
                                                        </td>
                                                        <td><b>${facility.id}</b></td>
                                                        <td><b>${facility.facilityType.name}</b></td>
                                                        <td>${facility.facilityLat}</td>
                                                        <td>${facility.facilityLng}</td>
                                                        <td>
                                                            <a href="#editFacilityModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditFacilityModal('${facility.id}')">Edit</a> 
                                                            <a href="#deleteFacilityModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFacilityModal('${facility.id}')">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>    
                                             <!--<li class="viewall">
                                                <a class="tip-top" href="#" data-original-title="View all comments"> + View all + </a>
                                            </li>-->
                                        </ul>
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


                <!-- Edit Facility Modal Form -->
                <div id="editFacilityModal" class="modal hide fade">
                    <div id="myModal" class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Edit <span id="facilityLabel"></span></h3>
                    </div>
                    <div class="modal-body">
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditFacilitiesBean" focus="" name="registration_validate">
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Type</label>
                                <div class="controls">
                                    <stripes:select id="edit_type" name="type">
                                        <stripes:options-collection collection="${manageFacilitiesActionBean.facilityTypeList}" label="name"/>        
                                    </stripes:select>
                                </div>
                            </div> 
                            <stripes:text class="hide" name="id" id="editid" />
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Latitude</label>
                                <div class="controls">
                                    <stripes:text id="edit_latitude" name="latitude"/> 
                                </div>
                            </div>    
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Longitude</label>
                                <div class="controls">
                                    <stripes:text id="edit_longitude" name="longitude"/> 
                                </div>
                            </div>                              

                        </div>
                        <div class="modal-footer">
                            <a data-dismiss="modal" class="btn">Close</a>
                            <input type="submit" name="editFacility" value="Confirm Edit" class="btn btn-primary"/>
                        </div>
                    </stripes:form>
                </div>

                <!--<script src="js/excanvas.min.js"></script>-->
                <script src="../js/jquery.min.js"></script>
                <script src="../js/jquery.ui.custom.js"></script>
                <script src="../js/bootstrap.min.js"></script>

                <script src="../js/jquery.flot.min.js"></script>
                <script src="../js/jquery.flot.resize.min.js"></script>
                <script src="../js/jquery.peity.min.js"></script>

                <script src="../js/jquery.uniform.js"></script>
                <script src="../js/jquery.chosen.js"></script>
                <script src="../js/jquery.validate.js"></script>

                <script src="../js/lin.manageusers.js"></script>
                <script src="../js/fullcalendar.min.js"></script>
                <script src="../js/unicorn.js"></script>
                <script src="../js/unicorn.dashboard.js"></script>
                <script src="../js/unicorn.form_common.js"></script>
                </body>

                </html>
