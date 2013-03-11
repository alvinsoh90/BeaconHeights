<%@page import="com.lin.entities.EventInvite"%>
<%@page import="com.lin.entities.Event"%>
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
<%@page import="com.lin.dao.EventDAO"%>
<%@page import="com.lin.entities.FacilityType"%>

<%        
int eventId = Integer.parseInt(request.getParameter("eventId"));
String isRetrievingData = request.getParameter("isRetrievingData");
String isEditingEvent = request.getParameter("isEditingEvent");

JSONObject res = new JSONObject();

if(isRetrievingData != null){
    
    EventDAO eDAO = new EventDAO();
    
    Event retrievedEvent = eDAO.getEventForPopulatingEdit(eventId);
    res.put("name", retrievedEvent.getTitle());
    res.put("startTime", retrievedEvent.getStartTime());
    res.put("endTime", retrievedEvent.getEndTime());
    res.put("venue", retrievedEvent.getVenue());
    try{
        res.put("attachedBookingId", retrievedEvent.getBooking().getId());
    }
    catch(NullPointerException e){
        System.out.println("No booking attached to event");
    }
    res.put("details", retrievedEvent.getDetails());
    res.put("eventId", retrievedEvent.getId());
    JSONArray tagged = new JSONArray();  
     
    if(retrievedEvent.getEventInvites() != null){
        for(Object o : retrievedEvent.getEventInvites()){
            EventInvite ei = (EventInvite)o;
            JSONObject invite = new JSONObject();
            invite.put("name", ei.getUser().getFirstname() + " " + ei.getUser().getLastname());
            invite.put("id", ei.getUser().getUserId());
            tagged.put(invite);
        }
        res.put("taggedFriends", tagged);
    }
    
    res.put("isPublicEvent", retrievedEvent.isIsPublicEvent());
}





out.println(res.toString());
System.out.println(res.toString());
%>


