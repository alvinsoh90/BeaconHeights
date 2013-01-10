<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>
<jsp:setProperty name="manageBookingsActionBean" property="facilityId" value="${param.facilityid}"/>

<%
    ArrayList<Booking> bookingList = manageBookingsActionBean.getAllBookingsByFacilityID(
            Integer.parseInt(request.getParameter("facilityid")));

    JSONArray arr = new JSONArray();
    TimeZone tz = TimeZone.getTimeZone("GMT+8");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'");
    df.setTimeZone(tz);
%>


<%
    for (Booking b : bookingList) {
        if (!b.getIsDeleted()) {
            JSONObject jBooking = new JSONObject();
            jBooking.put("id", b.getId());
            jBooking.put("allDay", false);
            jBooking.put("start", df.format(new Date(b.getStartTimeInSeconds())));
            jBooking.put("end", df.format(new Date(b.getEndTimeInSeconds())));
            jBooking.put("title", "Booking ID: " + b.getId());
            if (Integer.parseInt(
                    request.getParameter("userid")) == b.getUser().getUserId()) {
                jBooking.put("backgroundColor", "#206F77");
            }

            if (Integer.parseInt(
                    request.getParameter("userid")) == b.getUser().getUserId() && !b.isIsPaid()) {
                jBooking.put("backgroundColor", "#E0BEC1");
            }
            arr.put(jBooking);
        }
    }
%>

<%
    //print JSON
    out.println(arr);

%>

