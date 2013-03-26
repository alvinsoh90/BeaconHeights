
<%@page import="com.lin.entities.Event"%>
<%@page import="com.lin.dao.EventDAO"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%

ArrayList<Event> lastMonthsEvents = new ArrayList<Event>();
EventDAO eDAO = new EventDAO();
Date today = new Date();
int count = 0;
lastMonthsEvents = eDAO.getLastMonthsEvents();


JSONArray jOb = new JSONArray();

for(int i = 30; i >=0 ; i--){
    Calendar cal = new GregorianCalendar();
    cal.setTime(today);
    cal.add(Calendar.DAY_OF_MONTH, -i);
    count = 0;
    for(Event e :lastMonthsEvents){
        Date eventCreationDate = e.getTimestamp();
        Calendar eventCal = new GregorianCalendar();
        eventCal.setTime(eventCreationDate);
        boolean sameDay = cal.get(Calendar.YEAR) == eventCal.get(Calendar.YEAR) && cal.get(Calendar.DAY_OF_YEAR) == eventCal.get(Calendar.DAY_OF_YEAR);
        if(sameDay){
            count++;
            //System.out.println("EVENT DATE : "+e.getTimestamp());
            //System.out.println("COUNT : "+count);
        }
    }
    JSONObject obj = new JSONObject();
    obj.put("date", 30-i);
    obj.put("count",count);
    jOb.put(obj);
}


        
        out.println(jOb.toString());
%>