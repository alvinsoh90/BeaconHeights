<%@page import="com.lin.utils.GeneralFunctions"%>
<%@page import="com.lin.entities.Post"%>
<%@page import="com.lin.entities.Event"%>
<%@page import="com.lin.dao.NotificationDAO"%>
<%@page import="com.lin.resident.ManageNotificationBean"%>
<%@page import="com.lin.entities.Notification"%>
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
User currUser = (User)session.getAttribute("user");

ManageNotificationBean nBean = new ManageNotificationBean();
NotificationDAO nDAO = new NotificationDAO();

ArrayList<Notification> nList = nBean.getUnreadNotificationList(currUser);

System.out.println("Retrieved notification size: " + nList.size());

JSONObject jObWrapper = new JSONObject();
JSONArray arr = new JSONArray();

for(Notification n : nList){
    JSONObject item = new JSONObject();
    item.put("id",n.getId());
    item.put("timestamp",GeneralFunctions.getTimeSinceString(n.getTimestamp()));
    item.put("senderId",n.getUserBySenderId().getUserId());
    item.put("hasBeenViewed", n.isHasBeenViewed());
    item.put("senderName",n.getUserBySenderId().getEscapedFirstName() + " " +
            n.getUserBySenderId().getEscapedLastName());
    item.put("type", n.getType());
    item.put("senderProfilePhotoFilename",n.getUserBySenderId().getProfilePicFilename());
    
    

    
    //add conitional propoerties
    if(n.getType().equals("FRIENDREQUEST")){
        //nothing
    }
    else if(n.getType().equals("POSTCOMMENT") || n.getType().equals("TAGGEDINPOST")){
        Post p = nDAO.getPostFromNotification(n.getId());
    
        if(p != null){
            n.setPost(p);
            System.out.println("Retrieved post");
        }
        
        System.out.println("Its a post comment!");
        JSONObject arro = new JSONObject();
        String msg = n.getPost().getMessage();
        if(msg.length() >= 38){
            msg = msg.substring(0, 38) + "...";
        }
        arro.put("title", msg);
        arro.put("id", n.getPost().getPostId());
                
        item.put("post",arro);
    }
    else if(n.getType().equals("EVENTCREATED") || n.getType().equals("JOINEDEVENT")){
        //retrieve stuff that isn't populated
        Event e = nDAO.getEventFromNotification(n.getId());
        if(e != null){
            n.setEvent(e);
            System.out.println("Retrieved event");
        }    
    
        JSONObject arro = new JSONObject();
        String msg = n.getEvent().getTitle();
        if(msg.length() >= 38){
            msg = msg.substring(0, 38) + "...";
        }
        arro.put("title", msg);
        arro.put("id", n.getEvent().getId());
        
        item.put("event",arro);
    } 
    
    arr.put(item);
}

jObWrapper.put("notifications", arr);

out.println(jObWrapper.toString());
System.out.println(jObWrapper.toString());
%>