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
                $('.timepicker').change( function(){retrieveOverallJSONSlotData()});     
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
            var numTuesSlots = 1;
            var numWednesSlots = 1;
            var numThursSlots = 1;
            var numFriSlots = 1;
            var numSaturSlots = 1;
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
                        $(c.children()[1]).find(".embeddedBtn.hide").attr("class","embeddedBtn");
                        
                        $("#mondaySlotHolder").append(c);
                        
                        attachChangeHandlers("mon",numMonSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numMonSlots++;
                        
                        break;
                        
                    case 2:
                        //append new inputs and set appropriate ID on element
                        var c = $(".tuesdaySlot:first-of-type").clone();
                        $(c).attr("id","tuesday"+ (numTuesSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-tues" + (numTuesSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-tuesday" + (numTuesSlots + 1));
                        $(c.children().children()[3]).attr("id","b-tues" + (numTuesSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-tuesday" + (numTuesSlots + 1));
                        var val = numTuesSlots + 1;
                        console.log(val);
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('tues',"+ val +")");
                        $(c.children()[1]).find(".embeddedBtn.hide").attr("class","embeddedBtn");
                        
                        $("#tuesdaySlotHolder").append(c);
                        
                        attachChangeHandlers("tues",numTuesSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numTuesSlots++;
                        break;
                        
                    case 3:
                        //append new inputs and set appropriate ID on element
                        var c = $(".wednesdaySlot:first-of-type").clone();
                        $(c).attr("id","wednesday"+ (numWednesSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-wednes" + (numWednesSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-wednesday" + (numWednesSlots + 1));
                        $(c.children().children()[3]).attr("id","b-wednes" + (numWednesSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-wednesday" + (numWednesSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('wednes',"+ (numWednesSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#wednesdaySlotHolder").append(c);
                        
                        attachChangeHandlers("wednes",numWednesSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numWednesSlots++;
                        break;
                    
                    case 4:
                        //append new inputs and set appropriate ID on element
                        var c = $(".thursdaySlot:first-of-type").clone();
                        $(c).attr("id","thursday"+ (numThursSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-thurs" + (numThursSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-thursday" + (numThursSlots + 1));
                        $(c.children().children()[3]).attr("id","b-thurs" + (numThursSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-thursday" + (numThursSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('thurs',"+ (numThursSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#thursdaySlotHolder").append(c);
                        
                        attachChangeHandlers("thurs",numThursSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numThursSlots++;
                        break;
                        
                    case 5:
                        //append new inputs and set appropriate ID on element
                        var c = $(".fridaySlot:first-of-type").clone();
                        $(c).attr("id","friday"+ (numFriSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-fri" + (numFriSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-friday" + (numFriSlots + 1));
                        $(c.children().children()[3]).attr("id","b-fri" + (numFriSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-friday" + (numFriSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('fri',"+ (numFriSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#fridaySlotHolder").append(c);
                        
                        attachChangeHandlers("fri",numFriSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numFriSlots++;
                        break;
                    case 6:
                        //append new inputs and set appropriate ID on element
                        var c = $(".saturdaySlot:first-of-type").clone();
                        $(c).attr("id","saturday"+ (numSaturSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-satur" + (numSaturSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-saturday" + (numSaturSlots + 1));
                        $(c.children().children()[3]).attr("id","b-satur" + (numSaturSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-saturday" + (numSaturSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('satur',"+ (numSaturSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#saturdaySlotHolder").append(c);
                        
                        attachChangeHandlers("satur",numSaturSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numSaturSlots++;
                        break;
                     case 7:
                         //append new inputs and set appropriate ID on element
                        var c = $(".sundaySlot:first-of-type").clone();
                        $(c).attr("id","sunday"+ (numSunSlots + 1));
                        //change children elements
                        $(c.children().children()[0]).attr("id","a-sun" + (numSunSlots + 1));
                        $(c.children().children()[0]).attr("class","timepicker");
                        $(c.children().children()[1]).attr("id","a-sunday" + (numSunSlots + 1));
                        $(c.children().children()[3]).attr("id","b-sun" + (numSunSlots + 1));
                        $(c.children().children()[3]).attr("class","timepicker");
                        $(c.children().children()[4]).attr("id","b-sunday" + (numSunSlots + 1));
                        $(c.children()[1]).find(".embeddedBtn.delBtn").attr("onclick","removeSlot('sun',"+ (numSunSlots + 1) +")");
                        $(c.children()[1]).find(".embeddedBtn").attr("class","embeddedBtn");
                        
                        $("#sundaySlotHolder").append(c);
                        
                        attachChangeHandlers("sun",numSunSlots);
                        
                        //refresh timepicker plugin
                        setTimeout("loadTimePickers()",500);
                        
                        //increment counter
                        numSunSlots++;
                        
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
            
            //this object is updated everytime user changes the date picker
            var slotDataJSON = new Object();
             //will be true if validation finds error ie timeAfter is timeBefore
            var slotDataHasError = false;
            
            function retrieveOverallJSONSlotData(){
                slotDataJSON.mondaySlots = getJSONSlotDataForDay(1);
                slotDataJSON.tuesdaySlots = getJSONSlotDataForDay(2);
                slotDataJSON.wednesdaySlots = getJSONSlotDataForDay(3);
                slotDataJSON.thursdaySlots = getJSONSlotDataForDay(4);
                slotDataJSON.fridaySlots = getJSONSlotDataForDay(5);
                slotDataJSON.saturdaySlots = getJSONSlotDataForDay(6);
                slotDataJSON.sundaySlots = getJSONSlotDataForDay(7);
                
                //return slotDataJSON;
            }
            
            function getJSONSlotDataForDay(day){
                var data = [];

                switch(day){
                    case 1:                        
                        $("#mondaySlotHolder .mondaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                            
                        });                        
                    break;
                    case 2:                        
                        $("#tuesdaySlotHolder .tuesdaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                    case 3:                        
                        $("#wednesdaySlotHolder .wednesdaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                    case 4:                        
                        $("#thursdaySlotHolder .thursdaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                    case 5:                        
                        $("#fridaySlotHolder .fridaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                    case 6:                        
                        $("#saturdaySlotHolder .saturdaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                    case 7:                        
                        $("#sundaySlotHolder .sundaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                            }
                        });                        
                    break;
                }
                return data;
            }
            
            function copyFirstRow(){
                $(".slotRow .startTime").val( $(".firstStart").val() );
                $(".slotRow .endTime").val( $(".firstEnd").val() );
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
                                        <label class="control-label">Facility Availability<br/>
                                        <a href="#copy" onclick="copyFirstRow()">Copy first row down</a></label>
                                        
                                        <table class='timeSlotsTable' cellpadding="7">
                                            <tr>
                                                <td class="day">Monday</td>
                                                <td>
                                                    <table id="mondaySlotHolder">
                                                        <tr class="mondaySlot slotRow"><td>
                                                            <input id="a-mon1" class="timepicker startTime firstStart"/>
                                                            <input class="hide mondaySlotData start" id="a-monday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-mon1" class="timepicker endTime firstEnd"/>
                                                            <input class="hide mondaySlotData end" id="b-monday1" />
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
                                            
                                            <tr>
                                                <td class="day">Tuesday</td>
                                                <td>
                                                    <table id="tuesdaySlotHolder">
                                                        <tr class="tuesdaySlot slotRow"><td>
                                                            <input id="a-tues1" class="timepicker startTime"/>
                                                            <input class="hide tuesdaySlotData start" id="a-tuesday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-tues1" class="timepicker endTime"/>
                                                            <input class="hide tuesdaySlotData end" id="b-tuesday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('tues',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(2)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-tues1").change(function(){
                                                                $("#a-tuesday1").val( getDateFromString($("#a-tues1").val()) ); 
                                                            });
                                                            $("#b-tues1").change(function(){
                                                                $("#b-tuesday1").val( getDateFromString($("#b-tues1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Wednesday</td>
                                                <td>
                                                    <table id="wednesdaySlotHolder">
                                                        <tr class="wednesdaySlot slotRow"><td>
                                                            <input id="a-wednes1" class="timepicker startTime"/>
                                                            <input class="hide wednesdaySlotData start" id="a-wednesday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-wednes1" class="timepicker endTime"/>
                                                            <input class="hide wednesdaySlotData end" id="b-wednesday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('wednes',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(3)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-wednes1").change(function(){
                                                                $("#a-wednesday1").val( getDateFromString($("#a-wednes1").val()) ); 
                                                            });
                                                            $("#b-wednes1").change(function(){
                                                                $("#b-wednesday1").val( getDateFromString($("#b-wednes1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Thursday</td>
                                                <td>
                                                    <table id="thursdaySlotHolder">
                                                        <tr class="thursdaySlot slotRow"><td>
                                                            <input id="a-thurs1" class="timepicker startTime"/>
                                                            <input class="hide thursdaySlotData start" id="a-thursday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-thurs1" class="timepicker endTime"/>
                                                            <input class="hide thursdaySlotData end" id="b-thursday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('thurs',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(4)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-thurs1").change(function(){
                                                                $("#a-thursday1").val( getDateFromString($("#a-thurs1").val()) ); 
                                                            });
                                                            $("#b-thurs1").change(function(){
                                                                $("#b-thursday1").val( getDateFromString($("#b-thurs1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Friday</td>
                                                <td>
                                                    <table id="fridaySlotHolder">
                                                        <tr class="fridaySlot slotRow"><td>
                                                            <input id="a-fri1" class="timepicker startTime"/>
                                                            <input class="hide fridaySlotData start" id="a-friday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-fri1" class="timepicker endTime"/>
                                                            <input class="hide fridaySlotData end" id="b-friday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('fri',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(5)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-fri1").change(function(){
                                                                $("#a-friday1").val( getDateFromString($("#a-fri1").val()) ); 
                                                            });
                                                            $("#b-fri1").change(function(){
                                                                $("#b-friday1").val( getDateFromString($("#b-fri1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>  
                                            
                                            <tr>
                                                <td class="day">Saturday</td>
                                                <td>
                                                    <table id="saturdaySlotHolder">
                                                        <tr class="saturdaySlot slotRow"><td>
                                                            <input id="a-satur1" class="timepicker startTime"/>
                                                            <input class="hide saturdaySlotData start" id="a-saturday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-satur1" class="timepicker endTime"/>
                                                            <input class="hide saturdaySlotData end" id="b-saturday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('satur',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(6)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-satur1").change(function(){
                                                                $("#a-saturday1").val( getDateFromString($("#a-satur1").val()) ); 
                                                            });
                                                            $("#b-satur1").change(function(){
                                                                $("#b-saturday1").val( getDateFromString($("#b-satur1").val()) ); 
                                                            });
                                                        </script>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>   
                                            
                                            <tr>
                                                <td class="day">Sunday</td>
                                                <td>
                                                    <table id="sundaySlotHolder">
                                                        <tr class="sundaySlot slotRow"><td>
                                                            <input id="a-sun1" class="timepicker startTime"/>
                                                            <input class="hide sundaySlotData start" id="a-sunday1" /> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-sun1" class="timepicker endTime"/>
                                                            <input class="hide sundaySlotData end" id="b-sunday1" />
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn hide" 
                                                               onclick="removeSlot('sun',1)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(1)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-sun1").change(function(){
                                                                $("#a-sunday1").val( getDateFromString($("#a-sun1").val()) ); 
                                                            });
                                                            $("#b-sun1").change(function(){
                                                                $("#b-sunday1").val( getDateFromString($("#b-sun1").val()) ); 
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
            
            
            //RETURNS TRUE IF timeBefore is after timeAfter
            //ALSO RETURNS TRUE IF ANY DATES CANNOT BE PARSED
            function isAfter(timeBefore,timeAfter){
                var dBefore = new Date(parseInt(timeBefore));
                var dAfter = new Date(parseInt(timeAfter));                
                return dBefore >= dAfter;                  
            }
        </script>
        
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/jquery.validate.bootstrap.js"></script>
        
  </body>
</html>
