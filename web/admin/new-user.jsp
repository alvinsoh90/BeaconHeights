<%@page import="java.util.Map"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.lin.dao.UserDAO"%>
<!DOCTYPE html>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>

<%@include file="/protectadmin.jsp"%>
<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>New User</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
        <meta name="author" content="travis">

        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/site.css" rel="stylesheet">
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <script>
            var levels="";
            var units = "";
            window.onload = function() {
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
                            levelOptions += '<option value="' + i + '">' + i + '</option>';
                        };
                        for (var i=1;i<units+1;i++){
                            unitOptions += '<option value="' + i + '">' + i + '</option>';
                        };
                        $("select#level").html(levelOptions);
                        $("select#unitnumber").html(unitOptions);
                    }
                });
            };  
        </script>
    </head>

    <body>
        <%@include file="include/mainnavigationbar.jsp"%>

        <div class="container-fluid">
            <%@include file="include/sidemenu.jsp"%>

            <div class="span9">
                <div class="row-fluid">
                    <div class="page-header">
                        <h1>New User <small>User registration</small></h1>
                    </div>
                    <stripes:form class="form-horizontal" beanclass="com.lin.general.admin.ManageUsersActionBean" focus="" name="new_user_validate" id="new_user_validate">
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Role</label>
                            <div class="controls">
                                <stripes:select name="role" id="role">
                                    <stripes:options-collection collection="${manageUsersActionBean.roleList}" value="name" label="name"/>        
                                </stripes:select>
                            </div>
                        </div>

                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Username</label>
                            <div class="controls">
                                <stripes:text name="username"/>
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Password</label>
                            <div class="controls">
                                <stripes:password name="password" id="password"/>
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Confirm Password</label>
                            <div class="controls">
                                <stripes:password  name="passwordconfirm" id="passwordconfirm"/>
                            </div>
                        </div>                             
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">First Name</label>
                            <div class="controls">
                                <stripes:text name="firstname"/> 
                            </div>
                        </div>                              
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Last Name</label>
                            <div class="controls">
                                <stripes:text name="lastname"/> 
                            </div>
                        </div>
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Block</label>
                            <div class="controls">
                                <stripes:select name="block" id="block">

                                    <stripes:options-collection collection="${registerActionBean.allBlocks}" 
                                                                value="blockName" label="blockName"/>        
                                </stripes:select>
                            </div>
                        </div> 
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Level</label>
                            <div class="controls">
                                <stripes:select name="level" id="level">
                                </stripes:select>
                            </div>
                        </div>     
                        <div class="control-group ${errorStyle}">
                            <label class="control-label">Unit Number</label>
                            <div class="controls">
                                <stripes:select name="unitnumber" id ="unitnumber">
                                </stripes:select>                                        </div>
                        </div> 

                        <div class="form-actions">
                            <input type="submit" name="createUserAccount" value="Add this user" class="btn btn-info btn-large">
                        </div>                            
                    </stripes:form>
                </div>
            </div>
        </div>

        <hr>

        <%@include file="include/footer.jsp"%>

    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
