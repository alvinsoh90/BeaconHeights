<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.controllers.CommunityWallController"%>
<%@page import="com.lin.controllers.EventWallController"%>
<%@include file="/protect.jsp"%>

<%@page import="com.lin.entities.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
User currUser = (User)session.getAttribute("user");
int userId = currUser.getUserId();

String postIdStr = request.getParameter("postId");//this will be null if event is being flagged
String eventIdStr = request.getParameter("eventId"); //this will be null if event is being flagged

String isLiking = request.getParameter("isALike");

JSONObject jOb = new JSONObject();

//Action is being done on a Post
if(postIdStr != null){
    int postId = Integer.parseInt(postIdStr); 

    CommunityWallController wallCtrl = new CommunityWallController();

    if(isLiking.equalsIgnoreCase("true")){
        jOb.put("like_success", wallCtrl.likePost(userId, postId));
    }
    else{
        jOb.put("unlike_success", wallCtrl.unlikePost(userId, postId));
    }
} 
//Action is being done on Event
else if(eventIdStr != null){
    int postId = Integer.parseInt(eventIdStr);

    EventWallController wallCtrl = new EventWallController();

    if(isLiking.equalsIgnoreCase("true")){
        jOb.put("like_success", wallCtrl.likeEvent(userId, postId));
    }
    else{
        jOb.put("unlike_success", wallCtrl.unlikeEvent(userId, postId));
    }
}


out.println(jOb.toString());
System.out.println(jOb.toString());
%>