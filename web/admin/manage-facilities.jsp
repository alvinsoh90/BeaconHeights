<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageFacilitiesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilitiesActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Facilities</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit Facilities form -->
        <script>
            // Init an array of all facilities shown on this page
            var facilityList = [];
            
            //when this function is called, facilityList should already be populated
            function populateEditFacilityModal(facilityID){ 
                facilityList.forEach(function(facility){
                    if(facility.id == facilityID){
                        $("#facilityLabel").text(facility.type + " " + facility.name);
                        $("#editid").val(facility.id);
                        $("#edit_type").val(facility.type);
                        $("#edit_longitude").val(facility.longitude);
                        $("#edit_latitude").val(facility.latitude);
                        $("#edit_facility_name").val(facility.name);

                    }
                });
                
            }
            
            //when this function is called, facilityList should already be populated
            function populateDeleteFacilityModal(facilityID){ 
                facilityList.forEach(function(facility){
                    if(facility.id == facilityID){
                        $("#facilityDeleteLabel").text(facility.type + " " + facility.id);
                        $("#delete_name").text(facility.type + " " + facility.id);
                        $("#delete_id").val(facility.id);

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
                
                $("#edit_facility_validate").validate({
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
    </head>
    <body>

        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>   

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>

                    <div class="page-header">
                        <h1>Facilities <small>Manage existing estate facilities</small></h1>
                    </div>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Facility Type</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageFacilitiesActionBean.facilityList}" var="facility" varStatus="loop">
                            <script>
                                var facility = new Object();
                                facility.id = '${facility.id}';
                                facility.type = '${facility.facilityType.name}';
                                facility.latitude = '${facility.facilityLat}';
                                facility.longitude = '${facility.facilityLng}';
                                facility.name = '${facility.name}';
                                                        
                                facilityList.push(facility);
                            </script>
                            <tr>
                                <td>
                                    <div class="user-thumb">
                                        <c:choose>
                                            <c:when test="${facility.facilityType.name=='BBQ Pit'}">
                                                <img width="40" height="40" alt="" src="../img/lin/bbq.png"/>  
                                            </c:when>
                                            <c:when test="${facility.facilityType.name=='Tennis Court'}">
                                                <img width="40" height="40" alt="" src="../img/lin/tennis.png"/>  
                                            </c:when>
                                            <c:otherwise>
                                                <!-- put placeholder image if no facility -->
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td><b>${facility.id}</b></td>
                                <td><b>${facility.name}</b></td>
                                <td><b>${facility.facilityType.name}</b></td>
                                <td>
                                    <a href="#editFacilityModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditFacilityModal('${facility.id}');loadValidate()">Edit</a> 
                                    <a href="#deleteFacilityModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFacilityModal('${facility.id}')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
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
                    <a href="#createFacilityModal" role='button' data-toggle='modal' class="btn btn-success">Create New Facility</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Create Facility Modal Form -->
        <div id="createFacilityModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Edit <span id="usernameLabel"></span>'s information</h3>
            </div>
            <div class="modal-body">
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
                        <label class="control-label">Name</label>
                        <div class="controls">
                            <stripes:text name="facility_name" />
                        </div>
                    </div>
<!--                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Latitude</label>
                        <div class="controls">
                    <stripes:text name="latitude" />
                </div>
            </div>
            <div class="control-group ${errorStyle}">
                <label class="control-label">Longitude</label>
                <div class="controls">
                    <stripes:text name="longitude"  />
                </div>
            </div>-->

                    <div class="modal-footer">
                        <input type="submit" name="createFacility" value="Add this facility" class="btn btn-info btn-large"/>                                                           
                    </stripes:form>
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
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditFacilitiesBean" id="edit_facility_validate" name="edit_facility_validate">
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Type</label>
                        <div class="controls">
                            <stripes:select id="edit_type" name="type">
                                <stripes:options-collection collection="${manageFacilitiesActionBean.facilityTypeList}" value="name" label="name"/>        
                            </stripes:select>
                        </div>
                    </div> 
                        <div class="control-group ${errorStyle}">
                        <label class="control-label">Name</label>
                        <div class="controls">
                            <stripes:text id="edit_facility_name" name="facility_name" />
                        </div>
                    </div>
                    <stripes:text class="hide" name="id" id="editid" />
<!--                    <div class="control-group ${errorStyle}">
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
            </div>                              -->
                    <stripes:hidden id="editid" name="id"/>
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <input type="submit" name="editFacility" value="Confirm Edit" class="btn btn-primary"/>
                </div>
            </stripes:form>
        </div>


        <!--Delete Facility Modal -->
        <div id="deleteFacilityModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Deletion of <span id="facilityDeleteLabel"></span></h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteFacilitiesBean" > 
                    You are now deleting <span id="delete_name"></span>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>

                    <stripes:hidden id="delete_id" name="id"/>
                    <input type="submit" name="deleteFacility" value="Confirm Delete" class="btn btn-danger"/>
                </div>
            </stripes:form>
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

        <script src="../js/jquery.validate.js"></script>

    </body>
</html>
