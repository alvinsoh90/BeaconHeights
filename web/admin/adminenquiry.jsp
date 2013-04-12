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



<jsp:setProperty name = "manageEnquiryActionBean"  property = "user"  value = "${user}" />

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Resources</title>
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
                    <c:set var="enquiry" value="${manageEnquiryActionBean.getEnquiry(param.enquiry)}"/>  

                    <div class="page-header">
                        <h1>Enquiry ID:<fmt:formatNumber pattern="00000000" value="${enquiry.id}"/> - ${enquiry.regarding}




                        </h1>
                    </div>
                    <h3>Status: 
                        <script>
                                                            
                        if (${enquiry.status}){
                            document.write("[CLOSED]");
                        }else {
                            document.write("[OPEN]");
                        }
                                                      
                        </script>
                    </h3>
                    <table id ="enquiryTable" class="table table-striped table-bordered table-condensed" id="current">
                        <thead>
                        <th>User</th>
                        <th>Text</th>
                        <th>Date</th>



                        </thead>
                        <tbody>
                            <tr>
                                <td nowrap>${enquiry.user.userName}</td>
                                <td>${enquiry.text}</td>
                                <jsp:setProperty name="newsDate" property="time" value="${enquiry.opened.time}" />
                                <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${newsDate}" /></td>


                            </tr><c:if test="${manageEnquiryActionBean.getResponseList(enquiry.id).size()!=0}">     

                                <c:forEach items="${manageEnquiryActionBean.getResponseList(enquiry.id)}" var="response" varStatus="loop">
                                    <tr>
                                        <td>${response.user.userName}</td>
                                        <td nowrap>${response.text}</td>
                                        <jsp:setProperty name="newsDate" property="time" value="${response.opened.time}" />
                                        <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${newsDate}" /></td>


                                    </tr>
                                </c:forEach>
                            </c:if>
                    </table>
                </div>


                <a href="#updateEnquiryModal" role='button' data-toggle='modal' class="btn btn-success">Reply to this Enquiry</a>
            </div>
        </div>
    </div>

    <hr>

    <%@include file="include/footer.jsp"%>
    <!-- Enquiry creation -->
    <div id="updateEnquiryModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Update an Enquiry</h3>
            <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManageEnquiryActionBean" focus="" id="new_enquiry_validate" name="new_enquiry_validate">
                <div class="control-group ${errorStyle}">
                    <div class="controls">
                        <stripes:hidden id="create_id" name="id"/>
                        <stripes:hidden id="create_user" name="userId" value="${user.userId}"/>
                    </div>
                </div>
                <div class="control-group ${errorStyle}">

                    <label class="control-label">Title</label>
                    <div class="controls">
                        <stripes:text id="create_title" name="title" value="Re: ${enquiry.regarding}"/> 
                    </div>
                </div>    
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Content</label>
                    <div class="controls">
                        <stripes:textarea id="create_text" name="text"/> 
                    </div>
                </div>
                <stripes:hidden name="replyid" value="${enquiry.id}"/>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Mark as Closed? </label>
                    <div class="controls">
                        <stripes:checkbox id="status" name="status"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>
                <input type="submit" name="adminUpdate" value="Update" class="btn btn-primary"/>
            </div>
           
        </stripes:form>

    </div>


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
