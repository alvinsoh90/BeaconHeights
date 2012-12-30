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
<%@page import="com.lin.entities.FacilityType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="manageFacilityTypesActionBean" scope="page"
             class="com.lin.general.admin.ManageFacilityTypesActionBean"/>

<%
    int pagenumber = Integer.parseInt(request.getParameter("pagenumber"));
    int perpage = Integer.parseInt(request.getParameter("perpage"));
    
    ArrayList<FacilityType> facilityTypeList = manageFacilityTypesActionBean.getFacilityTypeList();

    JSONArray arr = new JSONArray();
%>


<%
    if(pagenumber >0 || perpage > 0){
            int start = (pagenumber - 1) * perpage;

            int end = start + perpage;
            
            if(end > facilityTypeList.size()){
                end = facilityTypeList.size();
            }

            for (int i = start; i<end; i++) {
                FacilityType f = facilityTypeList.get(i);
                JSONObject jFacilityType = new JSONObject();
                jFacilityType.put("id", f.getId());
                jFacilityType.put("name", f.getName());
                jFacilityType.put("description", f.getDescription());
                //jFacilityType.put("openRules", f.getOpenRules());
                //jFacilityType.put("closeRules", f.getCloseRules());
                //jFacilityType.put("limitRules", f.getLimitRules());
                //jFacilityType.put("advanceRules", f.getAdvanceRules());

                arr.put(jFacilityType);
            }
    }
%>

<%
    //print JSON
    out.println(arr);

%>

