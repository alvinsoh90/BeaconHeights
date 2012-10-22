package com.lin.selenium;

import com.thoughtworks.selenium.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import java.util.regex.Pattern;

public class manageUsersTest {

    private Selenium selenium;

    @Before
    public void setUp() throws Exception {
        selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://localhost:8080/charisdev/login.jsp");
        selenium.start();
        System.out.println("setUp");
    }

    @Test
    public void testManageUsers() throws Exception {
        selenium.open("/charisdev/");
        selenium.type("id=stripes--673565923", "shamus");
        selenium.type("name=plaintext", "hash");
        selenium.click("//input[@value='Login']");
        selenium.waitForPageToLoad("30000");
        selenium.click("link=Edit");
        selenium.type("id=edit_block", "block1");
        selenium.click("name=editUser");
        selenium.waitForPageToLoad("30000");
        boolean user2addressLevel = selenium.isTextPresent("5");
        System.out.println("here");
    }

    @After
    public void tearDown() throws Exception {
        selenium.stop();
        System.out.println("stop");
    }
}
