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
<%@include file="/protectadmin.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Create New Facility Type | Admin</title>
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
            function loadTimePickers(){
                $('.timepicker').timepicker();   
                
                $('.timepicker').change( function(){
                    //loadTimepickerInput();
                });     
            }
           
          function getDateFromString(inputString){
              console.log(inputString);
                var mins = inputString.substring(3,5);
                var hour = inputString.substring(0,2);
                var d = new Date();
                var d1 = new Date(d.getFullYear(),d.getMonth(),d.getDay(),hour,mins,0,0);
                return d1.getTime();
            }
            
            //BRAINS & LOGIC
            
            //Init vars. they will be incremented as new slots are added
            var numMonSlots = 1;
            var numTueSlots = 1;
            var numWedSlots = 1;
            var numThuSlots = 1;
            var numFriSlots = 1;
            var numSatSlots = 1;
            var numSunSlots = 1;
            
            //Function for adding new slots. day is 1-7 where 1=monday
            function addSlotForDay(day){
                switch(day){
                    case 1:
                        //append new inputs and set appropriate ID on element
                        var c = $(".mondaySlot:first-of-type").clone();
                        $(c).attr("id","monday"+ (numMonSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-mon" + (numMonSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-monday" + (numMonSlots + 1));
                        $(c.children().children()[3]).attr("id","b-mon" + (numMonSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-monday" + (numMonSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('mon',"+ (numMonSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#mondaySlotHolder").append(c);
                        
                        attachChangeHandlers("mon",numMonSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("$('.timepicker').timepicker()",500);
                        
                        //increment counter
                        numMonSlots++;
                        
                        break;
                        
                    case 2:
                        break;
                }
            }
            
            function removeSlot(day,index){
                console.log("remove: "+ day + "day" + index);
                $("#" + day + "day" + index).remove();
            }
            
            function attachChangeHandlers(dayString,num){ //daystring like "mon", "thu", etc
                $("#a-"+ dayString + (num + 1)).change(function(){
                    $("#a-"+dayString+"day" + (num + 1)).val( getDateFromString($("#a-"+ dayString + (num + 1)).val()) ); 
                });
                console.log("#a-"+dayString + (num + 1) +", "+ "#a-"+dayString+"day" + (num + 1));
                $("#b-"+dayString + (num + 1)).change(function(){
                    $("#b-"+dayString+"day" + (num + 1)).val( getDateFromString($("#b-"+dayString + (num + 1)).val()) ); 
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
            
            
        function disableBookingLimitArea(){
            $("#bookingLimitArea").toggleClass("disabled");
            $("#enableBookingLimit").toggleClass("hide");
            
            //remove inputs if any
            if($("#bookingSessions").val()){
                $("#bookingSessions").val("");
            }
            if($("#bookingLimitFreq").val()){
                $("#bookingLimitFreq").val("");
            }
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
                        
                        <stripes:errors>
     <stripes:errors-header><div class="errorHeader">Validation Errors</div><ul></stripes:errors-header>
     <li><stripes:individual-error/></li>
     <stripes:errors-footer></ul></stripes:errors-footer>
</stripes:errors>
                        
                        <div class="control-group ${errorStyle}">
                                    <label class="control-label">Name</label>
                                    <div class="controls">
                                        <stripes:text name="name" class="input-xxlarge"/>
                                        <p class="field-validation-valid" data-valmsg-for="input1" data-valmsg-replace="true">
                </p>
                                    </div>
                         </div>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Description</label>
                                    <div class="controls">
                                        <stripes:textarea name="description" class="input-xxlarge"/>
                                   
                                    </div>
                         </div>
                                        
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Does Facility Require Payment?</label>
                                    <div class="controls">
                                        <stripes:checkbox name="needsPayment"/>
                                   
                                    </div>
                         </div>
                                        <label class="control-label">Facility Availability</label>
                                        <table class='timeSlotsTable'>
                                            <tr>
                                                <td class="day">Monday</td>
                                                <td>
                                                    <table id="mondaySlotHolder">
                                                        <tr class="mondaySlot"><td>
                                                            <input id="a-mon1" class="timepicker"/>
                                                            <input class="hide mondaySlotData" id="a-monday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-mon1" class="timepicker"/>
                                                            <input class="hide mondaySlotData" id="b-monday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('mon',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(1)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-mon1").change(function(){
                                                                $("#a-monday1").val( getDateFromString($("#a-mon1").val()) ); 
                                                            });
                                                            $("#b-mon1").change(function(){
                                                                $("#b-monday1").val( getDateFromString($("#b-mon1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                          
                                        </table>
                                    
                                        <br/><br/>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Limits</label>
                                    <div id="bookingLimitArea" class="float_l">
                                        <stripes:text class="span75" name="bookingSessions" id="bookingSessions"/> 
                                        time(s) per
                                        <stripes:text class="span75" name="bookingLimitFreq" id="bookingLimitFreq" />
                                        <stripes:select name="bookingLimitUnit" class="span75">
                                            <option value="d">Days</option>
                                            <option value="w">Weeks</option>
                                            <option value="m">Months</option>
                                        </stripes:select>                                            
                                        <a href="#blimit" id="disableBookingLimit" class="embeddedBtn" onclick="disableBookingLimitArea()">No Booking Limits</a>                               
                                    </div>
                               <a id="enableBookingLimit" href="#blimit" class="btn btn-info hide float_l" onclick="disableBookingLimitArea()">Enable Booking Limits</a>          
                         </div>            
                        
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Limitation on Booking in Advance</label>
                                    <div class="timepickerArea">
                                        <span>Booking Opens</span>
                                        <stripes:text class="span75" name="bookingOpenAdvance" id="bookingOpenAdvance"/> 
                                        <span>days in advance</span>
                                    </div> 
                                        
                                    <div class="timepickerArea">
                                        <span>Booking Closes</span>
                                        <stripes:text class="span75" name="bookingCloseAdvance" id="bookingCloseAdvance"/> 
                                        <span>days in advance</span>
                                    </div>     
                                        
                                
                         </div>  
                                            <input type="submit" name="editFacilityType" value="Create Facility" class="btn btn-large btn-primary timepickerArea"/>    
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
        
        <script>
            $(document).ready(function() { 
                
                    $("#new_facility_validate").validate({
                        rules: {
                          name: "required",
                          description: "required",
                          bookingSessions: {
                              digits:true
                          },
                          bookingLimitFreq: {
                              digits:true
                          },
                          bookingOpenAdvance: {
                              digits:true
                          },
                          bookingCloseAdvance: {
                              digits:true
                          }
                        },
                        messages :{
                            name: "Please enter a facility name",
                            description: "Please enter a description for the facility",
                            bookingSessions: "(only digits)",
                            bookingLimitFreq: "(only digits)",
                            bookingOpenAdvance: "(only digits)",
                            bookingCloseAdvance: "(only digits)"
                        },
                        
                        submitHandler: function(form) {
                            if(!timePickerHasError){
                                form.submit();
                            }
                            
                        }
                        
                });
                loadTimePickers();
                //validateTimePickerInput();
            });
            
            
            //RETURNS TRUE IF TIMEBEFORE is after TIMEAFTER
            //ALSO RETURNS TRUE IF ANY DATES CANNOT BE PARSED
            function isAfter(timeBefore,timeAfter){
                
                var dBefore = getDateFromString(timeBefore.val());
                var dAfter = getDateFromString(timeAfter.val());
                                
                if(isNaN(dBefore) || isNaN(dAfter)){
                    return true;
                }
                else {
                    if(dBefore >= dAfter){
                    return true;
                }
                    else{
                        return false;
                    }
                }
                
            }
        </script>
        
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/jquery.validate.bootstrap.js"></script>
        
  </body>
</html>
