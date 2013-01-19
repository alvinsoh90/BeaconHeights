<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Submit Online Forms | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageResourceActionBean" scope="page"
                     class="com.lin.general.admin.ManageResourceActionBean"/>
        <jsp:useBean id="editResourceBean" scope="page"
                     class="com.lin.general.admin.EditResourceBean"/>
        <jsp:useBean id="deleteResourceBean" scope="page"
                     class="com.lin.general.admin.DeleteResourceBean"/>
        <jsp:useBean id="manageBookingsActionBean" scope="page"
                     class="com.lin.general.admin.ManageBookingsActionBean"/>
        <jsp:setProperty name = "manageBookingsActionBean"  property = "currentUser"  value = "${user}" />
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
        
        
        <!-- Scripts -->

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script>
            // Init an array of all rc shown on this page
            var resourceList = [];
            
            //when this function is called, resourceList should already be populated
            function populateEditResourceModal(resourceID){ 
                resourceList.forEach(function(resource){
                    if(resource.id == resourceID){
                        $("#resourceLabel").text(resource.name);
                        $("#editid").val(resource.id);
                        $("#edit_name").val(resource.name);
                        $("#edit_description").val(resource.description);
                        $("#edit_category").val(resource.category);
                    }
                    
                });
                
            }
            
            //when this function is called, resourceList should already be populated
            function populateDeleteResourceModal(resourceID){ 
                resourceList.forEach(function(resource){
                    if(resource.id == resourceID){
                        $("#resourceDeleteLabel").text(resource.name);
                        $("#delete_name").text(resource.name);
                        $("#delete_id").val(resource.id);

                    }
                });
                
            }
        </script>


        <script>
            function loadValidate(){
                $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                $('select').chosen();

                $("#new_resource_validate").validate({
                    rules:{
                        name:{
                            required:true
                        },
                        description:{
                            required:true
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
                
                $("#edit_resource_validate").validate({
                    rules:{
                        name:{
                            required:true
                        },
                        description:{
                            required:true
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

        <!--populate user current bookings -->
        <c:forEach items="${manageBookingsActionBean.userCurrentBookingList}" var="booking" varStatus="loop">
            <script>
                var booking = new Object();
                booking.id = '${booking.id}';
                booking.facilityType = '${booking.facility.facilityType.name}';
                booking.startDate = '${booking.startDate}';
                bookingList.push(booking);
            </script>
        </c:forEach>
    </head>

    <body>

        <div id="content">

            <div class="container">

                <div class="row">
                    <div class="span3">

                        <div class="account-container">
                            <h2>View Online Forms</h2>
                            <select id ="view">
                                <option value="Current Bookings">List of Forms</option>
                                <option value="Booking History">My Submitted Forms</option>
                            </select>

                        </div> <!-- /account-container -->
                    </div>
                    <div class="span9">

                        <h1 class="page-title">

                            Submit Online Forms				
                        </h1>
                        <br/>

                        <div class="widget widget-table">

                            <div class="widget-header">
                                <i class="icon-th-list"></i>
                                <h3> List of Forms </h3>


                            </div> <!-- /widget-header -->

                            <table class="table table-striped table-bordered table-condensed">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Category</th>
                                        <th>Filename</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${manageResourceActionBean.resourceList}" var="resource" varStatus="loop">
                                    <script>
                                           
                                        var resource = new Object();
                                        resource.id = '${resource.id}';
                                        resource.name = '${resource.name}';
                                        resource.description = '${resource.description}';
                                        resource.category = '${resource.category}';
                                        resource.fileName = '${resource.fileName}';
                                        resource.timeCreated = '${resource.timeCreated}';
                                        resourceList.push(resource);
                                            
                                     
                                    </script>
                                    <tr>

                                        <td><b>${resource.id}</b></td>
                                        <td><b>${resource.name}</b></td>
                                        <td><b>${resource.description}</b></td>
                                        <td><b>${resource.category}</b></td>
                                        <td><b><a href="/pdf_uploads/${resource.fileName}">${resource.fileName}</a></b></td>

                                        <td>
                                            <a href="#editResourceModal" role="button" data-toggle="modal" class="btn btn-success btn-mini" onclick="populateEditResourceModal('${resource.id}')">Submit</a> 

                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>



                        </div>
                    </div>
                </div>


            </div> <!-- /row -->

        </div> <!-- /container -->

    </div> <!-- /content -->

    <!-- Create Resource Modal Form -->
    <div id="createResourceModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Upload Form Template</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageOnlineFormsActionBean" name="new_resource_validate" id="new_resource_validate">                 
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name:</label>
                    <div class="controls">
                        <stripes:text name="name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description:</label>
                    <div class="controls">
                        <stripes:text name="description" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Category:</label>
                    <div class="controls">

                        Select <stripes:select name="category" id="edit_category">
                            <stripes:options-collection collection="${manageResourceActionBean.uniqueCategories}" />        
                        </stripes:select>
                        <br>Or Create New <stripes:text name="category_new" />

                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">File:</label>
                    <div class="controls">
                        <stripes:file name="file"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="createResource" value="Add this Form" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>

    <!-- Edit Resource Modal Form -->
    <div id="editResourceModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Submit A Form</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageResourceActionBean" name="new_resource_validate" id="new_resource_validate">                 
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name:</label>
                    <div class="controls">
                        <stripes:text name="name" id="edit_name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description:</label>
                    <div class="controls">
                        <stripes:text name="description" id="edit_description" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Category:</label>
                    <div class="controls">
                        Select <stripes:select name="category" id="edit_category">
                            <stripes:options-collection collection="${manageResourceActionBean.uniqueCategories}" />        
                        </stripes:select>
                        
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">File:</label>
                    <div class="controls">
                        <stripes:file name="file"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="createResource" value="Submit" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>




    <div id="footer">

        <div class="container">				
            <hr>
            <p>Beacon Heights Condominium</p>
        </div> <!-- /container -->

    </div> <!-- /footer -->


    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
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
