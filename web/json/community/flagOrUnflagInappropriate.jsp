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
String isInappropriate = request.getParameter("isInappropriate");

JSONObject jOb = new JSONObject();
CommunityWallController wallCtrl = new CommunityWallController();


if(isInappropriate.equalsIgnoreCase("true")){
    //check if user has flagged this post before
    if(wallCtrl.hasUserFlaggedInappropriate(userId, postId)){
        jOb.put("flag_success", false);
        jOb.put("reason", "You have already flagged this post. "
                + "Please contact us directly at helpdesk@beaconheights.com.sg "
                + "for urgent support.");
    }
    else{
        jOb.put("flag_success", wallCtrl.flagPostInappropriate(userId, postId));
    }
}
else{
    jOb.put("unflag_success", wallCtrl.unFlagPostInappropriate(userId, postId));
}

out.println(jOb.toString());
System.out.println(jOb.toString());
%>