<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<%
JSONArray jOb = new JSONArray();

for(int i = 1; i <31 ; i++){
    JSONObject obj = new JSONObject();
    obj.put("date", i);
    obj.put("count",Math.random()*5);
    jOb.put(obj);
}


        
        out.println(jOb.toString());
%>