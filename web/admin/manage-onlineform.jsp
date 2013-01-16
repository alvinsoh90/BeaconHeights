<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>

<%@include file="/protectadmin.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>Admin | Online Forms </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
                <link href="css/linadmin.css" rel="stylesheet">

        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/custom/lin.css" />


        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="/js/jquery.validate.js"></script>
        <script src="/js/custom/lin.register.js"></script>

        <!-- Add white space above -->
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

    </head>

    <body>
        <%@include file="include/mainnavigationbar.jsp"%>

        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <div class="page-header">
                        <h1> Online Forms <small>Manage forms</small></h1>
                    </div>

                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">View All Forms</a></li>
                            <li><a href="#pane2" data-toggle="tab">Add a Form</a></li>
                                
                        </ul>
                        <div class="tab-content">
                            <div id="pane1" class="tab-pane active">
                                <h4>List of Forms</h4>
                                
                                
                                <table class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Title</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>     
                                        <tr>
                                
                                            <td><b>1.</b></td>
                                            <td><b>APPLICATION FOR BOOKING OF BARBECUE PIT</b></td>
                                            <td><b>Word Doc</b></td>
                                            <td>
                                                <a href='#viewFormModal' role='button' data-toggle='modal' class='btn btn-success btn-mini' onclick='populateViewFormModal(" + bookingArr[i].id + ")'>View</a>
                                                <a href="#editFormModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditFormModal('${facility.id}');loadValidate()">Edit</a> 
                                                <a href="#deleteFormModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFormModal('${facility.id}')">Delete</a>
                                            </td>
                                        </tr>
                                        
                                        
<!--                                        <c:forEach items="${manageFacilitiesActionBean.facilityList}" var="facility" varStatus="loop">
                                        <script>
                                            var facility = new Object();
                                            facility.id = '${facility.id}';
                                            facility.type = '${facility.facilityType.name}';
                                            console.log(facility.type);
                                            facility.latitude = '${facility.facilityLat}';
                                            facility.longitude = '${facility.facilityLng}';
                                            facility.name = '${facility.name}';
                                            facilityList.push(facility);
                                        </script>
                                            <tr>
                                
                                            <td><b>${facility.id}</b></td>
                                            <td><b>${facility.name}</b></td>
                                            <td><b>${facility.facilityType.name}</b></td>
                                            <td>
                                                <a href="#editFacilityModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditFacilityModal('${facility.id}');loadValidate()">Edit</a> 
                                                <a href="#deleteFacilityModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFacilityModal('${facility.id}')">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    -->
                                    </tbody>
                                </table>
                                
                                
                            </div>
                            <div id="pane2" class="tab-pane">
                                <h4> Function to add forms </h4>
                                
                            </div>
                          
                            
                        </div><!-- /.tab-content -->
                    </div><!-- /.tabbable -->  
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>


    </body>

</html>
