<%-- 
    Document   : login
    Created on : Oct 9, 2012, 11:36:22 PM
    Author     : Shamus
--%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:useBean id="chooseUsernameActionBean" scope="page"
             class="com.lin.general.login.ChooseUsernameActionBean"/>
<jsp:useBean id="logoutActionBean" scope="page"
             class="com.lin.general.login.LogoutActionBean"/>



<!DOCTYPE html>
<html lang="en">
    <head>
        <c:if test= "${user==null}">
            <c:redirect url="/login.jsp" />
        </c:if>
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
        <script src="js/custom/lin.chooseusername.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        
        <%@include file="analytics/analytics.jsp"%>

        <style type="text/css">
        .widget-box .form-horizontal .control-label {
        padding-top: 15px;
        width: 32%;
        float: left;
        }
        .widget-box .form-horizontal .checkBtn {
        padding-top: 15px;
        width: 10%;
        float: right;
        }
        .form-horizontal input[type=text], .form-horizontal input[type=password], .form-horizontal textarea {
        width: 63%;
        float: left;
        margin-left: 3px;
        }

        </style>
        
        <script>
            function checkUser(){
                //$("#success").val('true')
                var dat = new Object();
                dat.username = $("#username").val();
                
                //post comment
                $.ajax({
                    type: "POST",
                    url: "/json/checkusername.jsp",
                    data: dat,
                    success: function(data) {
                        console.log(data.result);
                        var valid = data.result;
                        if(valid==false){
                            $("#success").val('true');
                            alert("Username is valid : " + $("#username").val() + " can be used.");
                        }else{
                            $("#success").val('false');
                            alert("Username is invalid : " + $("#username").val() + " already exists.");
                        }
                    }, 
                    dataType: "json"
                });
            }
            
            function submitForm(){
                //checkUser();
                var success = $("#success").val();
                if (success=='true'){
                    if(confirm('Once you confirm, you can never change your username again.')){
                        $("#chooseUsername").submit();
                    }
                }else{
                    alert("Please click Check to see if you have entred a valid username.");
                }
            }
            
            function logOutFunction(){
                $("#logout").submit();
            }
            
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
                                <i class="icon-pencil"></i>									
                            </span>
                            <h5>Please choose a username and password for your new account.</h5>
                        </div>

                        <div class="widget-content nopadding">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.login.ChooseUsernameActionBean" focus="" name="chooseUsername" id="chooseUsername">
                                <!-- User enters username, still need to validate if username is valid -->
                                <stripes:hidden name="success" id="success" value="false" />
                                <stripes:hidden name="userId" id="userId" value="${user.userId}" />
                                
                                <div class="control-group ${errorStyle}">
                                <label class="control-label">New username:</label>
                                <div class="controls">
                                    <stripes:text name="username" id="username" /><a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="checkUser()"><i class="iconLike icon-search"></i> <span class="txt">Check</span></a>
                                </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">New Password:</label>
                                    <div class="controls">
                                        <stripes:password name="newpassword" id="newpassword" />
                                    </div>
                                </div>                             
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Confirm New Password:</label>
                                    <div class="controls">
                                        <stripes:password name="newpasswordconfirm" id="newpasswordconfirm" /> 
                                    </div>
                                </div>                        
                                <div class="form-actions" id="twoButtons" style="padding-left:15px">
                                    <a class="btn btn-info btn-large" onclick="submitForm()" style="width:150px" ></i> <span class="txt">Unlock</span></a>
                                    <a class="btn btn-cancel btn-large" onclick="logOutFunction()" style="width:150px" ></i> <span class="txt">Cancel</span></a>
                                    
                                </div>                            

                            </stripes:form>
                            <stripes:form  beanclass="com.lin.general.login.LogoutActionBean" focus="" name="logout" id="logout">
                                
                            </stripes:form>
                        </div>

                    </div>


                </div>			
            </div>
        </div>




    </body>
</html>