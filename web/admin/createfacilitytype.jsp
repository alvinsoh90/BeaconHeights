<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageFacilityTypesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilityTypesActionBean"/>
<jsp:useBean id="approveUserBean" scope="page"
             class="com.lin.general.admin.ApproveUserBean"/>
<%@include file="/protect.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Users | Strass</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">
                    
    <script src="js/jquery.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/site.css" rel="stylesheet">
        <link href="css/jquery.ui.timepicker.css" rel="stylesheet">
        <link href="css/jquery-ui-1.8.14.custom.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
            <script src="js/jquery.ui.core.min.js"></script>
        <script src="js/jquery.ui.timepicker.js"></script>
        <script src="js/jquery.ui.position.min.js"></script>
        <script src="js/jquery.ui.tabs.min.js"></script>
        <script src="js/jquery.ui.widget.min.js"></script>
        <link href="css/linadmin.css" rel="stylesheet">
       
        <script>
            //Handle timepickers
            function loadTimepickerInput(){
                var date = getDateFromString($("#mon1").val());
            }
            
            function getDateFromString(inputString){
                var ampm = inputString.substring(6,8);
                var mins = inputString.substring(3,5);
                var hour = inputString.substring(0,2);
                
                var d = new Date();
                return new Date(d.getYear(), d.getMonth(), d.getDate(), hour, mins,0 ,0);
            }
            
        </script>
        <script>
            function loadTimePickers(){
                $('.timepicker').timepicker({
                    onSelect: loadTimepickerInput()
                });   
                
                $('.timepicker').change( function(){
                    loadTimepickerInput();
                });
                  
            }
        </script>
        
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script>
                <!-- Populates the Edit Facilities form -->
            // Init an array of all facilities shown on this page
            var facilityTypeList = [];
            
            function populateEditFacilityTypeModal(typeID){ 
                facilityTypeList.forEach(function(facilityType){
                    if(facilityType.id == typeID){
                        $("#facilityTypeLabel").text(facilityType.name);
                        $("#editid").val(facilityType.id);
                        $("#edit_name").val(facilityType.name);
                        $("#edit_description").val(facilityType.description);
                    }
                });
                
            }
            
            function populateDeleteFacilityTypeModal(typeID){ 
                facilityTypeList.forEach(function(facilityType){
                    if(facilityType.id == typeID){
                        $("#facilityTypeDeleteLabel").text(facilityType.name);
                        $("#delete_name").text(facilityType.name);
                        $("#delete_id").val(facilityType.id);
 
                    }
                });
                
            }
        </script>
 
    
  </head>
  <body onload="loadTimePickers()">
      
    <%@include file="include/mainnavigationbar.jsp"%>
    <div class="container-fluid">
       <%@include file="include/sidemenu.jsp"%>   
       
        <div class="span9">
		  <div class="row-fluid">
                        <!-- Info Messages -->
                    <%@include file="include/pageinfobar.jsp"%>
                    
                    <div class="page-header">
				<h1>Create Facility Type <small></small></h1>
			</div>
                    
                    <!-- Create FT form start -->
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageFacilityTypesActionBean" name="new_facility_validate" id="new_facility_validate">
                        
                        <div class="control-group ${errorStyle}">
                                    <label class="control-label">Name</label>
                                    <div class="controls">
                                        <stripes:text name="name" class="input-xxlarge"/>
                                    </div>
                         </div>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Description</label>
                                    <div class="controls">
                                        <stripes:textarea name="description" class="input-xxlarge"/>
                                    </div>
                         </div>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Facility Availability</label>
                                    <div class="timepickerArea">
                                        <span>Monday</span>
                                        <input id="mon1" class="timepicker"/>
                                        <stripes:hidden name="mondayOne" id="mondayOne" /> 
                                        <span>to</span>
                                        <input id="mon2" class="timepicker"/>
                                        <stripes:hidden name="mondayTwo" id="mondayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Tuesday</span>
                                        <input id="tue1" class="timepicker"/>
                                        <stripes:hidden name="tuesdayOne" id="tuesdayOne" /> 
                                        <span>to</span>
                                        <input id="tue2" class="timepicker"/>
                                        <stripes:hidden name="tuesdayTwo" id="tuesdayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Wednesday</span>
                                        <input id="wed1" class="timepicker"/>
                                        <stripes:hidden name="wedesdayOne" id="wedesdayOne" /> 
                                        <span>to</span>
                                        <input id="wed2" class="timepicker"/>
                                        <stripes:hidden name="wedesdayTwo" id="wedesdayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Thursday</span>
                                        <input id="thu1" class="timepicker"/>
                                        <stripes:hidden name="thursdayOne" id="thursdayOne" /> 
                                        <span>to</span>
                                        <input id="thu2" class="timepicker"/>
                                        <stripes:hidden name="thursdayTwo" id="thursdayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Friday</span>
                                        <input id="fri1" class="timepicker"/>
                                        <stripes:hidden name="fridayOne" id="fridayOne" /> 
                                        <span>to</span>
                                        <input id="fri2" class="timepicker"/>
                                        <stripes:hidden name="fridayTwo" id="fridayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Saturday</span>
                                        <input id="sat1" class="timepicker"/>
                                        <stripes:hidden name="saturdayOne" id="saturdayOne" /> 
                                        <span>to</span>
                                        <input id="sat2" class="timepicker"/>
                                        <stripes:hidden name="saturdayTwo" id="saturdayTwo" />
                                    </div>
                                    
                                    <div class="timepickerArea">
                                        <span>Sunday</span>
                                        <input id="sun1" class="timepicker"/>
                                        <stripes:hidden name="sundayOne" id="sundayOne" /> 
                                        <span>to</span>
                                        <input id="sun2" class="timepicker"/>
                                        <stripes:hidden name="sundayTwo" id="sundayTwo" />
                                    </div> 
                         </div>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Limits</label>
                                    <div class="timepickerArea">
                                        <input id="booking-limit-days" class="span75"/>
                                        <stripes:hidden name="bookingLimitDays" id="bookingLimitDays"/> 
                                        time(s) per
                                        <input id="booking-limit-freq" class="span75"/>
                                        <stripes:hidden name="bookingLimitFreq" id="bookingLimitFreq" />
                                        <stripes:select name="bookingLimitUnit" class="span75">
                                            <option value="days">Days</option>
                                            <option value="weeks">Weeks</option>
                                            <option value="months">Months</option>
                                        </stripes:select>
                                    </div> 
                         </div>           
                        
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Limitation on Booking in Advance</label>
                                    <div class="timepickerArea">
                                        <span>Booking Opens</span>
                                        <input id="booking-open-advance" class="span75"/>
                                        <stripes:hidden name="bookingOpenAdvance" id="bookingOpenAdvance"/> 
                                        <span>days in advance</span>
                                    </div> 
                                        
                                    <div class="timepickerArea">
                                        <span>Booking Closes</span>
                                        <input id="booking-open-advance" class="span75"/>
                                        <stripes:hidden name="bookingOpenAdvance" id="bookingOpenAdvance"/> 
                                        <span>days in advance</span>
                                    </div>     
                         </div>                                                        
                    </stripes:form>
            
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
        
  </body>
</html>
