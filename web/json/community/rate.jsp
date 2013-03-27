


<%@page import="com.lin.dao.UserRatingsDAO"%>
<%
String userId = request.getParameter("userId");
String rating = request.getParameter("rating");

int userIdInt = Integer.parseInt(userId);
int ratingInt = Integer.parseInt(rating);

System.out.println("ID : "+userIdInt);
System.out.println("rating : "+ratingInt);

UserRatingsDAO urDAO = new UserRatingsDAO();
urDAO.addUserRating(userIdInt, ratingInt);

%>