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
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Facility Types</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        
        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="js/jquery.js"></script>        
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>
        
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script>
            $(document).ready(function() {
                $('#facilityTypeTable').dataTable( {
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                } );
            });
            <!-- Populates the Edit Facilities form -->
            // Init an array of all facilities shown on this page
            var facilityTypeList = [];
            
            function populateEditFacilityTypeModal(typeID){ 
                facilityTypeList.forEach(function(facilityType){
                    if(facilityType.id == typeID){
                        $("#facilityTypeLabel").text(facilityType.name);
                        $("#editid").val(facilityType.id);
                        $("#edit_name").val(facilityType.name);
                        $("#edit_description").val(facilityType.description);
                    }
                });
                
            }
            
            function populateDeleteFacilityTypeModal(typeID){ 
                facilityTypeList.forEach(function(facilityType){
                    if(facilityType.id == typeID){
                        $("#facilityTypeDeleteLabel").text(facilityType.name);
                        $("#delete_name").text(facilityType.name);
                        $("#delete_id").val(facilityType.id);
 
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

                    <!-- Edit Facility Type Modal Form -->


                    <!--Delete Facility Modal -->
                    <div id="deleteFacilityTypeModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Deletion of <span id="facilityTypeDeleteLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.general.admin.DeleteFacilityTypeBean"> 
                                You are now deleting <span id="delete_name"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="delete_id" name="delete_facility_type_id"/>
                                <stripes:hidden id="delete_name" name="delete_name"/>
                                <input type="submit" name="deleteFacilityType" value="Confirm Delete" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>    

                    <div class="page-header">
                        <h1>Facility Types <small>Manage estate facility types</small></h1>
                    </div>
                    <table id ="facilityTypeTable" class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Facility Type</th>
                                <th>Description</th>
                                <th>Opening Hours</th>
                                <th>Booking Limit</th>
                                <th>Advance Booking Limit</th>
                                <th>Booking Fees/Deposit:</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageFacilityTypesActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                            <script>
                                var facilityType = new Object();
                                facilityType.id = "${facilityType.id}";
                                facilityType.name = "${facilityType.name}";
                                facilityType.description = "${facilityType.description}";
                                facilityType.needsPaymentString = "${facilityType.needsPayment}";
                                                        
                                facilityTypeList.push(facilityType);
                            </script>
                            <tr>

                                <td><b>${loop.index + 1}</b></td>
                                <td><b>${facilityType.name}</b></td>
                                <td>${facilityType.description}</td>
                                <td><c:forEach items="${facilityType.sortedOpenRules}" var="openRule" varStatus="loop">
                                        ${openRule}<br>    
                                    </c:forEach></td>
                                <td><c:forEach items="${facilityType.limitRules}" var="limitRules" varStatus="loop">
                                        ${limitRules}<br>    
                                    </c:forEach></td>
                                <td><c:forEach items="${facilityType.advanceRules}" var="advanceRules" varStatus="loop">
                                        ${advanceRules}<br>    
                                    </c:forEach></td>
                                <td><b>Booking Fees: $${facilityType.bookingFees}<br>Booking Deposit: $${facilityType.bookingDeposit}</b></td>
                                <td nowrap>
                                    <a href="editfacilitytype.jsp?id=${facilityType.id}" role="button" class="btn btn-primary btn-mini">Edit</a> 
                                    <a href="#deleteFacilityTypeModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFacilityTypeModal('${facilityType.id}')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <a href="createfacilitytype.jsp" class="btn btn-success">Create New Facility Type</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Create new facility type modal -->
        <div id="createFacilityTypeModal" class="modal hide fade">
            <div class="modal-header">
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
