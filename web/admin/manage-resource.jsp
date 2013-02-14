<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageResourceActionBean" scope="page"
             class="com.lin.general.admin.ManageResourceActionBean"/>
<jsp:useBean id="editResourceBean" scope="page"
             class="com.lin.general.admin.EditResourceBean"/>
<jsp:useBean id="deleteResourceBean" scope="page"
             class="com.lin.general.admin.DeleteResourceBean"/>
<jsp:useBean id="newsDate" class="java.util.Date" />

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Resources</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="js/jquery.js"></script>        
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />

        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
        <script>
            $(document).ready(function(){
                var success = "${SUCCESS}";
                var failure = "${FAILURE}";
                if(success != ""){
                    toastr.success(success);
                }
                else if(failure){
                    var msg = "<b>There was an error processing your request.</b><br/>";
                    msg += "<ol>"
                <c:forEach var="message" items="${MESSAGES}">
                        msg += "<li>${message}</li>";
                </c:forEach>
                        msg += "</ol>";    
                        toastr.errorSticky(msg);
                    }
            });
            $(document).ready(function() {
                $('#table_id').dataTable( {
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                } );
            });
            // Init an array of all rc shown on this page
            var resourceList = [];
            
            //when this function is called, resourceList should already be populated
            function populateEditResourceModal(resourceID){ 
                resourceList.forEach(function(resource){
                    if(resource.id == resourceID){
                        $("#resourceLabel").text(resource.name);
                        $("#edit_id").val(resource.id);
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
                        <h1>Resources <small>Manage Resources</small></h1>
                    </div>
                    <table id ="table_id" class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Category</th>
                                <th nowrap>Download File</th>
                                <th nowrap>Last Updated</th>
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
                                <td>${loop.index + 1}</td>
                                <td>${resource.name}</td>
                                <td>${resource.description}</td>
                                <td>${resource.category}</td>
                                <td><a href="/uploads/resources/${resource.fileName}">Download File</a></b></td>
                                <jsp:setProperty name="newsDate" property="time" value="${resource.timeCreated.time}" />
                                <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${newsDate}" /></td>
                                <td nowrap>
                                    <a href="#editResourceModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditResourceModal('${resource.id}')">Edit</a> 
                                    <a href="#deleteResourceModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteResourceModal('${resource.id}')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
          
                    <a href="#createResourceModal" role='button' data-toggle='modal' class="btn btn-success">Create New Resource</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Create Resource Modal Form -->
        <div id="createResourceModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Create a Resource</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageResourceActionBean" name="new_resource_validate" id="new_resource_validate">                 
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
                            Select <stripes:select name="category" >
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
                        <input type="submit" name="createResource" value="Add this Resource" class="btn btn-info btn-large"/>                                                           
                    </stripes:form>
                </div>
            </div>      
        </div>

        <!-- Edit Resource Modal Form -->
        <div id="editResourceModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Edit a Resource</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditResourceBean" name="edit" id="new_resource_validate">                 
                    <stripes:hidden id="edit_id" name="id" />
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
                        <input type="submit" name="createResource" value="Edit this Resource" class="btn btn-info btn-large"/>                                                           
                    </stripes:form>
                </div>
            </div>      
        </div>


        <!--Delete Resource Modal -->
        <div id="deleteResourceModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Deletion of <span id="resourceDeleteLabel"></span></h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteResourceBean" > 
                    You are now deleting <span id="delete_name"></span>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>

                    <stripes:hidden id="delete_id" name="id"/>
                    <input type="submit" name="deleteResource" value="Confirm Delete" class="btn btn-danger"/>
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
