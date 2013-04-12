<%-- 
    Document   : manage-enquiry
    Created on : Jan 28, 2013, 5:28:39 PM
    Author     : jonathanseetoh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="manageEnquiryActionBean" scope="page"
             class="com.lin.resident.ManageEnquiryActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>
<jsp:useBean id="newsDate" class="java.util.Date" />
<jsp:useBean id="upDate" class="java.util.Date" />



<jsp:setProperty name = "manageEnquiryActionBean"  property = "user"  value = "${user}" />

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Enquiries</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="js/jquery.js"></script>        
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
        <script>
            $(document).ready(function() {
                $('#enquiryTable').dataTable( {
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                } );
            });
            
            
            var enquiryList = [];

        </script>



    </head>
    <body>

        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>   

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>

                    <div class="page-header">
                        <h1>Enquiries <small>Manage Enquiries</small></h1>
                    </div>



                    <table id ="enquiryTable" class="table table-striped table-bordered table-condensed" id="current">
                        <c:if test="${manageEnquiryActionBean.enquiryList.size()!=0}">     
                            <thead>
                            <th>No.</th>
                            <th>User</th>
                            <th>Title</th>
                            <th>Date</th>
                            <th>Last Update</th>
                            <th>Status</th>

                            </thead>
                            <tbody>
                                <c:forEach items="${manageEnquiryActionBean.enquiryList}" var="enquiry" varStatus="loop">
                                    <tr>
                                        <td>ID:<fmt:formatNumber pattern="00000000" value="${enquiry.id}"/></td>
                                        <td nowrap>${enquiry.user.userName}</td>
                                        <td nowrap><a href="adminenquiry.jsp?enquiry=${enquiry.id}"> ${enquiry.regarding}</td>

                                        <jsp:setProperty name="newsDate" property="time" value="${enquiry.opened.time}" />
                                        <jsp:setProperty name="upDate" property="time" value="${enquiry.lastUpdated.time}" />
                                        <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${newsDate}" /></td>
                                        <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${upDate}" /></td>
                                        <td nowrap>
                                            <script>
                                                            
                                                if (${enquiry.status}){
                                                    document.write("CLOSED");
                                                }else {
                                                    document.write("OPEN");
                                                }
                                                      
                                            </script>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${manageEnquiryActionBean.enquiryList.size()==0}">
                            <thead>
                            <th> No enquiries or feedback exist at the moment</th>
                            </thead>
                        </c:if>
                    </table>

                </div>
            </div>
        </div>
    </div>

    <hr>

    <%@include file="include/footer.jsp"%>



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
    <%@include file="/analytics/analytics.jsp"%>

</body>
</html>
