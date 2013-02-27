<%-- 
    Document   : login
    Created on : Oct 9, 2012, 11:36:22 PM
    Author     : Shamus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="loginActionBean" scope="page"
             class="com.lin.general.login.LoginActionBean"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Login | Living Integrated Network </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <%@include file="analytics/analytics.jsp"%>

        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="css/fullcalendar.css" />	
        <link rel="stylesheet" href="css/unicorn.main.css" />
        <link rel="stylesheet" href="css/unicorn.grey.css" class="skin-color" />
        <script src="js/jquery.js"></script>        
        <link rel="stylesheet" href="css/custom/lin.css" />
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
    </head>
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
    </script>
    <script>
        function getInternetExplorerVersion()
        // Returns the version of Internet Explorer or a -1
        // (indicating the use of another browser).
        {
            var rv = -1; // Return value assumes failure.
            if (navigator.appName == 'Microsoft Internet Explorer')
            {
                var ua = navigator.userAgent;
                var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
                if (re.exec(ua) != null)
                    rv = parseFloat( RegExp.$1 );
            }
            return rv;
        }
        function checkVersion()
        {
            var msg = "You're not using Internet Explorer.";
            var ver = getInternetExplorerVersion();

            if ( ver > -1 )
            {
                msg = "You're using Internet Explorer. This site is not supported on IE, and we recommend you download <a href='http://www.google.com/chrome'>Chrome</a> or <a href='http://www.mozilla.com/firefox'>Firefox</a>."
            }
            alert( msg );
        }
        window.onload = getInternetExplorerVersion();
    </script>
    <body style="background: url('img/noise_grey_bg.png')">
        <% if (session.getAttribute("user") != null) {
                response.sendRedirect("/residents/index.jsp");
            }%>
        <c:if test = "${param.err == 'true'}">
            <c:set var="errorStyle" value="error" />
        </c:if> 

        <div class="container pushdown centerText">

            <div class="userImageBadge inlineblock">
                <img src="img/lin/bh.png"/>
            </div>


            <div class="row-fluid">
                <div class="span12">
                    <div class="widget-box heavyBlackBorder inlineblock login">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-user"></i>									
                            </span>
                            <h5>Please Login</h5>
                            <h5 style="text-align: right"><a href="forgotpassword.jsp">  Forgot your password?</a></h5>

                        </div>

                        <div class="widget-content nopadding">

                            <stripes:form class="form-horizontal" method="post" action="#" name="password_validate" id="password_validate" beanclass="com.lin.general.login.LoginActionBean" focus="">
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Username</label>
                                    <div class="controls">
                                        <stripes:text name="username" value="${param.user}"/>
                                    </div>
                                </div>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Password</label>
                                    <div class="controls">
                                        <stripes:password name="plaintext"/>
                                    </div>
                                </div>
                                <div class="form-actions" id="twoButtons">
                                    <div id="regBtn"><a href="register.jsp" class="btn btn-large">Register</a></div>
                                    <div id="loginBtn"><input type="submit" value="Login" class="btn btn-info btn-large"></div>
                                </div>
                            </stripes:form>
                        </div>

                    </div>
                    <c:if test = "${param.err == 'true'}">
                        <div class="login alert alert-error container">
                            <b>Whoops.</b> Your username or password was not found in our records. Please try again.
                        </div>
                    </c:if> 
                    <c:if test = "${param.success == 'true'}">
                        <div class="login alert alert-success container">
                            <b>Success.</b> "${param.msg}"
                        </div>
                    </c:if> 

                </div>			
            </div>
        </div>



    </body>
</html>
</html>