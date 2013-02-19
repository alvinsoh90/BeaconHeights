<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Make a Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:useBean id="manageBookingsActionBean" scope="page"
                     class="com.lin.general.admin.ManageBookingsActionBean"/>
        <jsp:useBean id="manageFacilitiesActionBean" scope="page"
                     class="com.lin.general.admin.ManageFacilitiesActionBean"/>
        <jsp:useBean id="manageFacilityTypesActionBean" scope="page"
                     class="com.lin.general.admin.ManageFacilityTypesActionBean"/>
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
        <script src="./js/jquery-1.7.2.min.js"></script>
        
        <!-- Calendar -->
        <script src="./js/unicorn.calendar.js"></script>
        <!--Toastr Popup -->
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        
        <!-- Scripts -->
        <script>
            var levels="";
            var units = "";
            
            function loadLevelsAndUnits() {
                console.log("loading");
                var source = "/json/loadblockproperties.jsp?blockName="+$('select#block').val();
                $.ajax({
                    url: "/json/loadblockproperties.jsp",
                    type: "GET",
                    data:"blockName="+$('select#block').val(),
                    dataType: 'text',
                    success: function (data) {
                        var obj = jQuery.parseJSON(data);
                        levels = obj.levels;
                        units = obj.units;
                        
                        var levelOptions="";
                        var unitOptions = "";
                        for (var i=1;i<levels+1;i++){
                            if(i<10){
                                levelOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                levelOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        for (var i=1;i<units+1;i++){
                            if(i<10){
                                unitOptions += '<option value="' + i + '">0' + i + '</option>';
                            }else{
                                unitOptions += '<option value="' + i + '">' + i + '</option>';
                            }
                        };
                        $("select#level").html(levelOptions);
                        $("select#unit").html(unitOptions);
                        
                        // only after successful loading should we load this 'sexy chosen' plugin	
//                        $('select').chosen();
                    }
                });
            };
            
            $(document).ready(function(){    
            
                // When document loads fully, load level and unit options via AJAX
                loadLevelsAndUnits();

                // if dropdown changes, we want to reload the unit and level options.
                $("#block").change(function(){
                    loadLevelsAndUnits();
                });
            });
            
        </script>
        <script>
            // Retrieve booking events from DB
            var facilityList =[];
            var bookingList = [];
            var openTimingsList = [];

            function showFacilityBookingsByFacilityID(facilityID){ 
                //this method is called when page is fully loaded
                
                //clear previous events
                $('#fullcalendar').fullCalendar( 'removeEvents');
                
                //add new event source
                var eventSource = "/json/bookingevents.jsp?facilityid=" 
                    + facilityID +"&userid="+${sessionScope.user.userId};
                
                $('#fullcalendar').fullCalendar( 'addEventSource', eventSource );  
                
                
                //also load up this facility's open rules
                
                openTimingsList = [];  //clear previous timings, if any
                                
                $.get("/json/getopenrulesbyfacilityid.jsp?facilityid=" + facilityID, function(data){
                    for(i = 0 ; i < data.length ; i++){
                        openTimingsList.push([
                            data[i].start,
                            data[i].end,
                            data[i].dayIndex,
                            data[i].startFormattedTime,
                            data[i].endFormattedTime
                        ]);
                    }
                    
                    paintCalendar();  //set timings to be greyed out
                });
                
            } 
               
            function alphabetical(a, b)
            {
                if (a.name < b.name){
                    return -1;
                }else if (a.name > b.name){
                    return  1;
                }else{
                    return 0;
                }
            }
              
            
        </script> 

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

    </head>

    <body>
        <c:forEach items="${manageFacilitiesActionBean.facilityList}" var="facility" varStatus="loop">
            <script>
                var facility = new Object();
                facility.id = '${facility.id}';
                facility.name = '${facility.name}';
                facilityList.push(facility);
            </script>
        </c:forEach>


        <div id="content">

            <div class="container">

                <div class="row">

                    <div class="span3">

                        <div class="account-container">
                            <h2>Now Booking</h2>


                        </div> <!-- /account-container -->
                        
                        <select id ="facilityDropDown" class="tour1">
                                <script>
                                    var print;
                                    facilityList.sort(alphabetical);
                                    for(var i = 0;i<facilityList.length;i++){
                                        console.log(facilityList[i].name);
                                        print+= "<option value="+facilityList[i].id+">"+ facilityList[i].name+ "</option>";
                                    }
                                    $('#facilityDropDown').html(print);
                                </script>
                            </select>
                        <div class="widget-content widget-nopad">
                            <div id="facilitytypedescription"></div>
                        </div>

                        <hr />

                        <ul id="main-nav" class="nav nav-tabs nav-stacked">
                            <h2>Your Booking Details</h2>
                            <div class="widget-content widget-nopad">
                                <div>
                                    <b>Venue: </b><span id="venue">Choose facility
                                    </span><br/>
                                    <b>Date: </b><span id="date"><i><font size="2"> --</font></i></span> <br/>
                                    <b>Time: </b><span id="time"><i><font size="2"> --</font></i></span>
                                </div>
                                <!--<div class="inviteFriends comingsoon">
                                    <div class="header">Invite Friends</div>
                                    <input class="span2" type="text" placeholder="Type a friend's name"/>
                                    <button class="btn btn-peace-2 btnmod">Invite</button>
                                <!--Invited: 
                                <span class="inviteLabel label label-success"></span>                         
                            </div>
                            <div class="shareBooking centerText comingsoon">
                                <h4>Share this event with your friends</h4>-->
                                <!--<button class="socialIcons iconFacebook icon-facebook"></button>
                            </div>-->

                                <stripes:form beanclass="com.lin.facilitybooking.BookFacilityActionBean" focus="">


                                    <br/>
                                    <c:if test= "${user.role.id ==1}">
                                        <div>
                                            <div class="control-group ${errorStyle}">
                                                <b>Level:</b>
                                                <div class="controls">
                                                    <stripes:select name="level" id="level">
                                                    </stripes:select>                                    </div>
                                            </div>     
                                            <div class="control-group ${errorStyle}">
                                                <b>Unit Number:</b>
                                                <div class="controls">
                                                    <stripes:select name="unit" id ="unit">
                                                    </stripes:select>                                     </div>
                                            </div> 
                                        </div>
                                    </c:if> 

                                    <c:if test= "${user.role.id !=1}">
                                        <stripes:hidden name="level" value="${user.level}" />
                                        <stripes:hidden name="unit" value="${user.unit}" />
                                    </c:if>
                                    <stripes:hidden name="facilityID" id="facilityid" />
                                    <stripes:hidden name="startDateString" id="starttimemillis" />   
                                    <stripes:hidden name="endDateString" id="endtimemillis" /> 
                                    <stripes:text class="optionalstop" name="title" id="title" onclick= "this.value=''" value="Enter an optional event name"/>
                                    <stripes:hidden name="currentUserID" id="userID" value='${sessionScope.user.userId}'/> 

                                    <div class="centerText">
                                        <stripes:submit id="laststop" class="inlineblock btn-large btn btn-peace-1" name="placeBooking" value="Place Booking"/>
                                    </div>
                                </div>
                            </stripes:form>

                            <hr />

                            <div class="sidebar-extra">

                            </div>  

                            <br />

                    </div> <!-- /span3 -->

                    <div class="span9">

                        <h1 class="page-title">
                            <i class="icon-home"></i>

                            <span id ="sub"></span> 
                            Bookings
                            <span id ="legend">
                                <i class="icon-stop" style="color: #E0BEC1"></i> Your booking (awaiting payment) &nbsp;
                                <i class="icon-stop" style="color: #206F77"></i> Your booking (confirmed)</span>

                        </h1>
                        <br/>
                    </div>	

                    <script>
                        Object.size = function(obj) {
                            var size = 0, key;
                            for (key in obj) {
                                if (obj.hasOwnProperty(key)) size++;
                            }
                            return size;
                        };
                        
                        $(document).ready(function(){
                            // To display facility selected in the dropdown box, in the booking details
                            function displayVals() {
                                var singleValues = $("#facilityDropDown option:selected").text();

                                //set venue texts
                                $("#venue").text(singleValues); 
                                $("#sub").text(singleValues);  
                                //set hidden field facility id
                                $("#facilityid").val($("#facilityDropDown").val());

                                //reload calendar when dropdown is changed
                                var currFacilityID = $("#facilityDropDown option:selected").val();
                                showFacilityBookingsByFacilityID(currFacilityID);
                                
                                //show selected facility's rules
                                console.log("List : " + JSON.stringify(facilityTypeList));
                                console.log("CurrFacID : " + currFacilityID);

                                var payload = new Object();
                                payload.id = currFacilityID; 
                                $.ajax({
                                    type: "POST",
                                    url: "/json/admin/getFacilityTypeIdFromFacilityIdJSON.jsp",
                                    data: payload,
                                    success: function(data, textStatus, xhr) {
                                        console.log(xhr.status);
                                        console.log("RETURNED1::" + data.facilityTypeID);
                                        
                                        for(i=0;i<facilityTypeList.length;i++){
                                            var currFacilityType = facilityTypeList[i];
                                            if(data.facilityTypeID == currFacilityType.id){
                                                //print description
                                                //$("#facilitytypedescription").html("<b>Description: </b><br/>" + currFacilityType.description+"<br/><br/>");
                                                    
                                                var toPrint = "<b>Description: </b><br/>" + currFacilityType.description+"<br/>";
                                                    
                                                toPrint = toPrint + "<br/><b>Limit Rule: </b><br/>";
                                                var limitRuleArr = currFacilityType.limitRuleArr;
                                                if(0<currFacilityType.limitRuleArr.length){
                                                    for(j=0;j<currFacilityType.limitRuleArr.length;j++){
                                                        toPrint = toPrint + limitRuleArr[j] + "<br/>";
                                                    }   
                                                }else{
                                                    toPrint = toPrint + "None<br/>";
                                                }
                                                    
                                                toPrint = toPrint + "<br/><b>Advance Booking Rule: </b><br/>";
                                                var advanceRulesArr = currFacilityType.advanceRulesArr;
                                                if(0<currFacilityType.advanceRulesArr.length){
                                                    for(j=0;j<currFacilityType.advanceRulesArr.length;j++){
                                                        toPrint = toPrint + advanceRulesArr[j] + "<br/>";
                                                    }
                                                }else{
                                                    toPrint = toPrint + "None<br/>";
                                                }
                                                    
                                                toPrint = toPrint + "<br/><b>Booking Fees: </b>";
                                                if(null != currFacilityType.bookingFees){
                                                    var num = currFacilityType.bookingFees;
                                                    toPrint = toPrint + "$" + parseFloat(num).toFixed(2) + "<br/>";
                                                }else{
                                                    toPrint = toPrint + "None<br/>";
                                                }
                                                    
                                                toPrint = toPrint + "<br/><b>Booking Deposit: </b>";
                                                if(null != currFacilityType.bookingDeposit){
                                                    toPrint = toPrint + "$" + currFacilityType.bookingDeposit + "<br/>";
                                                        
                                                }else{
                                                    toPrint = toPrint + "None<br/>";
                                                }
                                                $("#facilitytypedescription").html(toPrint);
                                            }  
                                        }
                                    }
                                });



                            }
                            
                            //attach handler
                            $("#facilityDropDown").change(displayVals);
                            
                            // if there is a specific facility's booking to load, then 
                            // change the dropdown to the correct facility
                            var facilityID = "${param.fid}";

                            if (facilityID != ""){
                                $("#facilityDropDown").val("${param.fid}");
                            }
                            //  display default bookings as per whats in the dropdown
                            displayVals();
                            
                           
                        });
                        
                        //if successful booking, show message
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
                        
                    </script>


                    <div class="span9">
                        <div class="widget-content nopadding calendarContainer">
                            <div id="ajax-spinner" class="ajaxSpinner hide"></div>
                            <div id="fullcalendar" class="calendarWidth"></div>
                        </div>
                        <c:if test="${manageBookingsActionBean.bookingList.size()!=0}">     
                            <c:forEach items="${manageBookingsActionBean.bookingList}" var="booking" varStatus="loop">
                                <script>
                                    var booking = new Object();
                                    booking.id = '${booking.id}';
                                    booking.start = new Date(${booking.startTimeInSeconds});
                                    booking.end = new Date(${booking.endTimeInSeconds});
                                    booking.title 
                                        = '${booking.facility.facilityType.name} ${booking.facility.id}';
                                    booking.allDay = false;
                                    bookingList.push(booking);
                                </script>
                            </c:forEach>
                        </c:if>

                    </div> <!-- /row -->

                </div> <!-- /container -->
               
            </div> <!-- /content -->


            <%@include file="/footer.jsp"%>


            <!-- Le javascript
            ================================================== -->
            <!-- Placed at the end of the document so the pages load faster -->


            <script src="./js/fullcalendar.min.js"></script>
            <script src="./js/bootstrap.js"></script>


            <script>
                var facilityTypeList = [];
                <c:forEach items="${manageFacilityTypesActionBean.facilityTypeList}" var="facilityType" varStatus="loop">
                
                    var facilityType = new Object();
                    facilityType.id = "${facilityType.id}";
                    facilityType.name = "${facilityType.name}";
                    facilityType.description = "${facilityType.description}";
                    facilityType.limitRuleArr = [];
                    <c:forEach items="${facilityType.limitRules}" var="limitRules" varStatus="loop">
                        facilityType.limitRuleArr.push('${limitRules}');
                    </c:forEach>    
                        facilityType.advanceRulesArr = [];
                    <c:forEach items="${facilityType.advanceRules}" var="advanceRules" varStatus="loop">
                        facilityType.advanceRulesArr.push('${advanceRules}');
                    </c:forEach>
                        facilityType.needsPayment = "${facilityType.needsPaymentString}";
                        facilityType.bookingFees = "${facilityType.bookingFees}";
                        facilityType.bookingFees = "${facilityType.bookingDeposit}";
                        facilityTypeList.push(facilityType);
                </c:forEach>
            </script>
            
            <!-- Joyride Stuff -->
                    <!-- Joyride Walkthrough -->
        <link href="../css/joyride-2.0.3.css" rel="stylesheet" />
        <script src="../js/jquery.joyride-2.0.3.js"></script>
                 <!-- Tip Content -->
        <ol id="joyRideTipContent">
          <li data-class="tour1" data-text="Next" data-options="tipLocation:top;tipAnimation:fade">
            <h2>Select your facility</h2>
            <p>You can control all the details for you tour stop. Any valid HTML will work inside of Joyride.</p>
          </li>
          <li data-class="fc-week1" data-button="Next" data-options="tipLocation:left;tipAnimation:fade">
            <h2>Choose the date of your booking</h2>
            <p>Get the details right by styling Joyride with a custom stylesheet!</p>
          </li>
          <li data-class="bookingDetails" data-button="Next" data-options="tipLocation:right">
            <h2>Check your booking details</h2>
            <p>It works right aligned.</p>
          </li>
          <li data-class="optionalstop" data-button="Close" data-options="tipLocation:top">
            <h2>Enter a title to your booking (Optional)</h2>
            <p>Now what are you waiting for? Add this to your projects and get the most out of your apps!</p>
          </li>
          <li data-id="laststop" data-button="Close" data-options="tipLocation:top;nub:">
            <h2>All done! Click here to make the booking</h2>
            <p>Now what are you waiting for? Add this to your projects and get the most out of your apps!</p>
          </li>
        </ol>
                 
                 <script>
      $(window).load(function() {
        $('#joyRideTipContent').joyride({
          //pauseAfter : [1,2,3,4]
          
        });
      });
    </script>

    </body>
</html>


