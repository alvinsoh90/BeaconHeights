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
        <title>PFS</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le styles -->
        <link href="/LIN/css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
        </style>
        <link href="/LIN/css/bootstrap-responsive.css" rel="stylesheet">

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le fav and touch icons -->
        <link rel="shortcut icon" href="../assets/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
    </head>

    <body>
        <div class="container">
            <div class="row">
                <div class="span4 offset4">
                    <div style="text-align:center"><h3>Personal Finance System</h3></div>
                    <stripes:form beanclass="com.lin.general.login.LoginActionBean" focus="">
                        <table>
                            <tr>
                                <td>Number 1:</td>
                                <td><stripes:text name="username"/></td>
                            </tr>
                            <tr>
                                <td>Number 2:</td>
                                <td><stripes:text name="plaintext"/></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                            <stripes:submit name="login" value="login"/>                    
                            </td>
                            </tr>
                            <tr>
                                <td>Result:</td>
                                <td>${actionBean.result}</td>
                            </tr>
                        </table>
                    </stripes:form>
                </div>
            </div>	
        </div>
    </body>
</html>