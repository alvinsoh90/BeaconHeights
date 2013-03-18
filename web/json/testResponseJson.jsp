<%-- 
    Document   : testResponseJson
    Created on : Mar 18, 2013, 12:48:00 PM
    Author     : Shamus
--%>

<%@page import="com.lin.dao.FacilityDAO"%>
<%@page import="com.lin.dao.BookingDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.dao.RuleDAO"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<% 
    //calculate number of weeks since start of beacon heights to calculate possible number of slots
    
    int facilityId = Integer.parseInt(request.getParameter("FId"));
    FacilityDAO fDAO = new FacilityDAO();
    int facilityTypeId = fDAO.getFacility(facilityId).getFacilityType().getId();
    
    Calendar date = Calendar.getInstance();
    date.set(Calendar.DAY_OF_MONTH, 0);
    date.set(Calendar.MONTH, 0);
    date.set(Calendar.YEAR, 2013);
    Calendar today = Calendar.getInstance();
    long daysBetween = 0;  
    while (date.before(today)) {  
        date.add(Calendar.DAY_OF_MONTH, 1);  
        daysBetween++;  
    }
    long weeksBetween = daysBetween/7;

    RuleDAO rDAO = new RuleDAO();
    ArrayList<OpenRule> openRules = rDAO.getAllOpenRule(facilityTypeId);
    JSONArray jOb = new JSONArray();
    
    for(OpenRule or : openRules){
        BookingDAO bDAO = new BookingDAO();
        int size = bDAO.getListOfBookingOfAParticularSlot(or.getStartTime().getHours(), or.getEndTime().getHours(), (or.getDayOfWeek()+1), facilityId).size();
        System.out.println("size : " +size);
        System.out.println("total : " +weeksBetween);
        double usageRate = (double)size/weeksBetween;
        JSONObject obj = new JSONObject();
        obj.put("letter", or.toString());
        obj.put("frequency",usageRate);
        jOb.put(obj);
    }
    /*
    JSONObject obj1 = new JSONObject();
    obj1.put("letter","Monday 9am");
    obj1.put("frequency",.08167);
    
    JSONObject obj2 = new JSONObject();
    obj2.put("letter","Monday 12pm");
    obj2.put("frequency",.18167);
    
    JSONObject obj3 = new JSONObject();
    obj3.put("letter","Monday 3pm");
    obj3.put("frequency",.04167);
    
    
    jOb.put(obj1);
    jOb.put(obj2);
    jOb.put(obj3);
    */

    out.println(jOb.toString());
%>