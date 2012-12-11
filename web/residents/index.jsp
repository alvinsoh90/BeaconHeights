<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Make a Booking | Beacon Heights</title>
    <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>

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
    <script src="./js/unicorn.calendar.js"></script>
    
    <!-- Scripts -->
    

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	
  </head>

<body>
	
<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
		<div class="container">
			
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 				
			</a>
			
			<a class="brand" href="./">Adminia Admin</a>
			
			<div class="nav-collapse">
			
				<ul class="nav pull-right">
                                    <li class="divider-vertical"></li>
					<li>
                                            <img class="profilePic" src="http://profile.ak.fbcdn.net/hprofile-ak-snc7/371889_776405701_1107384686_q.jpg"/>
					</li>
					
					
					
					<li class="dropdown">
						
						<a data-toggle="dropdown" class="dropdown-toggle " href="#">
							Garreth Peh <b class="caret"></b>							
						</a>
						
						<ul class="dropdown-menu">
							<li>
								<a href="./account.html"><i class="icon-user"></i> Account Setting  </a>
							</li>
							
							<li>
								<a href="./change_password.html"><i class="icon-lock"></i> Change Password</a>
							</li>
							
							<li class="divider"></li>
							
							<li>
								<a href="./"><i class="icon-off"></i> Logout</a>
							</li>
						</ul>
					</li>
				</ul>
				
			</div> <!-- /nav-collapse -->
			
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->




<div id="content">
	
	<div class="container">
		
		<div class="row">
			
			<div class="span3">
				
				<div class="account-container">
                                    
                                    <h2>Now Booking</h2>
                                    <select>
                                        <option value="tennis">Tennis Court A</option>
                                    </select>
				
				</div> <!-- /account-container -->
				
				<hr />
				
				<ul id="main-nav" class="nav nav-tabs nav-stacked">
					<h2>Your Booking Details</h2>
                                        <div class="widget-content widget-nopad">
                                            <div class="bookingDetails">
                                                Venue: <span id="venue">Tennis Court A</span><br/>
                                                Date: <span id="date">25/11/12</span> <br/>
                                                Time: <span id="time">7pm</span>
                                            </div>
                                            <div class="inviteFriends comingsoon">
                                                <div class="header">Invite Friends</div>
                                                <input class="span2" type="text" placeholder="Type a friend's name"/>
                                                <button class="btn btn-peace-2 btnmod">Invite</button>
                                                Invited: 
                                                <span class="inviteLabel label label-success">Fayanne Foo  x</span>                             
                                            </div>
                                            <div class="shareBooking centerText comingsoon">
                                                <h4>Share this event with your friends</h4>
                                                <!--<button class="socialIcons iconFacebook icon-facebook"></button> -->
                                            </div>
                                              <stripes:form beanclass="com.lin.facilitybooking.BookFacilityActionBean" focus="">
                                              <stripes:text name="facilityID" id="facilityid" class="hide" />
                                              <stripes:text name="startDateString" id="starttimemillis" class="hide" />   
                                              <stripes:text name="endDateString" id="endtimemillis" class="hide"  /> 
                                              <stripes:text name="title" id="title" class="hide"/>
                                            <div class="centerText">
                                                <stripes:submit class="inlineblock btn-large btn btn-peace-1" name="placeBooking" value="Place Booking"/>
                                            </div>
                                        </div>
                                             </stripes:form>
				
				<hr />
				
				<div class="sidebar-extra">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.</p>
				</div> <!-- .sidebar-extra -->
				
				<br />
		
			</div> <!-- /span3 -->
			
			
			
			<div class="span9">
				
				<h1 class="page-title">
					<i class="icon-home"></i>
					Tennis Court					
				</h1>
                            <br/>
                        </div>	
                         
                        <div class="span9">
                            <div class="widget-content nopadding calendarContainer">
                                 <div id="fullcalendar" class="calendarWidth"></div>
                            </div>
                        </div>
                        
			
		</div> <!-- /row -->
		
	</div> <!-- /container -->
	
</div> <!-- /content -->
					
	
<div id="footer">
	
	<div class="container">				
		<hr>
		<p>&copy; 2012 Go Ideate.</p>
	</div> <!-- /container -->
	
</div> <!-- /footer -->


<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->

<script src="./js/excanvas.min.js"></script>
<script src="./js/jquery.flot.js"></script>
<script src="./js/jquery.flot.pie.js"></script>
<script src="./js/jquery.flot.orderBars.js"></script>
<script src="./js/jquery.flot.resize.js"></script>
 <script src="./js/fullcalendar.min.js"></script>

<script src="./js/bootstrap.js"></script>
<script src="./js/charts/bar.js"></script>

  </body>
</html>
