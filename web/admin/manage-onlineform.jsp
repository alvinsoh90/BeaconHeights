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
<jsp:useBean id="manageFormTemplateActionBean" scope="page"
             class="com.lin.general.admin.ManageFormTemplateActionBean"/>
<jsp:useBean id="editFormTemplateBean" scope="page"
             class="com.lin.general.admin.EditFormTemplateBean"/>
<jsp:useBean id="deleteFormTemplateBean" scope="page"
             class="com.lin.general.admin.DeleteFormTemplateBean"/>
<jsp:useBean id="manageSubmittedFormsActionBean" scope="page"
             class="com.lin.general.admin.ManageSubmittedFormsActionBean"/>
<jsp:useBean id="editSubmittedFormsBean" scope="page"
             class="com.lin.general.admin.EditSubmittedFormsBean"/>
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Online Forms</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">        
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
        <script>   
            
            // Init an array of all rc shown on this page
            var formTemplateList = [];
            var sfList = [];
            
            //show submitted forms table - this needs to populate the submitted forms and not templates.
            function showSubmittedForms(submittedFormsArr){
   
                var r = new Array(), j = -1;
                
                var tableHeaders = "<tr><th>ID</th><th>Submitted By</th><th>Form Title</th><th>Time Submitted</th><th>Download File</th><th>Status</th><th>Comments</th><th>Action</th></tr>"
                
                for (var i=0; i<submittedFormsArr.length; i++){
                    //console.log(booking.username);
                    r[++j] ='<tr><td><b>';
                    r[++j] = submittedFormsArr[i].id;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = submittedFormsArr[i].user;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = submittedFormsArr[i].title;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = submittedFormsArr[i].timeSubmitted;
                    r[++j] = '</b></td><td ><b>';
                    r[++j] = "<a href='/pdf_uploads/"+submittedFormsArr[i].fileName+"'>Download File</a>";
                    r[++j] = '</b></td><td ><b>';
                    
                    if(submittedFormsArr[i].processed=="false"){
                        r[++j] = "Pending"
                    } 
                    else {
                        r[++j] = "Processed"
                    }
                    
                         
                    r[++j] = '</b></td><td ><b>';
                    r[++j] = submittedFormsArr[i].comments;
                    r[++j] = '</b></td><td ><b>';
                    
                    if(submittedFormsArr[i].processed == "false"){
                    
                        r[++j] = "<a href='#editSubmittedFormModal' role='button' data-toggle='modal' class='btn btn-primary btn-mini' onclick='populateEditSubmittedFormModal("+submittedFormsArr[i].id+")'>Processed</a> \n\
                                <a href='#deleteSubmittedFormModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteSubmittedFormModal("+submittedFormsArr[i].id+")'>Delete</a>";
                                   
                    }
                    
                    else {
                        
                        r[++j] = "<a href='#revertSubmittedFormModal' role='button' data-toggle='modal' class='btn btn-info btn-mini' onclick='populateRevertSubmittedFormModal("+submittedFormsArr[i].id+")'>Revert</a> \n\
                                <a href='#deleteSubmittedFormModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteSubmittedFormModal("+submittedFormsArr[i].id+")'>Delete</a>"
                    
                    }
                    
                    
                    r[++j] = '</b></td></tr>';
                }
                $('#submittedFormTable').html(tableHeaders + r.join('')); 
            
            }
            //this function filters by form templates. 
            function filterByTitle(){
                var title = $('#titleSelect').val();
                
                var tempArr = [];
                if(title=="-Select Form Title-"){
                    
                    showSubmittedForms(sfList);
                } else {
                    
                    for(var i=0;i<sfList.length;i++){
                        console.log(title);
                        if(sfList[i].title == title){
                            tempArr.push(sfList[i]);
                        }
                    }
               
                    showSubmittedForms(tempArr);
                    
                }
          
                
            }
            function filterByStatus(){
                var status = $('#statusSelect').val();
                
                var tempArr = [];
                
                if(status == "Processed"){
                
                    for(var i=0;i<sfList.length;i++){
                        console.log(status);
                        if(sfList[i].processed == 'true'){
                            tempArr.push(sfList[i]);
                        }
                    }
                    
                } else if (status == "Pending"){
                    for(var i=0;i<sfList.length;i++){
                        console.log(status);
                        if(sfList[i].processed == 'false'){
                            tempArr.push(sfList[i]);
                        }
                    }
                    
                } else {
                    
                    tempArr = sfList;
                }
                
                if(tempArr.length == 0){
                    //show that nothing found
                    alert("No forms found!");
                }
                else{
                    showSubmittedForms(tempArr);
                }
                
                
            }
            
            //when this function is called, formTemplateList should already be populated
            function populateEditFormTemplateModal(formTemplateID){ 
                formTemplateList.forEach(function(formTemplate){
                    if(formTemplate.id == formTemplateID){
                        $("#formTemplateLabel").text(formTemplate.name);
                        $("#edit_id").val(formTemplate.id);
                        $("#edit_name").val(formTemplate.name);
                        $("#edit_description").val(formTemplate.description);
                        $("#edit_cat").val(formTemplate.category);
                    }
                    
                });
                
            }
            
            //when this function is called, formTemplateList should already be populated
            function populateDeleteFormTemplateModal(formTemplateID){ 
                formTemplateList.forEach(function(formTemplate){
                    if(formTemplate.id == formTemplateID){
                        $("#formTemplateDeleteLabel").text(formTemplate.name);
                        $("#delete_name").text(formTemplate.name);
                        $("#delete_id").val(formTemplate.id);
                    }
                });
                
            }
            
            //when this function is called, sfList should already be populated
            function populateDeleteSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfDeleteLabel").text(submittedForm.id);
                        $("#delete_submitted_name").text(submittedForm.fileName);
                        $("#delete_submitted_id").val(submittedForm.id);

                    }
                });
                
            }
            
            function populateEditSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfEditLabel").text(submittedForm.id);
                        $("#edit_processed").text(submittedForm.processed);
                        $("#edit_submitted_id").val(submittedForm.id);
                        $("#edit_submitted_user").val(submittedForm.user);
                        $("#edit_submitted_fileName").val(submittedForm.fileName);

                    }
                });
                
            }
            function populateRevertSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfRevertLabel").text(submittedForm.id);
                        $("#revert_processed").text(submittedForm.processed);
                        $("#revert_id").val(submittedForm.id);
                        $("#revert_user").val(submittedForm.user);
                        $("#revert_fileName").val(submittedForm.fileName);

                    }
                });
                
            }
            
            function filterReset(){
                showSubmittedForms(sfList);
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


        <%--Load up formTemplates --%>
        <script>
            <c:if test="${manageFormTemplateActionBean.formTemplateList.size()!=0}"> 
                <c:forEach items="${manageFormTemplateActionBean.formTemplateList}" var="formTemplate" varStatus="loop">
        
                    var formTemplate = new Object();
                    formTemplate.id = '${formTemplate.id}';
                    formTemplate.name = '${formTemplate.name}';
                    formTemplate.description = '${formTemplate.description}';
                    formTemplate.category = '${formTemplate.category}';
                    formTemplate.fileName = '${formTemplate.fileName}';
                    formTemplate.timeModified = '${formTemplate.timeModified}';
                    formTemplateList.push(formTemplate);
                </c:forEach>
            </c:if>
        </script>     
        <%--Load up submitted forms --%>

        <c:if test="${manageSubmittedFormsActionBean.sfList.size()!=0}"> 
            <c:forEach items="${manageSubmittedFormsActionBean.userSfList}" var="submittedForm" varStatus="loop">
                <script>
                    var submittedForm = new Object();
                    submittedForm.id = '${submittedForm.id}';
                    submittedForm.user = '${submittedForm.user.userName}';
                    submittedForm.title = '${submittedForm.title}';
                    submittedForm.timeSubmitted = '${submittedForm.timeSubmitted}';
                    submittedForm.fileName = '${submittedForm.fileName}';
                    submittedForm.processed = '${submittedForm.processed}';
                    submittedForm.comments = '${submittedForm.comments}';
                    sfList.push(submittedForm);  
                </script> 
            </c:forEach>

        </c:if>

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

    <body onload="showSubmittedForms(sfList)">
        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>
                    <div class="page-header">
                        <h1> Online Forms <small>Manage forms</small></h1>
                    </div>

                    <!-- Two tabs in Manage Forms -->
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">Manage User Submitted Forms</a></li>
                            <li><a href="#pane2" data-toggle="tab">View Form Templates</a></li>
                            
                        </ul>
                        <div class="tab-content">
                            <!-- Tab 1 -->
                            

                            <div id="pane1" class="tab-pane active">
                                <h4>User Submitted Forms</h4>

                                <!-- Populate base on form template title -->
                                <div class='userFilterBar float_r'>
                                    <h5 class="inlineblock"> Filter By: </h5>
                                    <div class="inlineblock filterOptions">
                                        <select id ="titleSelect" onChange="filterByTitle()">
                                            <option>-Select Form Title-</option>
                                            <c:forEach items="${manageFormTemplateActionBean.formTemplateList}" var="formTemplate" varStatus="loop">
                                                <option>${formTemplate.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="inlineblock filterOptions">
                                        <h5 class="inlineblock">or</h5>
                                        <select id ="statusSelect" onChange="filterByStatus()">
                                            <option>-Select Status-</option>
                                            <option>Pending</option>
                                            <option>Processed</option>

                                        </select>
                                    </div>


                                    <div class="inlineblock filterOptions"><button class="btn" onClick="filterReset()">View All</button></div>                          
                                </div>


                                <table id="submittedFormTable" class="table table-striped table-bordered table-condensed">

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

                            </div> 
                            
                            <!-- Tab 2 -->
                            <div id="pane2" class="tab-pane">
                                <h4>Form Templates</h4>


                                <table class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Category</th>
                                            <th>Download File</th>
                                            <th>Last Updated</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${manageFormTemplateActionBean.formTemplateList}" var="formTemplate" varStatus="loop">
                                        <script>
                                           
                                            var formTemplate = new Object();
                                            formTemplate.id = '${formTemplate.id}';
                                            formTemplate.name = '${formTemplate.name}';
                                            formTemplate.description = '${formTemplate.description}';
                                            formTemplate.category = '${formTemplate.category}';
                                            formTemplate.fileName = '${formTemplate.fileName}';
                                            formTemplate.timeModified = '${formTemplate.timeModified}';
                                            formTemplateList.push(formTemplate);
                                            
                                     
                                        </script>
                                        <tr>

                                            <td><b>${formTemplate.id}</b></td>
                                            <td><b>${formTemplate.name}</b></td>
                                            <td><b>${formTemplate.description}</b></td>
                                            <td><b>${formTemplate.category}</b></td>
                                            <td><b><a href="/pdf_uploads/${formTemplate.fileName}">Download File</a></b></td>
                                            <td><b>${formTemplate.timeModified}</b></td>
                                            <td>
                                                <a href="#editFormTemplateModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditFormTemplateModal('${formTemplate.id}')">Edit</a> 
                                                <a href="#deleteFormTemplateModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteFormTemplateModal('${formTemplate.id}')">Delete</a>
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

                                <a href="#createFormTemplateModal" role='button' data-toggle='modal' class="btn btn-success">Upload New Form</a>

                            </div>
                            <hr>
                        </div>
                    </div><!-- /.tab-content -->
                </div><!-- /.tabbable -->  
            </div>
        </div>
    </div>

    <hr>

    <%@include file="include/footer.jsp"%>

    <!-- Create Form Template Modal -->
    <div id="createFormTemplateModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Upload Form Template</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageFormTemplateActionBean" name="new_resource_validate" id="new_resource_validate">                 
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

                        Select <stripes:select name="category">
                            <stripes:options-collection collection="${manageFormTemplateActionBean.uniqueCategories}" />        
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

    <!-- Edit Form Template Modal  -->
    <div id="editFormTemplateModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Edit an Online Form</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditFormTemplateBean" name="new_resource_validate" id="new_resource_validate">                 
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
                        Select <stripes:select name="category" id="edit_cat" >
                            <stripes:options-collection collection="${manageFormTemplateActionBean.uniqueCategories}" />        
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
                    <input type="submit" name="editFormTemplate" value="Edit this Resource" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>


    <!--Delete Form Template Modal -->
    <div id="deleteFormTemplateModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion of <span id="formTemplateDeleteLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteFormTemplateBean" > 
                You are now deleting <span id="delete_name"></span>. Are you sure?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>

                <stripes:hidden id="delete_id" name="id"/>
                <input type="submit" name="deleteFormTemplate" value="Confirm Delete" class="btn btn-danger"/>
            </div>
        </stripes:form>
    </div>





    <!--Edit Submitted Form Modal -->
    <div id="editSubmittedFormModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Processing submitted form id : <span id="sfEditLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditSubmittedFormsBean" > 
                Are you sure you want to change the status to Processed?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">No</a>

                <stripes:hidden id="edit_submitted_id" name="id"/>
                <stripes:hidden name="processed" value="true"/>
                <stripes:hidden id="edit_submitted_user" name="user"/>
                <stripes:hidden id="edit_submitted_fileName" name="fileName"/>
                <input type="submit" name="editSubmittedForm" value="Yes" class="btn btn-info"/>
            </div>
        </stripes:form>
    </div>

    <!--Edit Submitted Form Modal -->
    <div id="revertSubmittedFormModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Reverting submitted form id : <span id="sfRevertLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditSubmittedFormsBean" > 
                Are you sure you want to revert the status to Pending?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">No</a>

                <stripes:hidden id="revert_id" name="id"/>
                <stripes:hidden name="processed" value="false"/>
                <stripes:hidden id="revert_user" name="user"/>
                <stripes:hidden id="revert_fileName" name="fileName"/>
                <input type="submit" name="revertSubmittedForm" value="Yes" class="btn btn-info"/>
            </div>
        </stripes:form>
    </div>

    <!--Delete Submitted Form Modal -->
    <div id="deleteSubmittedFormModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion submitted form id : <span id="sfDeleteLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteSubmittedFormBean" > 
                Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>

                <stripes:hidden id="delete_submitted_id" name="id"/>
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
