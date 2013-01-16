<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.*"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<jsp:useBean id="manageResourceCategoriesActionBean" scope="page"
             class="com.lin.general.admin.ManageResourceCategoriesActionBean"/>
<jsp:useBean id="editResourceCategoryBean" scope="page"
             class="com.lin.general.admin.EditResourceCategoryBean"/>
<jsp:useBean id="deleteResourceCategoryBean" scope="page"
             class="com.lin.general.admin.DeleteResourceCategoryBean"/>

<%@include file="/protectadmin.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>Admin | Online Forms </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/linadmin.css" rel="stylesheet">

        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/custom/lin.css" />


        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="/js/jquery.validate.js"></script>
        <script src="/js/custom/lin.register.js"></script>

        <!-- Add white space above -->
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

    </head>

    <body>
        <%@include file="include/mainnavigationbar.jsp"%>

        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <div class="page-header">
                        <h1> Online Forms <small>Manage forms</small></h1>
                    </div>

                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#pane1" data-toggle="tab">View Forms</a></li>
                            <li><a href="#pane2" data-toggle="tab">Upload Form</a></li>
                            <li><a href="#pane3" data-toggle="tab">Submitted Forms</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="pane1" class="tab-pane active">
                                <h4>Form Templates</h4>

                                <table class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${manageResourceCategoriesActionBean.resourceCategoryList}" var="resourceCategory" varStatus="loop">
                                        <script>
                                            var resourceCategory = new Object();
                                            resourceCategory.id = '${resourceCategory.id}';
                                            resourceCategory.name = '${resourceCategory.name}';
                                            resourceCategory.description = '${resourceCategory.description}';
                                            resourceCategoryList.push(resourceCategory);
                                        </script>
                                        <tr>

                                            <td><b>${resourceCategory.id}</b></td>
                                            <td><b>${resourceCategory.name}</b></td>
                                            <td><b>${resourceCategory.description}</b></td>
                                            <td>
                                                <a href='#downloadResourceCategoryModal' role='button' data-toggle='modal' class='btn btn-success btn-mini' onclick='populateDownloadFormModal('${resourceCategory.id}')'>Download</a>
                                                <a href="#editResourceCategoryModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditResourceCategoryModal('${resourceCategory.id}')">Edit</a> 
                                                <a href="#deleteResourceCategoryModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteResourceCategoryModal('${resourceCategory.id}')">Delete</a>
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



                            </div>
                            <div id="pane2" class="tab-pane">



                                <div class="span9">
                                    <div class="row-fluid">
                                        <!-- Info Messages -->
                                        <%@include file="include/pageinfobar.jsp"%>

                                        <div class="page-header">
                                            <h3>Upload Form<small></small></h3>
                                        </div>

                                        <!-- Create FT form start -->
                                        <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.UploadBean" name="upload" id="new_facility_validate">

                                            <stripes:errors>
                                                <stripes:errors-header><div class="errorHeader">Validation Errors</div><ul></stripes:errors-header>
                                                    <li><stripes:individual-error/></li>
                                                    <stripes:errors-footer></ul></stripes:errors-footer>
                                                </stripes:errors>

                                            <div class="control-group ${errorStyle}">
                                                <label class="control-label">File : </label>
                                                <div class="controls">
                                                    <stripes:file name="newAttachment"/>
                                                    <p class="field-validation-valid" data-valmsg-for="input1" data-valmsg-replace="true">
                                                    </p>
                                                    <a href="/pdf_uploads/MOHAN SHAMUS MING.jpg">download image</a><br>
                                                    <a href="/pdf_uploads/Ethics Notes.docx">download word doc</a><br>
                                                    <a href="/pdf_uploads/Internship Poster - Shamus Ming Mohan shamusm.m.pdf">download pdf</a>
                                                </div>

                                            </div>   
                                            <input type="submit" name="UPLOAD" value="Upload File" class="btn btn-large btn-primary timepickerArea"/>
                                        </stripes:form>

                                    </div>
                                </div>

                            </div>
                            <div id="pane3" class="tab-pane">
                                <h4>User Submitted Forms</h4>
                                <table class="table table-striped table-bordered table-condensed">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${manageResourceCategoriesActionBean.resourceCategoryList}" var="resourceCategory" varStatus="loop">
                                        <script>
                                            var resourceCategory = new Object();
                                            resourceCategory.id = '${resourceCategory.id}';
                                            resourceCategory.name = '${resourceCategory.name}';
                                            resourceCategory.description = '${resourceCategory.description}';
                                            resourceCategoryList.push(resourceCategory);
                                        </script>
                                        <tr>

                                            <td><b>${resourceCategory.id}</b></td>
                                            <td><b>${resourceCategory.name}</b></td>
                                            <td><b>${resourceCategory.description}</b></td>
                                            <td>
                                                <a href='#downloadResourceCategoryModal' role='button' data-toggle='modal' class='btn btn-success btn-mini' onclick='populateDownloadFormModal('${resourceCategory.id}')'>Download</a>
                                                <a href="#editResourceCategoryModal" role="button" data-toggle="modal" class="btn btn-primary btn-mini" onclick="populateEditResourceCategoryModal('${resourceCategory.id}')">Edit</a> 
                                                <a href="#deleteResourceCategoryModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteResourceCategoryModal('${resourceCategory.id}')">Delete</a>
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
    <!-- Create Resource Category Modal Form -->
    <div id="createResourceCategoryModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Create a Resource Category</h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageResourceCategoriesActionBean" name="new_resourcecategory_validate" id="new_resourcecategory_validate">                 
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name</label>
                    <div class="controls">
                        <stripes:text name="name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description</label>
                    <div class="controls">
                        <stripes:text name="description" />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" name="createResourceCategory" value="Add this Resource Category" class="btn btn-info btn-large"/>                                                           
                </stripes:form>
            </div>
        </div>      
    </div>

    <!-- Edit Resource Category Modal Form -->
    <div id="editResourceCategoryModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Edit <span id="resourceCategoryLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.EditResourceCategoryBean" id="edit_resourcecategory_validate" name="edit_resourcecategory_validate">
                <stripes:text class="hide" name="id" id="editid" />
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Name</label>
                    <div class="controls">
                        <stripes:text id="edit_name" name="name" />
                    </div>
                </div>
                <div class="control-group ${errorStyle}">
                    <label class="control-label">Description</label>
                    <div class="controls">
                        <stripes:text id="edit_description" name="description" />
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>
                <stripes:hidden id="editid" name="id"/>
                <input type="submit" name="editResourceCategory" value="Confirm Edit" class="btn btn-primary"/>
            </div>
        </stripes:form>
    </div>


    <!--Delete Resource Category Modal -->
    <div id="deleteResourceCategoryModal" class="modal hide fade">
        <div id="myModal" class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <h3>Deletion of <span id="resourceCategoryDeleteLabel"></span></h3>
        </div>
        <div class="modal-body">
            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.DeleteResourceCategoryBean" > 
                You are now deleting <span id="delete_name"></span>. Are you sure?
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" class="btn">Close</a>

                <stripes:hidden id="delete_id" name="id"/>
                <input type="submit" name="deleteResourceCategory" value="Confirm Delete" class="btn btn-danger"/>
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
