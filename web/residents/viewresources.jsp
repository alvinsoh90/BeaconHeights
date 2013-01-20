<%-- 
    Document   : viewresources
    Created on : Jan 19, 2013, 6:35:46 PM
    Author     : jonathanseetoh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Services | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="manageResourceActionBean" scope="page"
                     class="com.lin.general.admin.ManageResourceActionBean"/>
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

    </head>
       <body>

        <div id="content">

            <div class="container">

                <div class="row">
                    <div class="span3">

                        <div class="account-container">
                            <h2>View Resources</h2>
                            <select id ="view">
                                <option value="Current Bookings">Forms</option>
                                <option value="Booking History">Information & Guidelines</option>
                            </select>

                        </div> <!-- /account-container -->
                    </div>
                    <div class="span9">

                        <h1 class="page-title">
                           
                            Resources			
                        </h1>
                        <br/>

                        <div class="widget widget-table">

                            <div class="widget-header">
                                <i class="icon-th-list"></i>
                                <h3> List of Resources </h3>

                                
                            </div> <!-- /widget-header -->
                            <table class="table table-striped table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Category</th>
                                    <th>Filename</th>
                                    <th>Last Updated</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${manageResourceActionBean.resourceList}" var="resource" varStatus="loop">
                                <script>
                                    var resource = new Object();
                                    resource.id = '${resource.id}';
                                    resource.name = '${resource.name}';
                                    resource.description = '${resource.description}';
                                    resource.category = '${resource.category}';
                                    resource.fileName = '${resource.fileName}';
                                    resource.timeCreated = '${resource.timeCreated}';
                                    resourceList.push(resource);
                                </script>
                                <tr>

                                    <td><b>${resource.id}</b></td>
                                    <td><b>${resource.name}</b></td>
                                    <td><b>${resource.description}</b></td>
                                    <td><b>${resource.category}</b></td>
                                    <td><b><a href="/pdf_uploads/${resource.fileName}">${resource.fileName}</a></b></td>
                                    <td><b>${resource.timeCreated}</b></td>
                                    
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
                            
                            </div>
                        </div>
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