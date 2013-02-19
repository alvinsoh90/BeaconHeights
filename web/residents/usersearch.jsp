<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>My Booking | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.resident.ManagePostBean"/>
        <jsp:useBean id="manageUsersActionBean" scope="page"
                     class="com.lin.general.admin.ManageUsersActionBean"/>
        <jsp:useBean id="registerActionBean" scope="page"
                     class="com.lin.general.login.RegisterActionBean"/>
        <jsp:useBean id="approveUserBean" scope="page"
                     class="com.lin.general.admin.ApproveUserBean"/>
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
        <script src="./js/unicorn.calendar.js"></script>
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="/js/jquery.validate.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>




        <!-- Populates the User Modal-->
        <script>
            // Init an array of all users shown on this page
            var userList = [];
           
            //Loop through userList and output all into table for display
            function showUsers(userArr){           
                
                var r = new Array(), j = -1;
                
                var tableHeaders = "<tr><th>First Name</th><th>Last Name</th><th>Email</th><th>Profile</th></tr>"
                
                for (var i=userArr.length-1; i>=0; i--){
                    r[++j] ='<tr class="list-users"><td>';
                    r[++j] = userArr[i].firstName;
                    r[++j] = '</td><td >';
                    r[++j] = userArr[i].lastName;
                    r[++j] = '</td><td >';
                    r[++j] = userArr[i].email;
                    r[++j] = '</td><td >';
                    r[++j] = "<a href='profile.jsp?profileid="+userArr[i].id+"'> Go to Profile</a>";
                    r[++j] = '</td>';
                    r[++j] = '</tr>';
                }
                $('#userTable').html(tableHeaders + r.join('')); 
            }
            

        </script>

    </head>


    <body>


        <c:forEach items="${manageUsersActionBean.userList}" var="user" varStatus="loop">
            <script>
                                
                var user = new Object();
                user.id = '${user.userId}';
                user.username = '${user.userName}';
                user.firstName = '${user.firstname}';
                user.lastName = '${user.lastname}';
                user.roleName = '${user.role.name}';
                user.email = '${user.email}';
                user.mobileNo= '${user.mobileNo}';
                user.blockName = '${user.block.blockName}';
                user.level = '${user.level}';
                user.unit = '${user.unit}';
                user.vehicleNumberPlate = '${user.vehicleNumberPlate}';
                user.vehicleType = '${user.vehicleType}';
                userList.push(user);
            </script>
        </c:forEach>

            <br></br>

        <div class="container-fluid">

            <div class="page-header">
                <h1>Search <small>Users</small></h1>
            </div>
            
            <input id="searchterm" class="input-medium search-query" value="Search for friends via first name, last name, or email" onfocus="this.value = this.value=='Search for friends via first name, last name, or email'?'':this.value;" onblur="this.value = this.value==''?'Search for friends via first name, last name, or email':this.value;" style="width:350px;"/>
                   
                 
            <button id="seach" type="submit" class="btn"><i class="icon-search"></i> Search</button> 
            <br></br>
                    
            <script>
                $("#searchterm").keyup(function(e){
                    var q = $("#searchterm").val().toLowerCase();
                                      
                    var tempArr = [];
                          
                    for(var i=0;i<userList.length;i++){
                        console.log(name);
                        var fName = userList[i].firstName.toLowerCase();
                        var lName = userList[i].lastName.toLowerCase()
                        var userEmail = userList[i].email;
                        var fullname = fName + " " + lName;
                        if(!q==''){
                            
                                
                                if(fName.indexOf(q) !== -1){
                                    tempArr.push(userList[i]);
                                } else if (lName.indexOf(q)!== -1){
                                    tempArr.push(userList[i]);
                                } else if (userEmail.indexOf(q)!== -1){
                                    tempArr.push(userList[i]);
                                } else if (fullname.indexOf(q)!== -1){
                                    tempArr.push(userList[i]);
                                }
                                
                                
                        }
                            
                    }
                    
                    showUsers(tempArr);
  
                });
            </script>

            <!-- table to display user info -->
            <table id="userTable" class="table table-striped table-bordered table-condensed">

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



    </div>


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

  
<%@include file="/footer.jsp"%>
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
