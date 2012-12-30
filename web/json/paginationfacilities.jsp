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
<%@page import="com.lin.entities.Facility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="manageFacilitiesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilitiesActionBean"/>

<%
    int pagenumber = Integer.parseInt(request.getParameter("pagenumber"));
    int perpage = Integer.parseInt(request.getParameter("perpage"));
    
    ArrayList<Facility> facilityList = manageFacilitiesActionBean.getFacilityList();

    JSONArray arr = new JSONArray();
%>


<%
    if(pagenumber >0 || perpage > 0){
            int start = (pagenumber - 1) * perpage;

            int end = start + perpage;
            
            if(end > facilityList.size()){
                end = facilityList.size();
            }

            for (int i = start; i<end; i++) {
                Facility f = facilityList.get(i);
                JSONObject jFacility = new JSONObject();
                jFacility.put("id", f.getId());
                jFacility.put("name", f.getName());
                jFacility.put("facilityType", f.getFacilityType());

                arr.put(jFacility);
            }
    }
%>

<%
    //print JSON
    out.println(arr);

%>

