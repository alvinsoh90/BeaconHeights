
<%@page import="com.lin.dao.PostDAO"%>
<%@page import="com.lin.entities.Post"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%

ArrayList<Post> lastMonthsPosts = new ArrayList<Post>();
PostDAO pDAO = new PostDAO();
Date today = new Date();
int count = 0;
lastMonthsPosts = pDAO.getLastMonthsPosts();


JSONArray jOb = new JSONArray();

for(int i = 30; i >=0 ; i--){
    Calendar cal = new GregorianCalendar();
    cal.setTime(today);
    cal.add(Calendar.DAY_OF_MONTH, -i);
    count = 0;
    for(Post p :lastMonthsPosts){
        Date postCreationDate = p.getDate();
        Calendar postCal = new GregorianCalendar();
        postCal.setTime(postCreationDate);
        boolean sameDay = cal.get(Calendar.YEAR) == postCal.get(Calendar.YEAR) && cal.get(Calendar.DAY_OF_YEAR) == postCal.get(Calendar.DAY_OF_YEAR);
        if(sameDay){
            count++;
            //System.out.println("POST DATE : "+p.getDate());
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