
<%-- 
    Document   : adminView
    Created on : Oct 10, 2012, 2:59:00 PM
    Author     : Keffeine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
    <body>
  <stripes:form beanclass="com.lin.general.admin.AdminActionBean" focus="">
    <table>
      <tr>
                <td>enter username:</td>
                <td><stripes:text name="username"/> </td>
      </tr>

        <td colspan="2">
          
      <stripes:submit name="getTheUsername" value="get user"/>                    
      </td>
      </tr>
      <tr>
        <td>Result:</td>
        <td>${actionBean.result}</td>
      </tr>
    </table>
  </stripes:form>
  </body>
</html>
