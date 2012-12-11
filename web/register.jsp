<%-- 
    Document   : login
    Created on : Oct 9, 2012, 11:36:22 PM
    Author     : Shamus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
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
        <script src="js/unicorn.form_common.js"></script>
    </head>

    <body style="background: url('img/noise_grey_bg.png')">
        <c:if test = "${param.success == 'true'}">
            <c:set var="errorStyle" value="error" />
        </c:if> 

        <div class="container pushdown centerText">

            <div class="userImageBadge heavyBlackBorder inlineblock">
                <img src="img/lin/loginlogo.png"/>
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
                            <b>Awesome!</b> ${param.msg}
                        </div>
                    </c:if> 
                    <div class="widget-box heavyBlackBorder inlineblock register">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-pencil"></i>									
                            </span>
                            <h5>Please fill in the registration form</h5>
                        </div>
                        <div class="widget-content nopadding">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.login.RegisterActionBean" focus="" name="registration_validate" id="registration_validate">
                                <!-- User enters username, still need to validate if username is valid -->
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Username</label>
                                    <div class="controls">
                                        <stripes:text name="username"/>
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Password</label>
                                    <div class="controls">
                                        <stripes:password name="password" id="password"/>
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Confirm Password</label>
                                    <div class="controls">
                                        <stripes:password name="passwordconfirm" id="passwordconfirm"/>
                                    </div>
                                </div>                             
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">First Name</label>
                                    <div class="controls">
                                        <stripes:text name="firstname"/> 
                                    </div>
                                </div>                              
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Last Name</label>
                                    <div class="controls">
                                        <stripes:text name="lastname"/> 
                                    </div>
                                </div>

                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Block</label>
                                    <div class="controls">
                                        <stripes:select name="block">
                                            <stripes:options-collection collection="${registerActionBean.allBlocks}" value="blockName" label="blockName"/>        
                                        </stripes:select>
                                    </div>
                                </div>
                          
                              
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Level</label>
                                    <div class="controls">
                                        <stripes:text name="level"/>
                                    </div>
                                </div>     
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Unit Number</label>
                                    <div class="controls">
                                        <stripes:text name="unitnumber" />
                                    </div>
                                </div>                              
                                <div class="form-actions">
                                    <input type="submit" name="registerTempUserAccount" value="Register" class="btn btn-info btn-large">
                                </div>                            

                            </stripes:form>
                        </div>

                    </div>


                </div>			
            </div>
        </div>
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.ui.custom.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.uniform.js"></script>
        <script src="js/jquery.chosen.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/unicorn.js"></script>
        <script src="js/custom/lin.register.js"></script>


    </body>
</html>
</html>