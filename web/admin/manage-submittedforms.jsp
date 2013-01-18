<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageSubmittedFormsActionBean" scope="page"
             class="com.lin.general.admin.ManageSubmittedFormsActionBean"/>
<jsp:useBean id="editSubmittedFormsBean" scope="page"
             class="com.lin.general.admin.EditSubmittedFormsBean"/>
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Submitted Forms</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
        <script>
            // Init an array of all rc shown on this page
            var sfList = [];
           
            //when this function is called, sfList should already be populated
            function populateEditSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfEditLabel").text(submittedForm.fileName);
                        $("#editid").val(submittedForm.id);
                        $("#edit_user").val(submittedForm.user);
                        $("#edit_fileName").val(submittedForm.fileName);
                        $("#edit_processed").val("true");
                    }
                    
                });
                
            }
            
            //when this function is called, sfList should already be populated
            function populateDeleteSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfDeleteLabel").text(submittedForm.fileName);
                        $("#delete_name").text(submittedForm.fileName);
                        $("#delete_id").val(submittedForm.id);

                    }
                });
                
            }
        </script>


        <script>
            function loadValidate(){
                $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                $('select').chosen();

                $("#new_submittedform_validate").validate({
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
                
                $("#edit_submittedform_validate").validate({
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
                        <h1>Resources <small>Manage Submitted Forms</small></h1>
                    </div>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Time Submitted</th>
                                <th>File Name</th>
                                <th>Processed</th>
                                <th>Comments</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageSubmittedFormsActionBean.sfList}" var="submittedForm" varStatus="loop">
                            <script>
                                var submittedForm = new Object();
                                submittedForm.id = '${submittedForm.id}';
                                submittedForm.user = '${submittedForm.user.userName}';
                                submittedForm.timeSubmitted = '${submittedForm.timeSubmitted}';
                                submittedForm.fileName = '${submittedForm.fileName}';
                                submittedForm.processed = '${submittedForm.processed}';
                                submittedForm.comments = '${submittedForm.comments}';
                                sfList.push(submittedForm);
                            </script>
                            <tr>
                  
                                <td><b>${submittedForm.id}</b></td>
                                <td><b>${submittedForm.user.userName}</b></td>
                                <td><b>${submittedForm.timeSubmitted}</b></td>
                                <td><b>${submittedForm.fileName}</b></td>
                                <td><b>${submittedForm.processed}</b></td>
                                <td><b>${submittedForm.comments}</b></td>
                                <td>
                                    <a href="#editSubmittedFormModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditSubmittedFormModal('${submittedForm.id}')">Processed</a> 
                                    <a href="#deleteSubmittedFormModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteSubmittedFormModal('${submittedForm.id}')">Delete</a>
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
                            <!--<li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>-->
                            <li><a href="#">Next</a></li>
                        </ul>
                    </div>
                    <!--<a href="#createResourceModal" role='button' data-toggle='modal' class="btn btn-success">Create New Resource</a>-->
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

        <!-- Edit Submitted Form Modal Form -->
        <div id="editSubmittedFormModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Process Submitted Form</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditSubmittedFormsActionBean" name="new_submittedform_validate" id="new_submittedform_validate">                 
                    Have you processed this form?
                    <stripes:hidden id="editid" name="id"/>
                    <stripes:hidden id="edit_user" name="user"/>
                    <stripes:hidden id="edit_fileName" name="fileName"/>
                    <stripes:hidden id="edit_processed" name="processed"/>
                    <div class="modal-footer">
                        <a data-dismiss="modal" class="btn">No</a>
                        <input type="submit" name="editSubmittedForm" value="Yes" class="btn btn-info btn-large"/>                                                           
                    </stripes:form>
                </div>
            </div>      
        </div>


        <!--Delete Submitted Form Modal -->
        <div id="deleteSubmittedFormModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Deletion of <span id="sfDeleteLabel"></span></h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteSubmittedFormBean" > 
                    You are now deleting <span id="delete_fileName"></span>. Are you sure?
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>

                    <stripes:hidden id="delete_id" name="id"/>
                    <input type="submit" name="deleteSubmittedForm" value="Confirm Delete" class="btn btn-danger"/>
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
