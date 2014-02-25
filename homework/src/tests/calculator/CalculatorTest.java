
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
}