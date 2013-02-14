<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.dao.RuleDAO"%>
<%@page import="org.hibernate.Hibernate"%>
<%@page import="java.util.Set"%>
<%@page import="com.lin.entities.AdvanceRule"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="com.lin.entities.LimitRule"%>
<%@page import="com.lin.entities.FacilityType"%>
<%@page import="com.lin.dao.FacilityTypeDAO"%>
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
    <title>Edit Facility Type | LivingNet Admin</title>
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
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        
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
                
                retrieveOverallJSONSlotData(); //refresh model
                
                return d1.getTime();
            }
            
            //BRAINS & LOGIC
            
            //Init vars. they will be incremented as new slots are added
                var numMonSlots = $(".mondaySlot").length;
                var numTuesSlots = $(".tuesdaySlot").length;
                var numWednesSlots = $(".wednesdaySlot").length;
                var numThursSlots = $(".thursdaySlot").length;
                var numFriSlots = $(".fridaySlot").length;
                var numSaturSlots = $(".saturdaySlot").length;
                var numSunSlots = $(".sundaySlot").length;
            
            $(document).ready(function() {
                //Init vars. they will be incremented as new slots are added
                 numMonSlots = $(".mondaySlot").length;
                 numTuesSlots = $(".tuesdaySlot").length;
                 numWednesSlots = $(".wednesdaySlot").length;
                 numThursSlots = $(".thursdaySlot").length;
                 numFriSlots = $(".fridaySlot").length;
                 numSaturSlots = $(".saturdaySlot").length;
                 numSunSlots = $(".sundaySlot").length;
                 
                 retrieveOverallJSONSlotData();
            });
            
            
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
                
                retrieveOverallJSONSlotData(); //refresh data
            }
            
            function attachChangeHandlers(dayString,num){ //daystring like "mon", "thu", etc
                $("#a-"+ dayString + (num + 1)).change(function(){
                    $("#a-"+dayString+"day" + (num + 1)).val( getDateFromString($("#a-"+ dayString + (num + 1)).val()) ); 
                });
                console.log("#a-"+dayString + (num + 1) +", "+ "#a-"+dayString+"day" + (num + 1));
                $("#b-"+dayString + (num + 1)).change(function(){
                    $("#b-"+dayString+"day" + (num + 1)).val( getDateFromString($("#b-"+dayString + (num + 1)).val()) ); 
                });
                
                $("#btnCopyFirstRow").click(function(){
                    $("#a-"+dayString+"day" + (num + 1)).val( getDateFromString($("#a-"+ dayString + (num + 1)).val()) );
                    $("#b-"+dayString+"day" + (num + 1)).val( getDateFromString($("#b-"+dayString + (num + 1)).val()) );
                });
            }
            
            //this object is updated everytime user changes the date picker
            var slotDataJSON = [];
             //will be true if validation finds error ie timeAfter is timeBefore
            var slotDataHasError = false;
            
            function retrieveOverallJSONSlotData(){
                slotDataJSON = getJSONSlotDataForDay(1); //clear anything previously
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(2));
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(3));
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(4));
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(5));
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(6));
                slotDataJSON = slotDataJSON.concat(getJSONSlotDataForDay(7));                               
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
                            slot.dayIndex = 1;
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
                            console.log("s:" + slot.start + ", e:"+slot.end);
                            slot.dayIndex = 2;
                            if(isAfter(slot.start,slot.end)){ //will return true if wrong
                                $(this).addClass("error");
                                slotDataHasError = true;
                            }else{
                                $(this).removeClass("error");
                                //only add data if no error
                                data.push(slot);
                                console.log("pushed tue: " + JSON.stringify(slot));
                            }
                        });                        
                    break;
                    case 3:                        
                        $("#wednesdaySlotHolder .wednesdaySlot").each(function(){
                            var slot = new Object();
                            slot.start =  $(this).find(".start").val();
                            slot.end =  $(this).find(".end").val();
                            slot.dayIndex = 3;
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
                            slot.dayIndex = 4;
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
                            slot.dayIndex = 5;
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
                            slot.dayIndex = 6;
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
                            slot.end =  $(this).find(".end").val();
                            slot.start =  $(this).find(".start").val();
                            
                            slot.dayIndex = 0;
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
            
            function formAjaxSubmit(){
                retrieveOverallJSONSlotData();
                
                var dat = new Object();
                
                dat.name = $("#name").val();
                dat.desc = $("#desc").val();
                dat.bookingFees = $("#bookingFees").val();
                dat.bookingDeposit = $("#bookingDeposit").val();
                dat.needsPayment = $('input[type=checkbox]#needsPayment').is(':checked');
                dat.bookableSlots = slotDataJSON;
                dat.bookingSessionsLimit = $("#bookingSessions").val();
                dat.bookingFreqLimit = $("#bookingLimitFreq").val();
                dat.bookingLimitPeriod = $('select#period option:selected').val();
                dat.bookingOpensDaysInAdvance = $("#bookingOpenAdvance").val();
                dat.bookingClosesDaysInAdvance = $("#bookingCloseAdvance").val();                                
                var req = new Object();
                req.data = JSON.stringify(dat);
                
                $.ajax({
                    type: "POST",
                    url: "/json/admin/createEditFacilityTypeJSON.jsp?edit=true&ftid=" + ${param.id},
                    data: req,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                     },
                    complete: function(xhr, textStatus) {
                            if(xhr.status === 200){
                                toastr.success("Facility Type Successfully Edited!")
                                setTimeout('window.location.href="/admin/manage-facilitytypes.jsp"',1300);
                            }
                            else{
                                toastr.error("Unable to edit Facility Type. Please check your entry");
                            }
                    } 
                });
                
                return dat;
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
                    
                    
                        <% 
        int id = Integer.parseInt(request.getParameter("id"));
        FacilityTypeDAO fDAO = new FacilityTypeDAO();
        FacilityType fType = fDAO.getFacilityType(id);
        RuleDAO rDAO = new RuleDAO();
        System.out.println("TEST FTYPE NAME : " +fType.getDescription());
        
        //Set limitRules = fType.getLimitRules();
        //int count = limitRules.size();
        //System.out.print("PRINTING COUNT OF LIMITRULS :"+limitRules);
        //LimitRule[] lRules = (LimitRule[]) limitRules.toArray();
        //LimitRule lRule = lRules[0];
        //Hibernate.initialize(fType.getLimitRules());
        
        //LimitRule lRule = rDAO.getAllLimitRule(id).get(0);
        LimitRule lRule =  fDAO.getFacilityTypeLimitRules(id);
        
        String timeFrameType = "days";  //default
            String timeFrameValue = "Days";  //default
        if (lRule != null){
            System.out.println("SUCCESS GET LimitRUle");
            if(lRule.getTimeframeType().equals("DAY")){
                timeFrameType = "days";
                timeFrameValue = "Days";
            }else if(lRule.getTimeframeType().equals("WEEK")){
                timeFrameType = "weeks";
                timeFrameValue = "Weeks";
            }else if(lRule.getTimeframeType().equals("MONTH")){
                timeFrameType = "months";
                timeFrameValue = "Months";
            }   
        }
        
        
        //AdvanceRule aRule = rDAO.getAllAdvanceRule(id).get(0);
        AdvanceRule aRule =  fDAO.getFacilityTypeAdvanceRules(id);
        ArrayList<OpenRule> oRules = fDAO.getFacilityTypeOpenRules(id);
        ArrayList<OpenRule> openRuleMon = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleTue = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleWed = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleThu = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleFri = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleSat = new ArrayList<OpenRule>();
        ArrayList<OpenRule> openRuleSun = new ArrayList<OpenRule>();
        
        
        
        for(OpenRule or : oRules){
            switch(or.getDayOfWeek()){
                case 1:
                    openRuleMon.add(or);
                    pageContext.setAttribute("openRuleMon", openRuleMon);
                    break;
                case 2:
                    openRuleTue.add(or);
                    pageContext.setAttribute("openRuleTue", openRuleMon);
                    break;
                case 3:
                    openRuleWed.add(or);
                    pageContext.setAttribute("openRuleWed", openRuleMon);
                    break;
                case 4:
                    openRuleThu.add(or);
                    pageContext.setAttribute("openRuleThu", openRuleMon);
                    break;
                case 5:
                    openRuleFri.add(or);
                    pageContext.setAttribute("openRuleFri", openRuleMon);
                    break;
                case 6:
                    openRuleSat.add(or);
                    pageContext.setAttribute("openRuleSat", openRuleMon);
                    break;
                case 0:
                    openRuleSun.add(or);
                    pageContext.setAttribute("openRuleSun", openRuleMon);
                    break;
            }
        }
        System.out.println("monrules: " + openRuleMon.size());
        System.out.println("tuerules " + openRuleTue.size());
        System.out.println("wedrules: " + openRuleWed.size());
        
        
    %>
                    
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
                                        <stripes:text name="name" class="input-xxlarge" id="name" value="<%= fType.getName() %>"/>
                                        <p class="field-validation-valid" data-valmsg-for="input1" data-valmsg-replace="true">
                </p>
                                    </div>
                         </div>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Description</label>
                                    <div class="controls">
                                        <stripes:textarea id="desc" name="description" class="input-xxlarge" value="<%= fType.getDescription() %>"/>
                                   
                                    </div>
                         </div>
                                        
                         <stripes:hidden id="needsPayment" value="true" name="needsPayment" />       
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Fees:</label>
                                    <div class="controls">
                                        <stripes:text name="bookingFees" class="input-xxlarge" id="bookingFees" value="<%= fType.getBookingFees() %>" />
                                    </div>
                         </div>
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Deposit:</label>
                                    <div class="controls">
                                        <stripes:text name="bookingDeposit" class="input-xxlarge" id="bookingDeposit" value="<%= fType.getBookingDeposit() %>" />
                                    </div>
                         </div>
                                        <label class="control-label">Facility Availability<br/>
                                        <a id="btnCopyFirstRow" href="#copy" onclick="copyFirstRow()">Copy first row down</a></label>
                                        
                                        <table class='timeSlotsTable' cellpadding="7">
                                            <!--populate user current bookings -->

                                            
                                            <tr>
                                                <td class="day">Monday</td>
                                                <td>
                                                    <table id="mondaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleMon.isEmpty()) { int i = 1;%>
                                                            <tr class="mondaySlot slotRow" id="monday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-mon<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide mondaySlotData start" id="a-monday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-mon<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide mondaySlotData end" id="b-monday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('mon',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(1)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-mon<%= i %>").change(function(){
                                                                $("#a-monday<%= i %>").val( getDateFromString($("#a-mon<%= i %>").val()) ); 
                                                            });
                                                            $("#b-mon<%= i %>").change(function(){
                                                                $("#b-monday<%= i %>").val( getDateFromString($("#b-mon<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-monday<%= i %>").val( getDateFromString($("#a-mon<%= i %>").val()) ); 
                                                               $("#b-monday<%= i %>").val( getDateFromString($("#b-mon<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                    <%  //IF THERE ARE RULES, LOOP AND PRINT
                                                        for (int i = 1 ; i < openRuleMon.size()+1 ; i++) { OpenRule o = openRuleMon.get(i-1);%>
                                                        
                                                        <tr class="mondaySlot slotRow" id="monday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-mon<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide mondaySlotData start" id="a-monday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-mon<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide mondaySlotData end" id="b-monday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('mon',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(1)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-mon<%= i %>").change(function(){
                                                                $("#a-monday<%= i %>").val( getDateFromString($("#a-mon<%= i %>").val()) ); 
                                                            });
                                                            $("#b-mon<%= i %>").change(function(){
                                                                $("#b-monday<%= i %>").val( getDateFromString($("#b-mon<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-monday<%= i %>").val( getDateFromString($("#a-mon<%= i %>").val()) ); 
                                                               $("#b-monday<%= i %>").val( getDateFromString($("#b-mon<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                    <%   } %>    
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Tuesday</td>
                                                <td>
                                                    <table id="tuesdaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleTue.isEmpty()) { int i = 1;%>
                                                            <tr class="tuesdaySlot slotRow" id="tuesday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-tues<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide tuesdaySlotData start" id="a-tuesday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-tues<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide tuesdaySlotData end" id="b-tuesday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <%if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('tues',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(2)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-tues<%= i %>").change(function(){
                                                                $("#a-tuesday<%= i %>").val( getDateFromString($("#a-tues<%= i %>").val()) ); 
                                                            });
                                                            $("#b-tues<%= i %>").change(function(){
                                                                $("#b-tuesday<%= i %>").val( getDateFromString($("#b-tues<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-tuesday<%= i %>").val( getDateFromString($("#a-tues<%= i %>").val()) ); 
                                                               $("#b-tuesday<%= i %>").val( getDateFromString($("#b-tues<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                        <% for (int i = 1 ; i < openRuleTue.size()+1 ; i++) { OpenRule o = openRuleTue.get(i-1);%>
                                                        <tr class="tuesdaySlot slotRow" id="tuesday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-tues<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide tuesdaySlotData start" id="a-tuesday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-tues<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide tuesdaySlotData end" id="b-tuesday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <%if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('tues',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(2)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-tues<%= i %>").change(function(){
                                                                $("#a-tuesday<%= i %>").val( getDateFromString($("#a-tues<%= i %>").val()) ); 
                                                            });
                                                            $("#b-tues<%= i %>").change(function(){
                                                                $("#b-tuesday<%= i %>").val( getDateFromString($("#b-tues<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-tuesday<%= i %>").val( getDateFromString($("#a-tues<%= i %>").val()) ); 
                                                               $("#b-tuesday<%= i %>").val( getDateFromString($("#b-tues<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                   <%  }%>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Wednesday</td>
                                                <td>
                                                    <table id="wednesdaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleWed.isEmpty()) { int i = 1;%>
                                                            <tr class="wednesdaySlot slotRow" id="wednesday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-wednes<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide wednesdaySlotData start" id="a-wednesday<%= i %>"
                                                                   value=">"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-wednes<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide wednesdaySlotData end" id="b-wednesday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('wednes',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(3)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-wednes<%= i %>").change(function(){
                                                                $("#a-wednesday<%= i %>").val( getDateFromString($("#a-wednes<%= i %>").val()) ); 
                                                            });
                                                            $("#b-wednes<%= i %>").change(function(){
                                                                $("#b-wednesday<%= i %>").val( getDateFromString($("#b-wednes<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-wednesday<%= i %>").val( getDateFromString($("#a-wednes<%= i %>").val()) ); 
                                                               $("#b-wednesday<%= i %>").val( getDateFromString($("#b-wednes<%= i %>").val()) );
                                                            });
                                                            
                                                        </script>
                                                        <%}%>
                                                        
                                                            <% for (int i = 1 ; i < openRuleWed.size()+1 ; i++) { OpenRule o = openRuleWed.get(i-1);%>
                                                        
                                                        <tr class="wednesdaySlot slotRow" id="wednesday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-wednes<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide wednesdaySlotData start" id="a-wednesday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-wednes<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide wednesdaySlotData end" id="b-wednesday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('wednes',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(3)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-wednes<%= i %>").change(function(){
                                                                $("#a-wednesday<%= i %>").val( getDateFromString($("#a-wednes<%= i %>").val()) ); 
                                                            });
                                                            $("#b-wednes<%= i %>").change(function(){
                                                                $("#b-wednesday<%= i %>").val( getDateFromString($("#b-wednes<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-wednesday<%= i %>").val( getDateFromString($("#a-wednes<%= i %>").val()) ); 
                                                               $("#b-wednesday<%= i %>").val( getDateFromString($("#b-wednes<%= i %>").val()) );
                                                            });
                                                            
                                                        </script>
                                                        
                                                    <% i ++; } %>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Thursday</td>
                                                <td>
                                                    <table id="thursdaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleThu.isEmpty()) { int i = 1;%>
                                                            <tr class="thursdaySlot slotRow" id="thursday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-thurs<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide thursdaySlotData start" id="a-thursday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-thurs<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide thursdaySlotData end" id="b-thursday<%= i %>" 
                                                                   value=">"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('thurs',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(4)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-thurs<%= i %>").change(function(){
                                                                $("#a-thursday<%= i %>").val( getDateFromString($("#a-thurs<%= i %>").val()) ); 
                                                            });
                                                            $("#b-thurs<%= i %>").change(function(){
                                                                $("#b-thursday<%= i %>").val( getDateFromString($("#b-thurs<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-thursday<%= i %>").val( getDateFromString($("#a-thurs<%= i %>").val()) ); 
                                                               $("#b-thursday<%= i %>").val( getDateFromString($("#b-thurs<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                       <% for (int i = 1 ; i < openRuleThu.size()+1 ; i++) { OpenRule o = openRuleThu.get(i-1);%>
                                                        
                                                        <tr class="thursdaySlot slotRow" id="thursday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-thurs<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide thursdaySlotData start" id="a-thursday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-thurs<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide thursdaySlotData end" id="b-thursday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('thurs',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(4)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-thurs<%= i %>").change(function(){
                                                                $("#a-thursday<%= i %>").val( getDateFromString($("#a-thurs<%= i %>").val()) ); 
                                                            });
                                                            $("#b-thurs<%= i %>").change(function(){
                                                                $("#b-thursday<%= i %>").val( getDateFromString($("#b-thurs<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-thursday<%= i %>").val( getDateFromString($("#a-thurs<%= i %>").val()) ); 
                                                               $("#b-thursday<%= i %>").val( getDateFromString($("#b-thurs<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                    <%   }%>
                                                    </table>
                                                </td>
                                                
                                            </tr>
                                            
                                            <tr>
                                                <td class="day">Friday</td>
                                                <td>
                                                    <table id="fridaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleFri.isEmpty()) { int i = 1;%>
                                                            <tr class="fridaySlot slotRow" id="friday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-fri<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide fridaySlotData start" id="a-friday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-fri<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide fridaySlotData end" id="b-friday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('fri',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(5)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-fri<%= i %>").change(function(){
                                                                $("#a-friday<%= i %>").val( getDateFromString($("#a-fri<%= i %>").val()) ); 
                                                            });
                                                            $("#b-fri<%= i %>").change(function(){
                                                                $("#b-friday<%= i %>").val( getDateFromString($("#b-fri<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-friday<%= i %>").val( getDateFromString($("#a-fri<%= i %>").val()) ); 
                                                               $("#b-friday<%= i %>").val( getDateFromString($("#b-fri<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                       <% for (int i = 1 ; i < openRuleFri.size()+1 ; i++) { OpenRule o = openRuleFri.get(i-1);%>
                                                        
                                                        <tr class="fridaySlot slotRow" id="friday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-fri<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide fridaySlotData start" id="a-friday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-fri<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide fridaySlotData end" id="b-friday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('fri',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(5)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-fri<%= i %>").change(function(){
                                                                $("#a-friday<%= i %>").val( getDateFromString($("#a-fri<%= i %>").val()) ); 
                                                            });
                                                            $("#b-fri<%= i %>").change(function(){
                                                                $("#b-friday<%= i %>").val( getDateFromString($("#b-fri<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-friday<%= i %>").val( getDateFromString($("#a-fri<%= i %>").val()) ); 
                                                               $("#b-friday<%= i %>").val( getDateFromString($("#b-fri<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                    <%   }%>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>  
                                            
                                            <tr>
                                                <td class="day">Saturday</td>
                                                <td>
                                                    <table id="saturdaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleSat.isEmpty()) { int i = 1;%>
                                                            <tr class="saturdaySlot slotRow" id="saturday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-satur<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide saturdaySlotData start" id="a-saturday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-satur<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide saturdaySlotData end" id="b-saturday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('satur',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(6)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-satur<%= i %>").change(function(){
                                                                $("#a-saturday<%= i %>").val( getDateFromString($("#a-satur<%= i %>").val()) ); 
                                                            });
                                                            $("#b-satur<%= i %>").change(function(){
                                                                $("#b-saturday<%= i %>").val( getDateFromString($("#b-satur<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-saturday<%= i %>").val( getDateFromString($("#a-satur<%= i %>").val()) ); 
                                                               $("#b-saturday<%= i %>").val( getDateFromString($("#b-satur<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                        <% for (int i = 1 ; i < openRuleSat.size()+1 ; i++) { OpenRule o = openRuleSat.get(i-1);%>
                                                        
                                                        <tr class="saturdaySlot slotRow" id="saturday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-satur<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide saturdaySlotData start" id="a-saturday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-satur<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide saturdaySlotData end" id="b-saturday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('satur',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(6)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-satur<%= i %>").change(function(){
                                                                $("#a-saturday<%= i %>").val( getDateFromString($("#a-satur<%= i %>").val()) ); 
                                                            });
                                                            $("#b-satur<%= i %>").change(function(){
                                                                $("#b-saturday<%= i %>").val( getDateFromString($("#b-satur<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-saturday<%= i %>").val( getDateFromString($("#a-satur<%= i %>").val()) ); 
                                                               $("#b-saturday<%= i %>").val( getDateFromString($("#b-satur<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                    <%   }%>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>   
                                            
                                            <tr>
                                                <td class="day">Sunday</td>
                                                <td>
                                                    <table id="sundaySlotHolder">
                                                        <% //IF NO RULES FOR THIS DAY
                                                            if(openRuleSun.isEmpty()) { int i = 1;%>
                                                            <tr class="sundaySlot slotRow" id="sunday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-sun<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value=""/>
                                                            <input class="hide sundaySlotData start" id="a-sunday<%= i %>"
                                                                   value=""/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-sun<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value=""/>
                                                            <input class="hide sundaySlotData end" id="b-sunday<%= i %>" 
                                                                   value=""/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('sun',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(7)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-sun<%= i %>").change(function(){
                                                                $("#a-sunday<%= i %>").val( getDateFromString($("#a-sun<%= i %>").val()) ); 
                                                            });
                                                            $("#b-sun<%= i %>").change(function(){
                                                                $("#b-sunday<%= i %>").val( getDateFromString($("#b-sun<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-sunday<%= i %>").val( getDateFromString($("#a-sun<%= i %>").val()) ); 
                                                               $("#b-sunday<%= i %>").val( getDateFromString($("#b-sun<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        <%}%>
                                                        
                                                        <% for (int i = 1 ; i < openRuleSun.size()+1 ; i++) { OpenRule o = openRuleSun.get(i-1);%>
                                                        
                                                        <tr class="sundaySlot slotRow" id="sunday<%if(i!=1)out.print(i);%>"><td>
                                                            <input id="a-sun<%= i %>" class="timepicker startTime <%if(i==1)out.print("firstStart");%>"
                                                                   value="<%= o.getStartTimeIn24HourFormat() %>"/>
                                                            <input class="hide sundaySlotData start" id="a-sunday<%= i %>"
                                                                   value="<%= o.getStartTime().getTime() %>"/> 
                                                            <span class="spacing">to</span>
                                                            <input id="b-sun<%= i %>" class="timepicker endTime <%if(i==1)out.print("firstEnd");%>" 
                                                                   value="<%= o.getEndTimeIn24HourFormat() %>"/>
                                                            <input class="hide sundaySlotData end" id="b-sunday<%= i %>" 
                                                                   value="<%= o.getEndTime().getTime() %>"/>
                                                        </td>
                                                        <td><a href="#removeSlot" class="embeddedBtn delBtn <% if(i==1)out.println("hide");%>" 
                                                               onclick="removeSlot('sun',<%= i %>)">x</a>
                                                            <a href="#addSlot" class="embeddedBtn" 
                                                               onclick="addSlotForDay(7)">+</a>
                                                        </td>
                                                        </tr>
                                                        
                                                        <script>
                                                            $("#a-sun<%= i %>").change(function(){
                                                                $("#a-sunday<%= i %>").val( getDateFromString($("#a-sun<%= i %>").val()) ); 
                                                            });
                                                            $("#b-sun<%= i %>").change(function(){
                                                                $("#b-sunday<%= i %>").val( getDateFromString($("#b-sun<%= i %>").val()) ); 
                                                            });
                                                            $("#btnCopyFirstRow").click(function(){
                                                               $("#a-sunday<%= i %>").val( getDateFromString($("#a-sun<%= i %>").val()) ); 
                                                               $("#b-sunday<%= i %>").val( getDateFromString($("#b-sun<%= i %>").val()) );
                                                            });
                                                        </script>
                                                        
                                                    <% }%>
                                                        
                                                    </table>
                                                </td>
                                                
                                            </tr>                        
                                          
                                        </table>
                                    
                                        <br/><br/>
                                    
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Booking Limits</label>
                                    <div id="bookingLimitArea" class="float_l">
                                        <input type="number" class="span75 numbersOnly" name="bookingSessions" value="<% if(lRule!=null) lRule.getSessions(); %>" id="bookingSessions"/> 
                                        time(s) per
                                        <input type="number" class="span75 numbersOnly" name="bookingLimitFreq" value="<% if(lRule!=null) lRule.getNumberOfTimeframe(); %>" id="bookingLimitFreq" />
                                        <stripes:select name="bookingLimitUnit" id="period" class="span75">
                                            <option SELECTED value="<%= timeFrameType.toLowerCase() %>"><%= timeFrameValue %></option>
                                            <option value="days">Days</option>
                                            <option value="weeks">Weeks</option>
                                            <option value="months">Months</option>
                                        </stripes:select>                                            
                                        <a href="#blimit" id="disableBookingLimit" class="embeddedBtn" onclick="disableBookingLimitArea()">No Booking Limits</a>                               
                                    </div>
                               <a id="enableBookingLimit" href="#blimit" class="btn btn-info hide float_l" onclick="disableBookingLimitArea()">Enable Booking Limits</a>          
                         </div>            
                        
                         <div class="control-group ${errorStyle}">
                                    <label class="control-label">Limitation on Booking in Advance</label>
                                    <div class="timepickerArea">
                                        <span>Booking Opens</span>
                                        <input type="number" class="span75 numbersOnly" name="bookingOpenAdvance" value="<%= aRule.getMinDays() %>" id="bookingOpenAdvance"/> 
                                        <span>days in advance</span>
                                    </div> 
                                        
                                    <div class="timepickerArea">
                                        <span>Booking Closes</span>
                                        <input type="number" class="span75 numbersOnly" name="bookingCloseAdvance" value="<%= aRule.getMaxDays() %>" id="bookingCloseAdvance"/> 
                                        <span>days in advance</span>
                                    </div>     
                                        
                                
                         </div>  
                                            <input type="submit" class="btn btn-large btn-primary timepickerArea" value="Edit Facility" /> 
                                     

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
                            formAjaxSubmit();     
                            //slotDataHasError
                        }
                        
                });
                loadTimePickers();
                //validateTimePickerInput();
                
        $('.numbersOnly').keyup(function () {
            if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
                this.value = this.value.replace(/[^0-9\.]/g, '');
            }
        });
            });
            
            
            //RETURNS TRUE IF timeBefore is after timeAfter
            //ALSO RETURNS TRUE IF ANY DATES CANNOT BE PARSED
            function isAfter(timeBefore,timeAfter){
                var dBefore = new Date(parseInt(timeBefore));
                var dAfter = new Date(parseInt(timeAfter));                
                return dBefore >= dAfter;                  
            }
            
            //if booking limits fields are empty, trigger no limits button
            if( $("#bookingSessions").val() == '' || $("#bookingLimitFreq").val() == ''){
                $("#enableBookingLimit").click();
            }
        </script>
        
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/jquery.validate.bootstrap.js"></script>
        
  </body>
</html>
