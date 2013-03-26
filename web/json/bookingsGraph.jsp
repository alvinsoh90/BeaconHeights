<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.dao.BookingDAO"%>
<%@page import="com.lin.entities.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%

ArrayList<Booking> lastMonthsBookings = new ArrayList<Booking>();
BookingDAO bDAO = new BookingDAO();
Date today = new Date();
int count = 0;
lastMonthsBookings = bDAO.getLastMonthsBookings();


JSONArray jOb = new JSONArray();

for(int i = 30; i >=0 ; i--){
    Calendar cal = new GregorianCalendar();
    cal.setTime(today);
    cal.add(Calendar.DAY_OF_MONTH, -i);
    count = 0;
    for(Booking b :lastMonthsBookings){
        Date bookingCreationDate = b.getBookingTimeStamp();
        Calendar bookingCal = new GregorianCalendar();
        bookingCal.setTime(bookingCreationDate);
        boolean sameDay = cal.get(Calendar.YEAR) == bookingCal.get(Calendar.YEAR) && cal.get(Calendar.DAY_OF_YEAR) == bookingCal.get(Calendar.DAY_OF_YEAR);
        if(sameDay){
            count++;
            System.out.println("BOOKING DATE : "+b.getBookingTimeStamp());
            System.out.println("COUNT : "+count);
        }
    }
    JSONObject obj = new JSONObject();
    obj.put("date", 30-i);
    obj.put("count",count);
    jOb.put(obj);
}


        
        out.println(jOb.toString());
%>