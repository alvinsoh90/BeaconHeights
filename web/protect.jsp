<%-- 
    Document   : protect
    Created on : Dec 14, 2012, 4:25:51 AM
    Author     : fayannefoo
--%>


<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="loginActionBean" scope="page"
             class="com.lin.general.login.LoginActionBean"/>

        <c:if test= "${user==null}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <c:if test= "${user.forceChooseUsername}">
            <c:redirect url="/chooseusername.jsp" />
        </c:if>
