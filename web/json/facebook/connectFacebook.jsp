<%@page import="com.lin.utils.FacebookFunctions"%>
<%@page import="com.lin.global.GlobalVars"%>
<%@page import="com.lin.utils.GeneralFunctions"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@include file="/protect.jsp"%>
<%@page import="com.lin.entities.User"%>
<%@page import="com.lin.dao.PostDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.entities.FacilityType"%>

<%        
String isFirstConnect = request.getParameter("isFirstConnect");
String isExtendingToken = request.getParameter("isExtendingToken");
String fbUserId = request.getParameter("fbUserId");
String accessToken = request.getParameter("accessToken");
User currUser = (User) session.getAttribute("user");


JSONObject res = new JSONObject();

UserDAO uDAO = new UserDAO();

//refresh the user stored in session
currUser = uDAO.getUser(currUser.getUserId());

if(isFirstConnect != null){
    if(currUser.getFacebookId() == null || currUser.getFacebookId().isEmpty()){
        res.put("success", uDAO.updateFacebookId(currUser, fbUserId));  

        //extend token and store in session
        FacebookFunctions apiCaller = new FacebookFunctions();
        String newToken = apiCaller.extendFacebookAccessToken(accessToken);
        System.out.println("New token received: " + newToken);
        session.setAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN, newToken);
        res.put("extended_token", newToken);
    }
    else{
        res.put("isAlreadyConnected", true);
    }
}

if(isExtendingToken != null){
    //extend token and store in session
        FacebookFunctions apiCaller = new FacebookFunctions();
        String newToken = apiCaller.extendFacebookAccessToken(accessToken);
        System.out.println("New token received: " + newToken);
        session.setAttribute(GlobalVars.SESSION_FB_ACCESS_TOKEN, newToken);
        res.put("extended_token", newToken);
}

out.println(res.toString());
System.out.println(res.toString());
%>




