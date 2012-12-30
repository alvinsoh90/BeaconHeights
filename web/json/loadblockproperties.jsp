<%-- 
    Document   : loadblockproperties
    Created on : Dec 30, 2012, 8:17:12 PM
    Author     : fayannefoo
--%>


<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.entities.Block"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="registerActionBean" scope="page"
             class="com.lin.general.login.RegisterActionBean"/>

<%
    ArrayList<Block> blockList = registerActionBean.getAllBlocks();
    JSONObject jobj = new JSONObject();
%>


<%
    for (Block b : blockList) {
        jobj.put("levels", b.getLevels());
        jobj.put("units", b.getUnitsPerFloor());
    }
%>

<%
    //print JSON
System.out.println(jobj.toString());
    out.println(jobj);
%>

