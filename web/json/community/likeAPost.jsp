<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.controllers.CommunityWallController"%>
<%@include file="/protect.jsp"%>

<%@page import="com.lin.entities.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
User currUser = (User)session.getAttribute("user");
int userId = currUser.getUserId();
int postId = Integer.parseInt(request.getParameter("postId"));

CommunityWallController wallCtrl = new CommunityWallController();

JSONObject jOb = new JSONObject();
jOb.put("like_success", wallCtrl.likePost(userId, postId));

out.println(jOb.toString());
System.out.println(jOb.toString());
%>