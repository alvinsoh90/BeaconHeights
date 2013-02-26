<%@page import="com.lin.dao.EventCommentDAO"%>
<%@page import="com.lin.entities.EventComment"%>
<%@include file="/protect.jsp"%>

<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>

<%

int postId = Integer.parseInt(request.getParameter("eventId"));
EventCommentDAO wallDAO = new EventCommentDAO();

ArrayList<EventComment> comments = wallDAO.retrieveCommentsForEvent(postId);

System.out.println("Retrieved comment size: " + comments.size());

JSONObject jOb = new JSONObject();
JSONArray commentArr = new JSONArray();
commentArr.put(comments);

jOb.put("comments", commentArr);

out.println(jOb.toString());

%>