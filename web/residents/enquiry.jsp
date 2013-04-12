<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>My Enquiries and Feedback | Beacon Heights</title>
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
        <%@include file="/protect.jsp"%>
        <%@include file="/header.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

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
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        <!-- Scripts -->

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
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
            
                var enquiryList = [];
            
           
        </script>

        <script>
            function loadValidate(){
                $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                $('select').chosen();

                $("#new_enquiry_validate").validate({
                    rules:{
                        text:{
                            required:true
                        }     
                    },
                    errorClass: "help-inline",
                    errorElement: "span",
                    highlight:function(element, errorClass, validClass) {
                        $(element).parents('.control-group').addClass('error');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('error');
                        $(element).parents('.control-group').addClass('success');
                    }
                });
                
                
            }
        </script>


    </head>

    <body>

        <div id="content">

            <div class="container">


                <div class="row">

                    <div class="span3">


                        <div class="account-container">

                            <h2>View Your Enquiry</h2>
                            <select id ="view">
                                <option value="Current Enquiries">Current Enquiries</option>
                            </select>

                        </div> <!-- /account-container -->

                    </div>

                    <div class="span9">

                        <!-- Info Messages -->
                        <%@include file="pageinfobar.jsp"%>
                        <h1 class="page-title">
                            <i class="icon-calendar"></i>
                            My Enquiries and Feedback					
                        </h1>
                        <br/>

                        <c:set var="enquiry" value="${manageEnquiryActionBean.getEnquiry(param.enquiry)}"/>  
                        <c:if test="${enquiry.user.userId==user.userId}">
                            <div class="widget widget-table">

                                <div class="widget-header">
                                    <i class="icon-th-list"></i>
                                    <h3> Enquiry ID:<fmt:formatNumber pattern="00000000" value="${enquiry.id}"/> - ${enquiry.regarding}

                                        <script>
                                                            
                                            if (${enquiry.status}){
                                                document.write("[CLOSED]");
                                            }else {
                                                document.write("[OPEN]");
                                            }
                                                      
                                        </script>

                                    </h3>

                                </div> <!-- /widget-header -->

                                <div class="widget-content">

                                    <table class="table table-striped table-bordered" id="current">   
                                        <thead>
                                        <th>User</th>
                                        <th>Text</th>
                                        <th>Date</th>



                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td nowrap>${enquiry.user.userName}</td>
                                                <td><a href="enquiry.jsp?enquiry=${enquiry.id}"> ${enquiry.text}</td>
                                                <jsp:setProperty name="newsDate" property="time" value="${enquiry.opened.time}" />
                                                <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" value="${newsDate}" /></td>


                                            </tr><c:if test="${manageEnquiryActionBean.getResponseList(enquiry.id).size()!=0}">     

                                            <tbody>
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
                                <br/>
                                <a href="#createEnquiryModal" role='button' data-toggle='modal' class="btn btn-success" onclick="loadValidate()">Update this Enquiry</a>
                            </div>
                        </c:if>
                        <c:if test="${enquiry.user.userId!=user.userId}">
                            This enquiry does not belong to you. Please ensure you are at your own enquiry.
                        </c:if>
                    </div>


                </div> <!-- /row -->

            </div> <!-- /container -->

        </div> <!-- /content -->

        <!-- Enquiry creation -->
        <div id="createEnquiryModal" class="modal hide fade">
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
                </div>
                <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Close</a>
                    <input type="submit" name="update" value="Update" class="btn btn-primary"/>
                </div>
            </stripes:form>

        </div>



        <div class="modal-body">

        </div>

        <%@include file="/footer.jsp"%>


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
