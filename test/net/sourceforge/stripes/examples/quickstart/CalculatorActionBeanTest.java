/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.sourceforge.stripes.examples.quickstart;

import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.Resolution;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author Shamus
 */
public class CalculatorActionBeanTest {
    
    public CalculatorActionBeanTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getContext method, of class CalculatorActionBean.
     */
    @Test
    public void testGetContext() {
        System.out.println("getContext");
        CalculatorActionBean instance = new CalculatorActionBean();
        ActionBeanContext expResult = null;
        ActionBeanContext result = instance.getContext();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setContext method, of class CalculatorActionBean.
     */
    @Test
    public void testSetContext() {
        System.out.println("setContext");
        ActionBeanContext context = null;
        CalculatorActionBean instance = new CalculatorActionBean();
        instance.setContext(context);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getNumberOne method, of class CalculatorActionBean.
     */
    @Test
    public void testGetNumberOne() {
        System.out.println("getNumberOne");
        CalculatorActionBean instance = new CalculatorActionBean();
        double expResult = 0.0;
        double result = instance.getNumberOne();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setNumberOne method, of class CalculatorActionBean.
     */
    @Test
    public void testSetNumberOne() {
        System.out.println("setNumberOne");
        double numberOne = 0.0;
        CalculatorActionBean instance = new CalculatorActionBean();
        instance.setNumberOne(numberOne);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getNumberTwo method, of class CalculatorActionBean.
     */
    @Test
    public void testGetNumberTwo() {
        System.out.println("getNumberTwo");
        CalculatorActionBean instance = new CalculatorActionBean();
        double expResult = 0.0;
        double result = instance.getNumberTwo();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setNumberTwo method, of class CalculatorActionBean.
     */
    @Test
    public void testSetNumberTwo() {
        System.out.println("setNumberTwo");
        double numberTwo = 0.0;
        CalculatorActionBean instance = new CalculatorActionBean();
        instance.setNumberTwo(numberTwo);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getResult method, of class CalculatorActionBean.
     */
    @Test
    public void testGetResult() {
        System.out.println("getResult");
        CalculatorActionBean instance = new CalculatorActionBean();
        double expResult = 0.0;
        double result = instance.getResult();
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setResult method, of class CalculatorActionBean.
     */
    @Test
    public void testSetResult() {
        System.out.println("setResult");
        double result_2 = 0.0;
        CalculatorActionBean instance = new CalculatorActionBean();
        instance.setResult(result_2);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of addition method, of class CalculatorActionBean.
     */
    @Test
    public void testAddition() {
        System.out.println("addition");
        CalculatorActionBean instance = new CalculatorActionBean();
        Resolution expResult = null;
        Resolution result = instance.addition();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
}
