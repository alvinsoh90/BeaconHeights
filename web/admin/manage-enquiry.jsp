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

<jsp:useBean id="manageEnquiryActionBean" scope="page"
             class="com.lin.resident.ManageEnquiryActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>



<jsp:setProperty name = "manageEnquiryActionBean"  property = "user"  value = "${user}" />

<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Resources</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
       <script>
                
            var enquiryList = [];
            
            function populateViewEnquiryModal(enquiryId){ 
                enquiryList.forEach(function(enquiry){
                    if(enquiry.id == enquiryId){
                        
                        $("#view_title").val(enquiry.title);
                        $("#view_date").val(enquiry.date);
                        $("#view_text").val(enquiry.text);
                        $("#view_id").val(enquiry.id);
                        $("#view_responder").val(enquiry.responder);
                        $("#view_response").val(enquiry.response);
                    }
                });
            }
        </script>


        <c:forEach items="${manageEnquiryActionBean.enquiryList}" var="enquiry" varStatus="loop">
            <script>
                
                
                var enquiry = new Object();
                enquiry.id = '${enquiry.id}';
                enquiry.title = '${enquiry.title}';
                enquiry.text = '${enquiry.text}';
                enquiry.date = '${enquiry.enquiryTimeStamp}';
                enquiry.isResolved = '${enquiry.isResolved}';
                enquiry.responder = '${enquiry.userByResponderId}';
                enquiry.response = '${enquiry.response}';
                enquiryList.push(enquiry);

                
            </script>


        </c:forEach>


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

                

                        <table class="table table-striped table-bordered table-condensed" id="current">
                            <c:if test="${manageEnquiryActionBean.enquiryList.size()!=0}">     
                                <thead>
                                <th>No.</th>
                                <th>Title</th>
                                <th>Date</th>
                                <th>Status</th>

                                </thead>
                                <tbody>
                                    <%int count = 1;%>
                                    <c:forEach items="${manageEnquiryActionBean.enquiryList}" var="enquiry" varStatus="loop">
                                        <tr>
                                            <td><%= count++%></td>
                                            <td nowrap><a href="#viewEnquiryModal" role="button" data-toggle="modal" onclick="populateViewEnquiryModal('${enquiry.id}')"> ${enquiry.title}</td>
                                            <td nowrap><fmt:formatDate pattern="dd-MM-yyyy HH:mma" 
                                                               value="${enquiry.enquiryTimeStamp}"/></td>
                                    <td nowrap>
                                        <script>
                                                            
                                            if (${enquiry.isResolved}){
                                                document.write("Resolved");
                                            }else {
                                                document.write("Unresolved");
                                            }
                                                      
                                        </script>
                                    </td>

                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${manageEnquiryActionBean.enquiryList.size()==0}">
                                <thead>
                                <th> You have no enquiries or feedback at the moment. Would you like to make one?</th>
                                </thead>
                            </c:if>
                        </table>

                    </div>

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
                    <a href="#createEnquiryModal" role='button' data-toggle='modal' class="btn btn-success">Submit Enquiry/Feedback</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Enquiry creation -->
        <div id="createEnquiryModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Submit an Enquiry</h3>
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
                            <stripes:text id="create_title" name="title"/> 
                        </div>
                    </div>    
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Content</label>
                        <div class="controls">
                            <stripes:textarea id="create_text" name="text"/> 
                        </div>
                    </div>                              
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <input type="submit" name="submit" value="Submit" class="btn btn-primary"/>
                </div>
            </stripes:form>

        </div>

        <!-- View and update enquiries -->
        <div id="viewEnquiryModal" class="modal hide fade">
            <div id="myModal" class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Your Enquiry</h3>

                <stripes:form class="form-horizontal" beanclass="com.lin.resident.ManageEnquiryActionBean" focus="" name="edit_enquiry_validate" id="edit_enquiry_validate">
                    <div class="control-group ${errorStyle}">
                        <div class="controls">
                            <stripes:hidden id="view_id" name="id"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Title</label>
                        <div class="controls">
                            <stripes:text id="view_title" name="title"/> 
                        </div>
                    </div>    
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Content</label>
                        <div class="controls">
                            <stripes:textarea id="view_text" name="text"/> 
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Responder</label>
                        <div class="controls">
                            <stripes:text id="view_responder" name="responder" /> 
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Response</label>
                        <div class="controls">
                            <stripes:textarea id="view_response" name="responder"/> 
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <input type="submit" name="editEnquiry" value="Click to Edit" class="btn btn-primary"/>
                </div>  

            </stripes:form>


        </div>


        <script src="js/jquery.js"></script>
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

    </body>
</html>
