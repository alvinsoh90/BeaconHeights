<%@page import="com.lin.controllers.EventWallController"%>
<%@include file="/protect.jsp"%>

<%@page import="com.lin.entities.User"%>
<%@page import="com.lin.dao.PostDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.dao.FacilityTypeDAO"%>
<%@page import="com.lin.entities.FacilityType"%>

<%

int postId = Integer.parseInt(request.getParameter("eventId"));
String commentContent = request.getParameter("content");
User u = (User)session.getAttribute("user");
int posterId = u.getUserId();

EventWallController wallCtrl = new EventWallController();
System.out.println("event creator id: " + posterId);
wallCtrl.addCommentOnEvent(postId, u, commentContent);

%>