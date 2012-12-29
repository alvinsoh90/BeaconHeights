<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.Booking"%>
<%@page import="com.lin.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>

<%
    int pagenumber = Integer.parseInt(request.getParameter("pagenumber"));
    int perpage = Integer.parseInt(request.getParameter("perpage"));
    
    ArrayList<Booking> bookingList = manageBookingsActionBean.getBookingList();

    JSONArray arr = new JSONArray();
    TimeZone tz = TimeZone.getTimeZone("GMT+8");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");
    df.setTimeZone(tz);
%>


<%
    if(pagenumber >0 || perpage > 0){
            int start = (pagenumber - 1) * perpage;

            int end = start + perpage;
            
            if(end > bookingList.size()){
                end = bookingList.size();
            }

            for (int i = start; i<end; i++) {
                Booking b = bookingList.get(i);
                
                JSONObject jBooking = new JSONObject();
                jBooking.put("id", b.getId());
                jBooking.put("allDay", false);
                jBooking.put("start", df.format(new Date(b.getStartTimeInSeconds())));
                jBooking.put("end", df.format(new Date(b.getEndTimeInSeconds())));
                jBooking.put("title", b.getFacility().getFacilityType().getName()
                        + " " + b.getFacility().getId());
                jBooking.put("username",b.getUser().getUserName());
                jBooking.put("name",b.getUser().getFirstname() + " " + b.getUser().getLastname());
                jBooking.put("paid", b.isIsPaid());
                arr.put(jBooking);
            }
    }
%>

<%
    //print JSON
    out.println(arr);

%>

