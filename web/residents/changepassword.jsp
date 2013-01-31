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
                   
                    <div class="span12">
                        <!-- Info Messages -->
                        <%@include file="pageinfobar.jsp"%>

                        <h1 class="page-title">

                            Change Password	
                        </h1>
                        <br/>
                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ChangePasswordActionBean" name="new_resource_validate" id="new_resource_validate">                 
                        <stripes:hidden name="user_id" value="${user.userId}" />
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Old Password:</label>
                            <div class="controls">
                                <stripes:password name="oldpassword" />
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">New Password:</label>
                            <div class="controls">
                                <stripes:password name="newpassword" />
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Repeat New Password:</label>
                            <div class="controls">
                                <stripes:password name="newpassword2" />
                            </div>
                        </div>
                        <div class="span3 offset3">
                            <input type="submit" name="submit" value="Submit" class="btn btn-info btn-large"/>                                                           
                        </div>
                           
                        </stripes:form>
                    
                </div>


            </div> <!-- /row -->

        </div> <!-- /container -->

    </div> <!-- /content -->


    




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
