<%-- 
    Document   : forgotpassword
    Created on : Feb 17, 2013, 10:18:17 PM
    Author     : jonathanseetoh
--%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Login | Living Integrated Network </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="css/fullcalendar.css" />	
        <link rel="stylesheet" href="css/unicorn.main.css" />
        <link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />
        <link rel="stylesheet" href="css/custom/lin.css" />
        <link rel="stylesheet" href="css/uniform.css" />
        <link rel="stylesheet" href="css/chosen.css" />

        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.ui.custom.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!--<script src="js/jquery.uniform.js"></script> -->
        <script src="js/jquery.chosen.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/unicorn.js"></script>
        <script src="js/custom/lin.register.js"></script>

        <script>
            var levels="";
            var units = "";
            
            function loadLevelsAndUnits() {
                console.log("loading");
                var source = "/json/loadblockproperties.jsp?blockName="+$('select#block').val();
                $.ajax({
                    url: "/json/loadblockproperties.jsp",
                    type: "GET",
                    data:"blockName="+$('select#block').val(),
                    dataType: 'text',
                    success: function (data) {
                        var obj = jQuery.parseJSON(data);
                        levels = obj.levels;
                        units = obj.units;
                        
                        var levelOptions="";
                        var unitOptions = "";
                        for (var i=1;i<levels+1;i++){
                            if(i<10){
                                levelOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                levelOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        for (var i=1;i<units+1;i++){
                            if(i<10){
                                unitOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                unitOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        $("select#level").html(levelOptions);
                        $("select#unitnumber").html(unitOptions);
                        
                        // only after successful loading should we load this 'sexy chosen' plugin	
                        $('select').chosen();
                    }
                });
            };
            
            $(document).ready(function(){    
            
                // When document loads fully, load level and unit options via AJAX
                loadLevelsAndUnits();

                // if dropdown changes, we want to reload the unit and level options.
                $("#block").change(function(){
                    loadLevelsAndUnits();
                });
            });
            
        </script>
    </head>

    <body style="background: url('img/noise_grey_bg.png')">

        <c:if test = "${param.success == 'true'}">
            <c:set var="errorStyle" value="error" />
        </c:if> 

        <div class="container pushdown centerText">

            <div class="userImageBadge inlineblock">
                <img src="img/lin/bh.png"/>
            </div>


            <div class="row-fluid">
                <div class="span12">
                    <c:if test = "${param.success == 'false'}">
                        <div>
                            <br/>
                        </div>
                        <div class="login alert alert-error container">
                            <b>Whoops.</b> ${param.msg}
                        </div>
                    </c:if> 
                    <c:if test = "${param.success == 'true'}">
                        <div>
                            <br/>
                        </div>
                        <div class="login alert alert-success container">
                            <b>Success: </b> ${param.msg}
                        </div>
                    </c:if> 
                    <div class="widget-box heavyBlackBorder inlineblock register">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-lock"></i>									
                            </span>
                            <h5>Forgot your password?</h5>
                        </div>

                        <div class="widget-content nopadding">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.login.ForgotPasswordActionBean" focus="" name="forgotpassword_validate" id="forgotpassword_validate">
                               
                                <div class="control-group ${errorStyle}">
                                    <h5>
                                        Please enter your username OR email address for verification and an email containing a new password will be sent to your email address.
                                
                                    </h5>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Username</label>
                                    <div class="controls">
                                        <stripes:text name="username" autocomplete="off"/>
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Email</label>
                                    <div class="controls">
                                        <stripes:text name="email" autocomplete="off"/> 
                                    </div>
                                                      
                              
                    
                                <div class="form-actions" id="twoButtons">
                                        <input type="submit" name="forgotPassword" value="New Password" class="btn btn-info btn-small">
                                        <a href="/login.jsp" role ="button" class="btn btn-cancel btn-small" id="customCancelBut">Cancel</a>
                                </div>                            

                            </stripes:form>

                        </div>

                    </div>


                </div>			
            </div>
        </div>




    </body>
</html>