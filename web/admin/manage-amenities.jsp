
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
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script>
            <!-- Populates the Edit Facilities form -->
            // Init an array of all facilities shown on this page
            var amenityList = [];
            
            function populateEditAmenityModal(aID){ 
                amenityList.forEach(function(amenity){
                    if(amenity.id == aID){
                        $("#amenityEditLabel").text(amenity.name);
                        $("#edit_name").val(amenity.name);
                        $("#edit_id").val(amenity.id);
                        $("#edit_description").val(amenity.description);
                        $("#edit_unitNo").val(amenity.unitNo);
                        $("#edit_streetName").val(amenity.streetName);
                        $("#edit_postalCode").val(amenity.postalCode);
                        $("#edit_contactNo").val(amenity.contactNo);
                        $("#edit_lat").val(amenity.lat);
                        $("#edit_lng").val(amenity.lng);
                        $("#edit_category").val(amenity.category);
                    }
                });
                
            }
            
            function populateDeleteAmenityModal(aID){ 
                amenityList.forEach(function(amenity){
                    if(amenity.id == aID){
                        $("#amenityDeleteLabel").text(amenity.name);
                        $("#delete_name").text(amenity.name);
                        $("#delete_id").val(amenity.id);
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


                    <!-- Edit Amenity Modal Form -->
                    <div id="editAmenityModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Editing <span id="amenityEditLabel"></span>
                        </div>
                        <div class="modal-body">
                            <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean" focus="">
                                <stripes:hidden id="edit_id" name="id"/> 
                                <div class="control-group ${errorStyle}">
                                    <label class="control-label">Amenity Name</label>
                                    <div class="controls">
                                        <stripes:text id="edit_name" name="name"/> 
                                    </div>
                                </div>  
                            
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Description</label>
                                <div class="controls">
                                    <stripes:text id="edit_description" name="description"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Unit No</label>
                                <div class="controls">
                                    <stripes:text id="edit_unitNo" name="unitNo"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Street Name</label>
                                <div class="controls">
                                    <stripes:text id="edit_streetName" name="streetName"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Postal Code</label>
                                <div class="controls">
                                    <stripes:text id="edit_postalCode" name="postalCode"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Contact No</label>
                                <div class="controls">
                                    <stripes:text id="edit_contactNo" name="contactNo"/>
                                </div>
                            </div>
                                <div class="control-group ${errorStyle}">
                                <label class="control-label">Latitude</label>
                                <div class="controls">
                                    <stripes:text id="edit_lat" name="lat"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Longitude</label>
                                <div class="controls">
                                    <stripes:text id="edit_lng" name="lng"/>
                                </div>
                            </div>
                            <div class="control-group ${errorStyle}">
                                <label class="control-label">Category</label>
                                <div class="controls">
                                    <stripes:text id="edit_category" name="category"/>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>
                                <input type="submit" name="editAmenity" value="Confirm Edit" class="btn btn-primary"/>
                            </div>
                        </stripes:form>
                    </div>
                </div>
                    <!--Delete Amenity Modal Form -->
                    <div id="deleteAmenityModal" class="modal hide fade">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                            <h3>Deletion of <span id="amenityDeleteLabel"></span></h3>
                        </div>
                        <div class="modal-body">
                            <stripes:form  class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean"> 
                                You are now deleting <span id="delete_name"></span>. Are you sure?
                            </div>
                            <div class="modal-footer">
                                <a data-dismiss="modal" class="btn">Close</a>

                                <stripes:hidden id="delete_id" name="id"/>
                                <stripes:hidden id="delete_name" name="name"/>
                                <input type="submit" name="deleteAmenity" value="Confirm Delete" class="btn btn-danger"/>
                            </div>
                        </stripes:form>
                    </div>    

                    <div class="page-header">
                        <h1>Amenities<small>Manage amenities</small></h1>
                    </div>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Unit No</th>
                                <th>Street Name</th>
                                <th>Postal Code</th>
                                <th>Contact No</th>
                                <th>lat</th>
                                <th>lng</th>
                                <th>Category</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${manageAmenityBean.amenityList}" var="amenity" varStatus="loop">
                            <script>
                                var amenity = new Object();
                                amenity.id = "${amenity.id}";
                                amenity.name = "${amenity.name}";  
                                amenity.description = "${amenity.description}";
                                amenity.unitNo = "${amenity.unitNo}";
                                amenity.streetName = "${amenity.streetName}";
                                amenity.postalCode = "${amenity.postalCode}";
                                amenity.contactNo = "${amenity.contactNo}";
                                amenity.lat = "${amenity.lat}"; 
                                amenity.lng = "${amenity.lng}";
                                amenity.category = "${amenity.category}"; 
                                amenityList.push(amenity);
                            </script>
                            <tr>

                                <td><b>${amenity.id}</b></td>
                                <td><b>${amenity.name}</b></td>
                                <td><b>${amenity.description}</b></td>
                                <td><b>${amenity.unitNo}</b></td>
                                <td><b>${amenity.streetName}</b></td>
                                <td><b>${amenity.postalCode}</b></td>
                                <td><b>${amenity.contactNo}</b></td>
                                <td><b>${amenity.lat}</b></td>
                                <td><b>${amenity.lng}</b></td>
                                <td><b>${amenity.category}</b></td>

                                <td nowrap>
                                    <a href="#editAmenityModal" role="button" data-toggle="modal"class="btn btn-primary btn-mini" onclick="populateEditAmenityModal('${amenity.id}')">Edit</a> 
                                    <a href="#deleteAmenityModal" role="button" data-toggle="modal" class="btn btn-danger btn-mini" onclick="populateDeleteAmenityModal('${amenity.id}')">Delete</a>
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
                    <a href="#createAmenityModal" role="button" data-toggle="modal" class="btn btn-success">Create New Amenity</a>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

        <!-- Create new facility type modal -->
        <div id="createAmenityModal" class="modal hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                <h3>Create New Amenity</h3>
            </div>
            <div class="modal-body">
                <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageAmenityBean" name="new_amenity_validate" id="new_amenity_validate">
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Name</label>
                        <div class="controls">
                            <stripes:text name="name"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Description</label>
                        <div class="controls">
                            <stripes:text name="description"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Unit No</label>
                        <div class="controls">
                            <stripes:text name="unitNo"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Street Name</label>
                        <div class="controls">
                            <stripes:text name="streetName"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Postal Code</label>
                        <div class="controls">
                            <stripes:text name="postalCode"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Contact No</label>
                        <div class="controls">
                            <stripes:text name="contactNo"/>
                        </div>
                    </div>
                        <div class="control-group ${errorStyle}">
                        <label class="control-label">Latitude</label>
                        <div class="controls">
                            <stripes:text name="lat"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Longitude</label>
                        <div class="controls">
                            <stripes:text name="lng"/>
                        </div>
                    </div>
                    <div class="control-group ${errorStyle}">
                        <label class="control-label">Category</label>
                        <div class="controls">
                            <stripes:text name="category"/>
                        </div>
                    </div>

                </div>
                <div class="form-actions">
                    <input type="submit" name="addAmenity" value="Add This Amenity" class="btn btn-info btn-large"/>
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
