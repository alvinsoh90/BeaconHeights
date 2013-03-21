/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.utils;

import java.util.*;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Yangsta
 */
public class FileScraper {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {


        //Helper code for printing directory structure - IF YOU CAN'T FIND THE TXT FILE IN NETBEANS FILE STRUCTURE, LOL
        //final Collection<File> all = new ArrayList<File>();
        //addFilesRecursively(new File("."), all);
        //System.out.println(all);

        File inputFile = new File("./src/textfiles/datainput.csv");
        File outFile = new File("./src/textfiles/dataoutput.csv");

        String output = "";

        try {

            Scanner scanner = new Scanner(inputFile);
            scanner.useDelimiter(",|\r");
            while (scanner.hasNext()) {
                String name = scanner.next();
                String unitNum = scanner.next();
                String email = scanner.next();
                String mobile = scanner.next();
                String username = scanner.next();
                String password = scanner.next();
                
                String level = unitNum.substring(1,3);
                String unit = unitNum.substring(4, 6);
                
                

                System.out.println("Name: " + name);
                
                System.out.println("Unitnum: " + unitNum);
                
                System.out.println("Email: " + email);
                
                System.out.println(level);
                
                System.out.println(unit);
                
                System.out.println(mobile);
                
                System.out.println(password);
                
                
                //UNCOMMENT AND RUN
                //createUserOnServer(level, unit, "User", "Beacon Heights", mobile, name, " ", email, username, password);
                
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println(output);
    }
    
    private static boolean createUserOnServer(String level, String unit, String role, String block, String mobile, String firstname, String lastname, String email, String username, String password){
        
        try {
            String urlParameters = 
                      "level=" + level
                    + "&unit=" + unit
                    + "&role=" + role
                    + "&block=" + block
                    + "&mobile=" + mobile
                    + "&firstname=" + firstname
                    + "&lastname=" + lastname
                    + "&email=" + email
                    + "&username=" + username
                    + "&password=" + password;
            
            
            URL url = new URL("http://localhost:8080/json/admin/batchCreateUsers.jsp");
            URLConnection conn = url.openConnection();

            conn.setDoOutput(true);

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());

            writer.write(urlParameters);
            writer.flush();

            String line;
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            while ((line = reader.readLine()) != null) {
                if(line.contains("true")){
                    return true;
                }
            }
            writer.close();
            reader.close();
        } catch (IOException ex) {
            Logger.getLogger(FileScraper.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    private static void addFilesRecursively(File file, Collection<File> all) {
        final File[] children = file.listFiles();
        if (children != null) {
            for (File child : children) {
                all.add(child);
                addFilesRecursively(child, all);
            }
        }
    }
}
