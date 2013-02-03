
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/protectadmin.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin | Manage Amenity Categories</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">
        <jsp:useBean id="manageAmenityBean" scope="page"
                     class="com.lin.general.admin.ManageAmenityBean"/>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">
        
        <link href="/datatables/media/css/jquery.dataTables_themeroller.css" rel="stylesheet">
        <script src="js/jquery.js"></script>        
        <script type="text/javascript" charset="utf-8" src="/datatables/media/js/jquery.dataTables.js"></script>
        
        
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
            });
            
            <!-- Populates the Edit Facilities form -->
            // Init an array of all facilities shown on this page
            var amenityCategoryList = [];
            
            function populateEditAmenityCategoryModal(catID){ 
                amenityCategoryList.forEach(function(amenityCategory){
                    if(amenityCategory.id == catID){
                        $("#amenityCategoryEditLabel").text(amenityCategory.name);
                        $("#edit_name").val(amenityCategory.name);
                        $("#edit_id").val(amenityCategory.id);
                    }
                });
                
            }
            
            function populateDeleteAmenityCategoryModal(catID){ 
                amenityCategoryList.forEach(function(amenityCategory){
                    if(amenityCategory.id == catID){
                        $("#amenityCategoryDeleteLabel").text(amenityCategory.name);
                        $("#delete_name").text(amenityCategory.name);
                        $("#delete_id").val(amenityCategory.id);
                    }
                }); 
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


                    <!-- Edit Amenity Category Modal Form -->
                    <div id="editAmenityCategoryModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Edit <span id="amenityCategoryEditLabel"></span>
                        </div>
                        <div class="modal-body">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean" focus="">
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">ID</label>
                                    <div class="controls">
                                        <stripes:text id="edit_id" name="id"/> 
                                    </div>
                                </div>   
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Category Name</label>
                                    <div class="controls">
                                        <stripes:text id="edit_name" name="name"/> 
                                    </div>
                                </div>  
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>
                                <input type="submit" name="editAmenityCategory" value="Confirm Edit" class="btn btn-primary"/>
                            </div>
                        </stripes:form>
                    </div>

                    <!--Delete Amenity Category Modal Form -->
                    <div id="deleteAmenityCategoryModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Deletion of <span id="amenityCategoryDeleteLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean"> 
                                You are now deleting <span id="delete_name"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="delete_id" name="id"/>
                                <stripes:hidden id="delete_name" name="name"/>
                                <input type="submit" name="deleteAmenityCategory" value="Confirm Delete" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>    

                    <div class="page-header">
                        <h1>Amenity Categories <small>Manage categories of amenities</small></h1>
                    </div>
                    <table id ="table_id" class ="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Category Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageAmenityBean.categoryList}" var="amenityCategory" varStatus="loop">
                            <script>
                                var amenityCategory = new Object();
                                amenityCategory.id = "${amenityCategory.id}";
                                amenityCategory.name = "${amenityCategory.name}";    
                                amenityCategoryList.push(amenityCategory);
                            </script>
                            <tr>

                                <td>${amenityCategory.id}</td>
                                <td>${amenityCategory.name}</td>

                                <td nowrap>
                                    <a href="#editAmenityCategoryModal" role="button" data-toggle="modal"class="btn btn-primary btn-mini" onclick="populateEditAmenityCategoryModal('${amenityCategory.id}')">Edit</a> 
                                    <a href="#deleteAmenityCategoryModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteAmenityCategoryModal('${amenityCategory.id}')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    
                    <a href="#createAmenityCategoryModal" role="button" data-toggle="modal" class="btn btn-success">Create New Category</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Create new facility type modal -->
        <div id="createAmenityCategoryModal" class="modal hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Create New Amenity Category</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean" name="new_facility_validate" id="new_facility_validate">
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Name</label>
                        <div class="controls">
                            <stripes:text name="name"/>
                        </div>
                    </div>

                </div>



                <div class="form-actions">
                    <input type="submit" name="addAmenityCategory" value="Add this category" class="btn btn-info btn-large"/>
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

    </body>
</html>
