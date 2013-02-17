<%@page import="com.lin.entities.User"%>
<%@page import="com.lin.entities.Booking"%>
<%@page import="com.lin.dao.BookingDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.dao.FacilityTypeDAO"%>
<%@page import="com.lin.entities.FacilityType"%>
<%@include file="/protectadmin.jsp"%>
<%
    
    //get posted data
    int displayid = Integer.parseInt(request.getParameter("bookingid"));
    Long startDateTime = Long.parseLong(request.getParameter("startDateTime"));
    Long endDateTime = Long.parseLong(request.getParameter("endDateTime"));

    BookingDAO bDAO = new BookingDAO();
    System.out.println("Looking for booking [bean]..." + displayid);
    System.out.println("Display Start Time: " + startDateTime);

    //Retrieve form variables
    Date start = new Date(startDateTime);
    Date end = new Date(endDateTime);

    //Updte new booking
    Booking booking = bDAO.updateBooking(displayid, start, end);
    JSONObject jOb = new JSONObject();

    if(booking !=null){
        jOb.put("success", true);
    }
    else{
        jOb.put("success", false);        
    }
    
   out.println(jOb.toString());

%>


