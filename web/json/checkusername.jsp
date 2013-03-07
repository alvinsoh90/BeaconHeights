

<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%
    String username = request.getParameter("username");
    
    
    
    UserDAO uDAO = new UserDAO();
    boolean success = uDAO.doesUserExist(username);
    JSONObject jOb = new JSONObject();
    jOb.put("result", success);
    
    out.println(jOb.toString());
%>

