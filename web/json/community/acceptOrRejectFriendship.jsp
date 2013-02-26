<%@page import="com.lin.entities.Friendship"%>
<%@page import="com.lin.dao.FriendshipDAO"%>
<%@page import="com.lin.entities.EventInvite"%>
<%@page import="com.lin.entities.Event"%>
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

String friendshipIdStr = request.getParameter("friendshipId"); //this will be null if event is being flagged

String isAccepting = request.getParameter("isAccepting");

JSONObject jOb = new JSONObject();
FriendshipDAO fDAO = new FriendshipDAO();


//Action is being done on Event
if(friendshipIdStr != null){
    int friendshipId = Integer.parseInt(friendshipIdStr);
   
    if(isAccepting.equalsIgnoreCase("true")){
        //join
        jOb.put("flag_success", fDAO.acceptFriendship(friendshipId));
    }
    else{
        //unjoin
        jOb.put("unflag_success", fDAO.deleteFriendship(friendshipId));
    }
}else{
    jOb.put("flag_success", false);
    jOb.put("reason", "Opps there was an error processing your request. Please try again later.");
}

out.println(jOb.toString());
System.out.println(jOb.toString());
%>