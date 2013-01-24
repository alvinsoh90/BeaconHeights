<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>
<jsp:setProperty name="manageBookingsActionBean" property="facilityId" value="${param.facilityid}"/>


<%
    ArrayList<OpenRule> openRules = manageBookingsActionBean.getOpenRulesByFacilityID(
            Integer.parseInt(request.getParameter("facilityid")));
    
    JSONArray arr = new JSONArray();
    
    for(OpenRule r : openRules){
            JSONObject rule = new JSONObject();
            rule.put("start", r.getStartTimeIn24HourFormat());
            rule.put("end", r.getEndTimeIn24HourFormat());
            rule.put("dayIndex", r.getDayOfWeek());
            rule.put("startFormattedTime",r.getStartTime().getTime());
            rule.put("endFormattedTime",r.getEndTime().getTime());
            arr.put(rule);
    }
    
    //print JSON
    out.println(arr);
%>