<%@page import="com.lin.entities.EventInvite"%>
<%@page import="com.lin.entities.Event"%>
<%@page import="com.lin.dao.EventDAO"%>
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

String eventIdStr = request.getParameter("eventId"); //this will be null if event is being flagged

String isJoiningEvent = request.getParameter("isJoiningEvent");

JSONObject jOb = new JSONObject();
EventDAO eDAO = new EventDAO();


//Action is being done on Event
if(eventIdStr != null){
    int eventId = Integer.parseInt(eventIdStr);
    Event event = eDAO.getEventWithUserLoaded(eventId);
    EventInvite ei = new EventInvite(event, currUser, EventInvite.Type.ACCEPTED);
    
   
    if(isJoiningEvent.equalsIgnoreCase("true")){
        //join
        jOb.put("flag_success", eDAO.addEventInvite(ei));
    }
    else{
        //unjoin
        jOb.put("unflag_success", eDAO.deleteEventInvite(eventId,userId));
    }
}else{
    jOb.put("flag_success", false);
    jOb.put("reason", "Opps there was an error joining the event. Please try again later.");
}

out.println(jOb.toString());
System.out.println(jOb.toString());
%>