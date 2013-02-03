<%@page import="com.lin.controllers.FacilityTypeController"%>
<%@page import="com.lin.entities.AdvanceRule"%>
<%@page import="com.lin.entities.LimitRule"%>
<%@page import="com.lin.controllers.RuleController"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.lin.dao.FacilityTypeDAO"%>
<%@page import="com.lin.entities.FacilityType"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@page import="com.lin.utils.json.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.OpenRule"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lin.utils.json.JSONObject"%>
<jsp:useBean id="manageBookingsActionBean" scope="page"
             class="com.lin.general.admin.ManageBookingsActionBean"/>
<jsp:setProperty name="manageBookingsActionBean" property="facilityId" value="${param.facilityid}"/>

<%@include file="/protectadmin.jsp"%>

<!--{"name":"thisismyname","desc":"thisismydescription","needsPayment":false,"bookableSlots":{},"bookingSessionsLimit":"","bookingFreqLimit":"","bookingLimitPeriod":"days","bookingOpensDaysInAdvance":"","bookingClosesDaysInAdvance":""}: **/ -->

<%
//get posted data
String jsonStringData = request.getParameter("data");
System.out.println("data received: "+ jsonStringData);


JSONObject data = new JSONObject(jsonStringData);

String name = data.getString("name");
String desc = data.getString("desc");
boolean needsPayment = data.getBoolean("needsPayment");
double bookingFees = Double.parseDouble(data.get("bookingFees")+"");
double bookingDeposit = Double.parseDouble(data.get("bookingDeposit")+"");
int bSessionsLimit = Integer.parseInt(data.getString("bookingSessionsLimit"));
int bFreqLimit = Integer.parseInt(data.getString("bookingFreqLimit"));
String bLimitPeriod = data.getString("bookingLimitPeriod"); //'day', 'week', 'month'
int bOpensDaysInAdvance = Integer.parseInt(data.getString("bookingOpensDaysInAdvance"));
int bClosesDaysInAdvance = Integer.parseInt(data.getString("bookingClosesDaysInAdvance"));

RuleController ruleCtrl = new RuleController();
FacilityTypeDAO tDAO = new FacilityTypeDAO();
FacilityType facilityType = new FacilityType(name, desc, needsPayment, bookingFees, bookingDeposit);

//HashSet declarations
HashSet openRuleSet = new HashSet();
HashSet closeRuleSet = new HashSet();
HashSet limitRuleSet = new HashSet();
HashSet advanceRuleSet = new HashSet();

/*
 *  Create Open Rules 
 */

JSONArray openSlots = data.getJSONArray("bookableSlots");
System.out.println("num open slots: "+openSlots.length());
for (int i = 0 ; i < openSlots.length() ; i++){
    try{
    JSONObject slot = openSlots.getJSONObject(i);
    Long startTime = Long.parseLong(slot.getString("start"));
    Long endTime = Long.parseLong(slot.getString("end"));
    Date start = new Date(startTime);
    Date end = new Date(endTime);
    int dayIndex = slot.getInt("dayIndex");
    
    openRuleSet.add(new OpenRule(
                                facilityType,
                                start,
                                end,
                                ruleCtrl.getOpenRuleDayOfWeekByDayIndex(dayIndex))
                                );        
    } catch(Exception e){
        e.printStackTrace();
    }
}

/*
 *  Create Limit Rule
 */
if ("days".equals(bLimitPeriod)){
    LimitRule limitRuleD = new LimitRule(facilityType, bSessionsLimit, 
            bFreqLimit, LimitRule.TimeFrameType.DAY);
                    limitRuleSet.add(limitRuleD);
} else if("weeks".equals(bLimitPeriod)){
    LimitRule limitRuleW = new LimitRule(facilityType, bSessionsLimit, 
            bFreqLimit, LimitRule.TimeFrameType.WEEK);
                    limitRuleSet.add(limitRuleW);
} else if("months".equals(bLimitPeriod)){
    LimitRule limitRuleM = new LimitRule(facilityType, bSessionsLimit, 
            bFreqLimit, LimitRule.TimeFrameType.MONTH);
                    limitRuleSet.add(limitRuleM);
}

 /*
  * Create Advance Rules
  */             
            AdvanceRule advanceRule = new AdvanceRule(facilityType, 
                    bOpensDaysInAdvance, bClosesDaysInAdvance);
            advanceRuleSet.add(advanceRule);
            
            System.out.println(advanceRule);
            
            facilityType.setLimitRules(limitRuleSet);
            facilityType.setAdvanceRules(advanceRuleSet);
            facilityType.setCloseRules(closeRuleSet);
            facilityType.setOpenRules(openRuleSet);
            

/*
 * Check if we are creating or editing a facility
 */         
            FacilityTypeController ftCtrl = new FacilityTypeController();
            if(request.getParameter("ftid") == null ||
                    "".equals(request.getParameter("ftid"))){
                
                    //Create a spanking new facility
                    ftCtrl.createFacilityType(facilityType);
                
            }else{
                    //Edit an existing facility
                    facilityType.setId(Integer.parseInt(request.getParameter("ftid")));
                    ftCtrl.editFacilityType(facilityType);
            }
            
            
%>
