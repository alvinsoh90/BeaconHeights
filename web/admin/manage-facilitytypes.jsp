<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageFacilityTypesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilityTypesActionBean"/>
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
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Populates the Edit Facilities form -->

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
				<h1>Facility Types <small>Manage estate facility types</small></h1>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
                                                <th></th>
						<th>ID</th>
						<th>Facility Type</th>
						<th>Description</th>
						<th>Opening Hours</th>
						<th>Booking Limit</th>
                                                <th>Advance Booking Limit</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${manageFacilityTypesActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                                                    <script>
                                                        var facilityType = new Object();
                                                        facilityType.id = '${facilityType.id}';
                                                        facilityType.type = '${facilityType.name}';
                                                        facilityType.latitude = '${facilityType.description}';
                                                        
                                                        facilityList.push(facilityType);
                                                    </script>
                                                    <tr>
                                                        <td>
                                                            <div class="user-thumb">
                                                                <img width="40" height="40" alt="" src="../img/demo/av1.jpg">
                                                            </div>
                                                        </td>
                                                        <td><b>${facilityType.id}</b></td>
                                                        <td><b>${facilityType.name}</b></td>
                                                        <td>${facilityType.description}</td>
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
			<a href="#createFacilityTypeModal" role='button' data-toggle='modal' class="btn btn-success">Create New Facility Type</a>
		  </div>
        </div>
      </div>

      <hr>

<%@include file="include/footer.jsp"%>

<!-- Create new facility type modal -->
                <div id="createFacilityTypeModal" class="modal hide fade">
                    <div id="myModal" class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Create New Facility Type</h3>
                    </div>
                    <div class="modal-body">
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageFacilityTypesActionBean" name="new_facility_validate" id="new_facility_validate">
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Name</label>
                                    <div class="controls">
                                        <stripes:text name="name"/>
                                    </div>
                                </div>

                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Description</label>
                                    <div class="controls">
                                        <stripes:text name="description"/>
                                    </div>
                                </div>
                              
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Opening Hours</label>
                                    <div class="controls">

                                        Monday:     Opening <stripes:text name="monOpen"/>   Closing <stripes:text name="monClose"/><br/>
                                        Tuesday:    Opening <stripes:text name="tueOpen"/>   Closing <stripes:text name="tueClose"/><br/>
                                        Wednesday:  Opening <stripes:text name="wedOpen"/>    Closing <stripes:text name="wedClose"/><br/>
                                        Thursday:   Opening <stripes:text name="thuOpen"/>   Closing <stripes:text name="thuClose"/><br/>
                                        Friday:     Opening <stripes:text name="friOpen"/>    Closing <stripes:text name="friClose"/><br/>
                                        Saturday:   Opening <stripes:text name="satOpen"/>    Closing <stripes:text name="satClose"/><br/>
                                        Sunday:     Opening <stripes:text name="sunOpen"/>    Closing <stripes:text name="sunClose"/><br/>
                                        

                                    </div>
                                </div>
                                        
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Limits</label>
                                    <div class="controls">
                                        This Facility Type may be booked a maximum of <stripes:text name="sessions"/> times per <stripes:text name="numberOfTimeframe"/> <stripes:text name="timeframeType"/>
                                    </div>
                                </div>
                                    
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Limitation on Booking in Advance</label>
                                    <div class="controls">
                                        This Facility Type's booking opens: <stripes:text name="maxDays"/> in advance <br/>
                                        This Facility Type's booking closes: <stripes:text name="minDays"/> in advance
                                    </div>
                                </div>
                                
                                    

                                <div class="form-actions">
                                    <input type="submit" name="createFacilityType" value="Add this facility type" class="btn btn-info btn-large"/>
                                </div>         

                            </stripes:form>
                </div>


        <!-- Edit Facility Modal Form -->
                <div id="editFacilityModal" class="modal hide fade">
                    <div id="myModal" class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                        <h3>Edit <span id="facilityLabel"></span></h3>
                    </div>
                    <div class="modal-body">
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditFacilitiesBean" focus="" id="edit_facility_validate" name="edit_facility_validate">
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Type</label>
                                <div class="controls">
                                    <stripes:select id="edit_type" name="type">
                                        <stripes:options-collection collection="${manageFacilitiesActionBean.facilityTypeList}" value="name" label="name"/>        
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
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteFacilitiesBean" focus=""> 
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