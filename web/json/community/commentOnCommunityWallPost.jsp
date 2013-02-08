<%@page import="com.lin.controllers.CommunityWallController"%>
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

int postId = Integer.parseInt(request.getParameter("postId"));
String commentContent = request.getParameter("content");
int posterId = Integer.parseInt(request.getParameter("posterId"));

CommunityWallController wallCtrl = new CommunityWallController();

wallCtrl.addCommentOnPost(posterId, postId, commentContent);

%>