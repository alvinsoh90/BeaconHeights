<%-- 
    Document   : login
    Created on : Oct 9, 2012, 11:36:22 PM
    Author     : Shamus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>

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
    </head>

    <body>
        <div class="container pushdown centerText">
            
            <div class="userImageBadge heavyBlackBorder inlineblock">
                <img src="http://b.vimeocdn.com/ps/346/445/3464459_300.jpg"/>
            </div>
            
            
            <div class="row-fluid">
                <div class="span12">
                    <div class="widget-box heavyBlackBorder inlineblock login">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-user"></i>									
                            </span>
                            <h5>Please Login</h5>
                        </div>
                        <div class="widget-content nopadding">
                                
                                <stripes:form class="form-horizontal" method="post" action="#" name="password_validate" id="password_validate" beanclass="com.lin.general.login.LoginActionBean" focus="">
                                <div class="control-group">
                                    <label class="control-label">Username</label>
                                    <div class="controls">
                                        <stripes:text name="username"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">Password</label>
                                    <div class="controls">
                                        <stripes:password name="plaintext"/>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <input type="submit" value="Login" class="btn btn-info btn-large">
                                </div>
                            </stripes:form>
                        </div>
                    </div>
                </div>			
            </div>
        </div>

        	
   
    </body>
</html>