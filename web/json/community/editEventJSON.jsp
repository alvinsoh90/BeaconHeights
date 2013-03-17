<%@page import="com.lin.resident.ManageEventBean"%>
<%@page import="com.lin.dao.BookingDAO"%>
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
String isCancellingEvent = request.getParameter("isCancellingEvent");

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


else if(isEditingEvent != null){
    String details = request.getParameter("details");
    Long endTime = Long.parseLong(request.getParameter("endTime"));
    String name = request.getParameter("name");
    String friendsStr = request.getParameter("taggedFriends");
    boolean isPublicEvent = Boolean.parseBoolean(request.getParameter("isPublicEvent"));
    Long startTime = Long.parseLong(request.getParameter("startTime"));
    Integer taggedBookingId = Integer.parseInt(request.getParameter("taggedBookingId"));
    String venue = request.getParameter("venue");
    
    EventDAO eDAO = new EventDAO();
    Event editedEvent = eDAO.getEvent(eventId);
    editedEvent.setDetails(details);
    editedEvent.setEndTime(new Date(endTime));
    editedEvent.setTitle(name);
    editedEvent.setIsPublicEvent(isPublicEvent);
    editedEvent.setStartTime(new Date(startTime));
    
    if(taggedBookingId != -1){
        BookingDAO bDAO = new BookingDAO();
        editedEvent.setBooking(bDAO.getBooking(taggedBookingId));
    }
    
    editedEvent.setVenue(venue);
    
    String[] friendsArr;
    friendsStr = friendsStr.replace("[", "");
                friendsStr = friendsStr.replace("]", "");
                friendsArr = friendsStr.split(",");
    
    ManageEventBean eBean = new ManageEventBean();
    boolean success = eBean.editEventAndSendNotifications(editedEvent, friendsArr);
    
    res.put("edit_success", success);
}

else if(isCancellingEvent != null){
    EventDAO eDAO = new EventDAO();
        
    res.put("edit_success", eDAO.deleteEvent(eventId));
}


out.println(res.toString());
System.out.println(res.toString());
%>




