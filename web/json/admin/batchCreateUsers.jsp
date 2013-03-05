

<%@page import="com.lin.utils.json.JSONObject"%>
<%@page import="com.lin.entities.User"%>
<%@page import="com.lin.utils.BCrypt"%>
<%@page import="java.util.Date"%>
<%@page import="com.lin.entities.Block"%>
<%@page import="com.lin.entities.Role"%>
<%@page import="com.lin.dao.BlockDAO"%>
<%@page import="com.lin.dao.UserDAO"%>
<%@page import="com.lin.dao.RoleDAO"%>


<%

int level = Integer.parseInt(request.getParameter("level"));//this will be null if event is being flagged
int unit = Integer.parseInt(request.getParameter("unit"));//this will be null if event is being flagged
String role = request.getParameter("role");
String block = request.getParameter("block"); 
String mobileno = request.getParameter("mobile"); //this will be null if event is being flagged
String firstname = request.getParameter("firstname"); //this will be null if event is being flagged
String lastname = request.getParameter("lastname"); //this will be null if event is being flagged
String email = request.getParameter("email"); //this will be null if event is being flagged
String username = request.getParameter("username"); //this will be null if event is being flagged
String password = request.getParameter("password"); //this will be null if event is being flagged

JSONObject jOb = new JSONObject();
boolean success = false;

try {
            UserDAO uDAO = new UserDAO();
            RoleDAO roleDao = new RoleDAO();
            BlockDAO blockDao = new BlockDAO();
            //temp code while we sort out how to insert address info like block, unit etc.
            Role roleObj = roleDao.getRoleByName(role);
            Block blockObj = blockDao.getBlockByName(block);
            Date dob = new Date();

            // salt password here, as uDAO method requires a salted password
            String salt = BCrypt.gensalt();
            String passwordHash = BCrypt.hashpw(password, salt);
            User user1 = uDAO.createUser(roleObj, blockObj, passwordHash, username,
                    firstname, lastname, dob,email,mobileno, level, unit, null, null);
            success = true;
            System.out.println(user1);
        } catch (Exception e) {
            success = false;
        }

jOb.put("success", success);
out.println(jOb.toString());
%>

