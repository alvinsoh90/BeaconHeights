<%-- 
    Document   : protect
    Created on : Dec 14, 2012, 4:25:51 AM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="loginActionBean" scope="page"
             class="com.lin.general.login.LoginActionBean"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <c:if test= "${user==null}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <c:if test= "${user.role.id !=1}">
            <c:redirect url="/login.jsp" />                   
        </c:if>
    </body>
</html>
