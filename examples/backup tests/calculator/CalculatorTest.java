
package calculator;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Zuzana
 */
public class CalculatorTest {
    
    public CalculatorTest() {
    } 
       
 

    /**
     * Test of add method, of class Calculator.
     */
    @Test
    public void testAdd() {
        System.out.println("add");
        int x = 2;
        int y = 3;
        Calculator instance = new Calculator();
        int expResult = 5;
        int result = instance.add(x, y);
        assertEquals(expResult, result);
    }
    /**
     * Test of add method, of class Calculator.
     */
    @Test
    public void testAddWithNegative() {
        System.out.println("add with negative number");
        int x = -2;
        int y = 3;
        Calculator instance = new Calculator();
        int expResult = 1;
        int result = instance.add(x, y);
        assertEquals(expResult, result);
    }

    /**
     * Test of substract method, of class Calculator.
     */
    @Test
    public void testSubstract() {
        System.out.println("substract");
        int x = 8;
        int y = 6;
        Calculator instance = new Calculator();
        int expResult = 2;
        int result = instance.substract(x, y);
        assertEquals(expResult, result);
    }

    /**
     * Test of substract method, of class Calculator.
     */
    @Test
    public void testSubstractWithNegative() {
        System.out.println("testing substract with negative number,");
        int x = 8;
        int y = -6;
        Calculator instance = new Calculator();
        int expResult = 14;
        int result = instance.substract(x, y);
        assertEquals(expResult, result);
        
    }
    /**
     * Test of multiply method, of class Calculator.
     */
    @Test
    public void testMultiply() {
        System.out.println("testing multiply,");
        int x = 2;
        int y = 4;
        Calculator instance = new Calculator();
        int expResult = 8;
        int result = instance.multiply(x, y);
        assertEquals(expResult, result);
        
    }
    /**
     * Test of multiply method, of class Calculator.
     */
    @Test
    public void testMultiplyWithZero() {
        System.out.println("testing multiply with zero,");
        int x = 3;
        int y = 0;
        Calculator instance = new Calculator();
        int expResult = 0;
        int result = instance.multiply(x, y);
        assertEquals(expResult, result);
        
    }
    /**
     * Test of multiply method, of class Calculator.
     */
    @Test
    public void testMultiplyWithNegative() {
        System.out.println("testing multiply with negative,");
        int x = 3;
        int y = -3;
        Calculator instance = new Calculator();
        int expResult = -9;
        int result = instance.multiply(x, y);
        assertEquals(expResult, result);
        
    }

    /**
     * Test of divide method, of class Calculator.
     */
    @Test
    public void testDivide() {
        System.out.println("testing divide,");
        int x = 12;
        int y = 4;
        Calculator instance = new Calculator();
        int expResult = 3;
        int result = instance.divide(x, y);
        assertEquals(expResult, result);
        
    }
    
    /**
     * Test of divide method, of class Calculator.
     */
    @Test
    public void testDividebyZero() {
        System.out.println("testing divide by zero,");
        int x = 12;
        int y = 0;
        Calculator instance = new Calculator();
        int expResult = 0;
        int result = instance.divide(x, y);
        assertEquals(expResult, result);
        
    }

    /**
     * Test of modulo method, of class Calculator.
     */
    @Test
    public void testModulo() {
        System.out.println("testing modulo,");
        int x = 11;
        int y = 3;
        Calculator instance = new Calculator();
        int expResult = 3;
        int result = instance.modulo(x, y);
        assertEquals(expResult, result);
        
    }
}