<%@page import="com.lin.entities.Facility"%>
<%@page import="com.lin.dao.FacilityDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.dao.FacilityTypeDAO"%>
<%@page import="com.lin.entities.FacilityType"%>
<%@include file="/protectadmin.jsp"%>
<%

FacilityDAO ftDAO = new FacilityDAO();

Facility facility = ftDAO.getFacility(Integer.parseInt(request.getParameter("id")));

JSONObject jOb = new JSONObject();
jOb.put("facilityTypeID", facility.getFacilityType().getId());

out.println(jOb.toString());
%>


