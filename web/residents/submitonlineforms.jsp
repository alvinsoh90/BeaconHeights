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
        <jsp:useBean id="manageFormTemplateActionBean" scope="page"
                     class="com.lin.general.admin.ManageFormTemplateActionBean"/>
        <jsp:useBean id="editFormTemplateBean" scope="page"
                     class="com.lin.general.admin.EditFormTemplateBean"/>
        <jsp:useBean id="deleteFormTemplateBean" scope="page"
                     class="com.lin.general.admin.DeleteFormTemplateBean"/>
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
            var formTemplateList = [];
            
            //when this function is called, formTemplateList should already be populated
            function populateSubmitFormModal(formTemplateID){ 
                formTemplateList.forEach(function(formTemplate){
                    if(formTemplate.id == formTemplateID){
                        $("#formTemplateLabel").text(formTemplate.name);
                        $("#submit_title").val(formTemplate.name);
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
        
        
                <script>
            // Init an array of all rc shown on this page
            var sfList = [];
           
            
            
            //when this function is called, sfList should already be populated
            function populateDeleteSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfDeleteLabel").text(submittedForm.id);
                        $("#delete_name").text(submittedForm.fileName);
                        $("#delete_id").val(submittedForm.id);

                    }
                });
                
            }
            
            function populateEditSubmittedFormModal(sfID){ 
                sfList.forEach(function(submittedForm){
                    if(submittedForm.id == sfID){
                        $("#sfEditLabel").text(submittedForm.id);
                        $("#edit_processed").text(submittedForm.processed);
                        $("#edit_id").val(submittedForm.id);
                        $("#edit_user").val(submittedForm.user);
                        $("#edit_fileName").val(submittedForm.fileName);

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
                                        <td><b><a href="/pdf_uploads/${formTemplate.fileName}">${formTemplate.fileName}</a></b></td>

                                        <td>
                                            <a href="#submitFormModal" role="button" data-toggle="modal" class="btn btn-success btn-mini" onclick="populateSubmitFormModal('${formTemplate.id}')">Submit</a> 

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


    <!-- Submit Form Modal Form -->
    <div id="submitFormModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Submit <span id="formTemplateLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageSubmittedFormsActionBean" name="new_resource_validate" id="new_resource_validate">                 
                <stripes:hidden id="submit_title" name="title" />
                <stripes:hidden name="user_id" value="${user.userId}" />
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Comments:</label>
                    <div class="controls">
                        <stripes:textarea name="comments" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">File:</label>
                    <div class="controls">
                        <stripes:file name="file"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="submit" value="Submit" class="btn btn-info btn-large"/>                                                           
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
