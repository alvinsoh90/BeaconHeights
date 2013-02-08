<%@page import="com.lin.entities.Comment"%>
<%@page import="com.lin.dao.CommunityWallCommentDAO"%>
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
CommunityWallCommentDAO wallDAO = new CommunityWallCommentDAO();

ArrayList<Comment> comments = wallDAO.retrieveCommentsForPost(postId);

System.out.println("Retrieved comment size: " + comments.size());

JSONObject jOb = new JSONObject();
JSONArray commentArr = new JSONArray();
commentArr.put(comments);

jOb.put("comments", commentArr);

out.println(jOb.toString());

%>