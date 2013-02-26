<%@page import="com.lin.controllers.EventWallController"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.controllers.CommunityWallController"%>
<%@include file="/protect.jsp"%>

<%@page import="com.lin.entities.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
User currUser = (User)session.getAttribute("user");
int userId = currUser.getUserId();

String postIdStr = request.getParameter("postId");//this will be null if event is being flagged
String eventIdStr = request.getParameter("eventId"); //this will be null if event is being flagged

String isInappropriate = request.getParameter("isInappropriate");

JSONObject jOb = new JSONObject();


//Action is being done on a Post
if(postIdStr != null){
    int postId = Integer.parseInt(postIdStr);
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
}
//Action is being done on Event
else if(eventIdStr != null){
    int postId = Integer.parseInt(eventIdStr);
    EventWallController wallCtrl = new EventWallController();
   
    if(isInappropriate.equalsIgnoreCase("true")){
        //check if user has flagged this post before
        if(wallCtrl.hasUserFlaggedInappropriate(userId, postId)){
            jOb.put("flag_success", false);
            jOb.put("reason", "You have already flagged this post. "
                    + "Please contact us directly at helpdesk@beaconheights.com.sg "
                    + "for urgent support.");
        }
        else{
            jOb.put("flag_success", wallCtrl.flagEventInappropriate(userId, postId));
        }
    }
    else{
        jOb.put("unflag_success", wallCtrl.unFlagEventInappropriate(userId, postId));
    }
}

out.println(jOb.toString());
System.out.println(jOb.toString());
%>