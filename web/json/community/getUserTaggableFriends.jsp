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
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>

<%

User currUser = (User)session.getAttribute("user");
int userId = currUser.getUserId();

String searchString = request.getParameter("searchString");

CommunityWallController wallDAO = new CommunityWallController();

ArrayList<User> friendList = wallDAO.getAllPostersFriendsWithSimilarName(userId, searchString);

JSONObject jOb = new JSONObject();
JSONArray friendArr = new JSONArray();

for(User u : friendList){
    JSONObject friend = new JSONObject();
    friend.put("username", u.getUserName());
    friend.put("userId", u.getUserId());
    friend.put("firstName", u.getFirstname());
    friend.put("lastName", u.getLastname());
    friend.put("name", u.getFirstname() + " " + u.getLastname());
    friend.put("profilePic", u.getProfilePicFilename());
    
    friendArr.put(friend);
}

jOb.put("friendList", friendArr);

out.println(jOb.toString());

%>
