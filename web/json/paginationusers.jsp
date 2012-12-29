<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.Booking"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="manageUsersActionBean" scope="page"
             class="com.lin.general.admin.ManageUsersActionBean"/>

<%
    int pagenumber = Integer.parseInt(request.getParameter("pagenumber"));
    int perpage = Integer.parseInt(request.getParameter("perpage"));
    
    ArrayList<User> userList = manageUsersActionBean.getUserList();

    JSONArray arr = new JSONArray();
%>


<%
    if(pagenumber >0 || perpage > 0){
            int start = (pagenumber - 1) * perpage;

            int end = start + perpage;
            
            if(end > userList.size()){
                end = userList.size();
            }

            for (int i = start; i<end; i++) {
                User u = userList.get(i);
                JSONObject jUser = new JSONObject();
                jUser.put("userId", u.getUserId());
                jUser.put("userName", u.getUserName());
                jUser.put("firstname", u.getFirstname());
                jUser.put("lastname", u.getLastname());
                jUser.put("role", u.getRole());
                jUser.put("block", u.getBlock());
                jUser.put("level", u.getLevel());
                jUser.put("unit", u.getUnit());

                arr.put(jUser);
            }
    }
%>

<%
    //print JSON
    out.println(arr);

%>

