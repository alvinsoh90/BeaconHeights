<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>

<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageResourceActionBean" scope="page"
             class="com.lin.general.admin.ManageResourceActionBean"/>
<jsp:useBean id="editResourceBean" scope="page"
             class="com.lin.general.admin.EditResourceBean"/>
<jsp:useBean id="deleteResourceBean" scope="page"
             class="com.lin.general.admin.DeleteResourceBean"/>
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin | Online Forms</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">        
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <!-- Populates the Edit RC form -->
        <script>   
            
            // Init an array of all rc shown on this page
            var resourceList = [];
            
            
            
            //show submitted forms table - this needs to populate the submitted forms and not templates.
            function showSubmittedForms(submittedFormsArr){
   
                var r = new Array(), j = -1;
                
                var tableHeaders = "<tr><th>ID</th><th>Form Title</th><th>Category</th><th>Username</th><th>Filename</th><th>Last Updated</th><th>Action</th></tr>"
                
                for (var i=0; i<submittedFormsArr.length; i++){
                    //console.log(booking.username);
                    r[++j] ='<tr><td><b>';
                    r[++j] = submittedFormsArr[i].id;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = submittedFormsArr[i].name;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = submittedFormsArr[i].category;
                    r[++j] = '</b></td><td nowrap><b>';
                    r[++j] = "user submitted";//submittedFormsArr[i].
                    r[++j] = '</b></td><td ><b>';
                    r[++j] = "<a href='/pdf_uploads/"+submittedFormsArr[i].fileName+"'>"+submittedFormsArr[i].fileName+"</a>";
                    r[++j] = '</b></td><td ><b>';
                    r[++j] = submittedFormsArr[i].timeCreated;
                    r[++j] = '</b></td><td ><b>';
                    r[++j] = "<a href='#editResourceModal' role='button' data-toggle='modal' class='btn btn-primary btn-mini' onclick='populateEditResourceModal(" + resource.id + ")'>Edit</a>\n\
                                                <a href='#deleteResourceModal' role='button' data-toggle='modal' class='btn btn-danger btn-mini' onclick='populateDeleteResourceModal("+resource.id+")'>Delete</a>";
                    r[++j] = '</b></td></tr>';
                }
                $('#submittedFormTable').html(tableHeaders + r.join('')); 
            }
            
            //this function filters by form templates. 
            function filterByTitle(){
                var title = $('#titleSelect').val();
                
                var tempArr = [];
                
                for(var i=0;i<resourceList.length;i++){
                    console.log(title);
                    if(resourceList[i].name == title){
                        tempArr.push(resourceList[i]);
                    }
                }
               
                showSubmittedForms(tempArr);
                
            }
            
            //when this function is called, resourceList should already be populated
            function populateEditResourceModal(resourceID){ 
                resourceList.forEach(function(resource){
                    if(resource.id == resourceID){
                        $("#resourceLabel").text(resource.name);
                        $("#editid").val(resource.id);
                        $("#edit_name").val(resource.name);
                        $("#edit_description").val(resource.description);
                        $("#edit_category").val(resource.category);
                    }
                    
                });
                
            }
            
            //when this function is called, resourceList should already be populated
            function populateDeleteResourceModal(resourceID){ 
                resourceList.forEach(function(resource){
                    if(resource.id == resourceID){
                        $("#resourceDeleteLabel").text(resource.name);
                        $("#delete_name").text(resource.name);
                        $("#delete_id").val(resource.id);
                    }
                });
                
            }
            function filterReset(){
                showSubmittedForms(resourceList);
            }
        
            
        </script>


        <script>
            function loadValidate(){
                $('input[type=checkbox],input[type=radio],input[type=file]').uniform();

                $('select').chosen();

                $("#new_resource_validate").validate({
                    rules:{
                        name:{
                            required:true
                        },
                        description:{
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
                
                $("#edit_resource_validate").validate({
                    rules:{
                        name:{
                            required:true
                        },
                        description:{
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

        <%--Load up resources --%>
        <script>
            <c:if test="${manageResourceActionBean.resourceList.size()!=0}"> 
                <c:forEach items="${manageResourceActionBean.resourceList}" var="resource" varStatus="loop">
        
                    var resource = new Object();
                    resource.id = '${resource.id}';
                    resource.name = '${resource.name}';
                    resource.description = '${resource.description}';
                    resource.category = '${resource.category}';
                    resource.fileName = '${resource.fileName}';
                    resource.timeCreated = '${resource.timeCreated}';
                    resourceList.push(resource);
                </c:forEach>
            </c:if>
        </script>                        


    </head>

    <body onload="showSubmittedForms(resourceList)">
        <%@include file="include/mainnavigationbar.jsp"%>
        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>
                    <div class="page-header">
                        <h1> Online Forms <small>Manage forms</small></h1>
                    </div>

                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">View Form Templates</a></li>

                            <li><a href="#pane2" data-toggle="tab">Manage User Submitted Forms</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="pane1" class="tab-pane active">
                                <h4>Form Templates</h4>


                                <table class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Category</th>
                                            <th>Filename</th>
                                            <th>Last Updated</th>
                                            <th>Action</th>
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
                                            <td>
                                                <a href="#editResourceModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditResourceModal('${resource.id}')">Edit</a> 
                                                <a href="#deleteResourceModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteResourceModal('${resource.id}')">Delete</a>
                                            </td>
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

                                <a href="#createResourceModal" role='button' data-toggle='modal' class="btn btn-success">Upload New Form</a>

                            </div>

                            <div id="pane2" class="tab-pane">
                                <h4>User Submitted Forms</h4>

                                <script>
                                    <c:if test="${manageResourceActionBean.resourceList.size()!=0}"> 
                                        <c:forEach items="${manageResourceActionBean.resourceList}" var="resource" varStatus="loop">
                    
                                            var resource = new Object();
                                            resource.id = '${resource.id}';
                                            resource.name = '${resource.name}';
                                            resource.description = '${resource.description}';
                                            resource.category = '${resource.category}';
                                            resource.fileName = '${resource.fileName}';
                                            resource.timeCreated = '${resource.timeCreated}';
                                            resourceList.push(resource);
                                        </c:forEach>
                                    </c:if>
                                </script>     

                                <!--this needs to be changed to only populate from templates -->
                                <div class='userFilterBar float_r'>
                                    <h5 class="inlineblock"> Filter By: </h5>
                                    <div class="inlineblock filterOptions">
                                        <select id ="titleSelect" onChange="filterByTitle()">
                                            <option>-Select Form Title-</option>
                                            <c:forEach items="${manageResourceActionBean.resourceList}" var="resource" varStatus="loop">
                                                <option>${resource.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="inlineblock filterOptions"><button class="btn" onClick="filterReset()">View All</button></div>                          
                                </div>


                                <table id="submittedFormTable" class="table table-striped table-bordered table-condensed">

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

                            <hr>




                        </div>


                    </div><!-- /.tab-content -->
                </div><!-- /.tabbable -->  
            </div>
        </div>
    </div>

    <hr>

    <%@include file="include/footer.jsp"%>

    <!-- Create Resource Modal Form -->
    <div id="createResourceModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Upload Form Template</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageOnlineFormsActionBean" name="new_resource_validate" id="new_resource_validate">                 
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name:</label>
                    <div class="controls">
                        <stripes:text name="name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description:</label>
                    <div class="controls">
                        <stripes:text name="description" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Category:</label>
                    <div class="controls">

                        Select <stripes:select name="category" id="edit_category">
                            <stripes:options-collection collection="${manageResourceActionBean.uniqueCategories}" />        
                        </stripes:select>
                        <br>Or Create New <stripes:text name="category_new" />

                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">File:</label>
                    <div class="controls">
                        <stripes:file name="file"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="createResource" value="Add this Form" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>

    <!-- Edit Resource Modal Form -->
    <div id="editResourceModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Create a Resource</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageResourceActionBean" name="new_resource_validate" id="new_resource_validate">                 
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name:</label>
                    <div class="controls">
                        <stripes:text name="name" id="edit_name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description:</label>
                    <div class="controls">
                        <stripes:text name="description" id="edit_description" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Category:</label>
                    <div class="controls">
                        Select <stripes:select name="category" id="edit_category">
                            <stripes:options-collection collection="${manageResourceActionBean.uniqueCategories}" />        
                        </stripes:select>
                        <br>Or Create New <stripes:text name="category_new" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">File:</label>
                    <div class="controls">
                        <stripes:file name="file"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="createResource" value="Add this Resource" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>


    <!--Delete Resource Modal -->
    <div id="deleteResourceModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion of <span id="resourceDeleteLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteResourceBean" > 
                You are now deleting <span id="delete_name"></span>. Are you sure?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>

                <stripes:hidden id="delete_id" name="id"/>
                <input type="submit" name="deleteResource" value="Confirm Delete" class="btn btn-danger"/>
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
