
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/protectadmin.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Events</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <jsp:useBean id="manageEventBean" scope="page"
                     class="com.lin.resident.ManageEventBean"/>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/chosen.css" />

        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">


        <script src="js/jquery.js"></script>
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>
        <script src="/js/jquery.chosen.js"></script>
        <script src="../js/jquery.validate.js"></script>
        <script src="/js/custom/lin.manageamenities.js"></script> 
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        

        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script>
            $(document).ready(function() {
                $('#table_id').dataTable( {
                    "bJQueryUI": true,
                    "sPaginationType": "full_numbers",
                    "bLengthChange": false,
                    "bFilter": true,
                    "bSort": true,
                    "bInfo": false,
                    "bAutoWidth": false
                } );
                
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
            
            
            function populateDeleteEventModal(eventId,eventTitle){ 
                $("#eventDeleteLabel").text(eventTitle);
                $("#delete_label").text(eventTitle);
                $("#delete_name").val(eventTitle);
                $("#delete_id").val(eventId);

            }
            
            function populateUndeleteEventModal(eventId,eventTitle){ 
                $("#eventUndeleteLabel").text(eventTitle);
                $("#undelete_label").text(eventTitle);
                $("#undelete_name").val(eventTitle);
                $("#undelete_id").val(eventId);

            }
            
            function populateFeatureEventModal(eventId,eventTitle){ 
                $("#eventFeatureLabel").text(eventTitle);
                $("#feature_label").text(eventTitle);
                $("#feature_name").val(eventTitle);
                $("#feature_id").val(eventId);

            }
            
            function populateUnfeatureEventModal(eventId,eventTitle){ 
                $("#eventUnfeatureLabel").text(eventTitle);
                $("#unfeature_label").text(eventTitle);
                $("#unfeature_name").val(eventTitle);
                $("#unfeature_id").val(eventId);

            }
            
            function populateUploadBannerModal(eventId){ 
                $("#bannerEvent_id").val(eventId);

            }
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

                    <!--Delete Event Modal Form -->
                    <div id="deleteEventModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Deletion of <span id="eventDeleteLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.resident.ManageEventBean"> 
                                You are now deleting <span id="delete_label"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="delete_id" name="id"/>
                                <stripes:hidden id="delete_name" name="name"/>
                                <input type="submit" name="deleteEventAllEventTab" value="Confirm Delete" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>  
                    
                    <!--Undelete Event Modal Form -->
                    <div id="undeleteEventModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Undo the Deletion of <span id="eventUndeleteLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.resident.ManageEventBean"> 
                                You are now undoing the delete of <span id="undelete_label"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="undelete_id" name="id"/>
                                <stripes:hidden id="undelete_name" name="name"/>
                                <input type="submit" name="deleteEventAllEventTab" value="Confirm Undo" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>  
                    
                    <!--Feature Event Modal Form -->
                    <div id="featureEventModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Featuring of <span id="eventFeatureLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.resident.ManageEventBean"> 
                                You are now about to feature <span id="feature_label"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="feature_id" name="id"/>
                                <stripes:hidden id="feature_name" name="name"/>
                                <input type="submit" name="featureEvent" value="Feature!" class="btn btn-info"/>
                            </div>
                        </stripes:form>
                    </div>
                    
                    <!--UNFeature Event Modal Form -->
                    <div id="unfeatureEventModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Unfeaturing of <span id="eventUnfeatureLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.resident.ManageEventBean"> 
                                You are now about to unfeature <span id="unfeature_label"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="unfeature_id" name="id"/>
                                <stripes:hidden id="unfeature_name" name="name"/>
                                <input type="submit" name="featureEvent" value="Unfeature!" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>
                    
                    <!-- Upload Event banner Modal Form -->
                    <div id="uploadBannerModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Upload A New Banner</h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.UploadEventBannerActionBean">  
                                <h6>Please upload images which are 800px by 200px for best results.</h6>
                                <stripes:hidden id="bannerEvent_id" name="id"/>
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">File:</label>
                                    <div class="controls">
                                        <stripes:file name="file" id="file"/><div id="fileInfoMsg"></div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="submit" name="uploadBanner" value="Upload" class="btn btn-info btn-large" id="uploadBtn"/>                                                           
                                </stripes:form>
                            </div>
                        </div>      
                    </div>

                    <div class="page-header">
                        <h1>Event<small> Manage events</small></h1>
                    </div>
                    
                    <table id="table_id" name="table_id" class ="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Event Start Time</th>
                                <th nowrap>Admin?</th>
                                <th nowrap>Public?</th>
                                <th nowrap>Featured?</th>
                                <th nowrap>Deleted?</th>
                                <th nowrap>Banner</th>
                                <th nowrap></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageEventBean.getEventListWithNoComments()}" var="event" varStatus="loop">
                            <tr>

                                <td>${event.id}</td>
                                <td>${event.title}</td>
                                <td nowrap><fmt:formatDate pattern="dd-MM-yyyy hh:mma" 
                                                                    value="${event.startTime}"/></td>
                                <td><c:choose>
                                        <c:when test="${event.isAdminEvent}">
                                            Yes
                                        </c:when>
                                        <c:otherwise>
                                            No
                                        </c:otherwise>
                                    </c:choose></td>
                                <td><c:choose>
                                        <c:when test="${event.isPublicEvent}">
                                            Yes
                                        </c:when>
                                        <c:otherwise>
                                            No
                                        </c:otherwise>
                                    </c:choose></td>
                                <td><c:choose>
                                        <c:when test="${event.isFeatured}">
                                            Yes
                                        </c:when>
                                        <c:otherwise>
                                            No
                                        </c:otherwise>
                                    </c:choose></td>
                                <td><c:choose>
                                        <c:when test="${event.isDeleted}">
                                            Yes
                                        </c:when>
                                        <c:otherwise>
                                            No
                                        </c:otherwise>
                                    </c:choose></td></td>
                                <td>
                                    <a href="/uploads/event_banners/${event.bannerFileName}">View</a>
                                </td>
                                <td nowrap>
                                    <c:choose>
                                        <c:when test="${event.isFeatured}">
                                            <a href="#unfeatureEventModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateUnfeatureEventModal('${event.id}','${event.title}')">Unfeature</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#featureEventModal" role="button" data-toggle="modal" class="btn btn-info btn-mini" onclick="populateFeatureEventModal('${event.id}','${event.title}')">Feature</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${event.isDeleted}">
                                            <a href="#undeleteEventModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateUndeleteEventModal('${event.id}','${event.title}')">Undo-delete</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#deleteEventModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteEventModal('${event.id}','${event.title}')">Delete</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="#uploadBannerModal" role="button" data-toggle="modal" class="btn btn-success btn-mini" onclick="populateUploadBannerModal('${event.id}')">Upload Banner</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    
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
        <%@include file="/analytics/analytics.jsp"%>

    </body>
</html>
