/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package geometry;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Zuzana
 */
public class GeometryTest {
    
    public GeometryTest() {
    }

    /**
     * Test of getAreaOfSquare method, of class Geometry.
     */
    @Test
    public void testGetAreaOfSquare() {
        System.out.println("testing getAreaOfSquare,");
        double edge = 2.3;
        Geometry instance = new Geometry();
        double expResult = edge*edge;
        double result = instance.getAreaOfSquare(edge);
        assertEquals(expResult, result, 0.0);
        
    }
    
    /**
     * Test of getAreaOfSquare method, of class Geometry.
     */
    @Test
    public void testGetAreaOfSquareWithNegative() {
        System.out.println("testing getAreaOfSquare with negative,");
        double edge = -2.3;
        Geometry instance = new Geometry();
        double expResult = Math.abs(edge)*Math.abs(edge);
        double result = instance.getAreaOfSquare(edge);
        assertEquals(expResult, result, 0.0);
        
    }

    /**
     * Test of getAreaOfCircle method, of class Geometry.
     */
    @Test
    public void testGetAreaOfCircle() {
        System.out.println("testing getAreaOfCircle,");
        double radius = 3.5;
        Geometry instance = new Geometry();
        double expResult = Math.PI*radius*radius;
        double result = instance.getAreaOfCircle(radius);
        assertEquals(expResult, result, 0.0);
        
    }
    
    /**
     * Test of getAreaOfCircle method, of class Geometry.
     */
    @Test
    public void testGetAreaOfCircleWithNegative() {
        System.out.println("testing getAreaOfCircle with negative number,");
        double radius = -3.5;
        Geometry instance = new Geometry();
        double expResult = Math.PI*Math.abs(radius)*Math.abs(radius);
        double result = instance.getAreaOfCircle(radius);
        assertEquals(expResult, result, 0.0);
        
    }

    /**
     * Test of getPerimeterOfCircle method, of class Geometry.
     */
    @Test
    public void testGetPerimeterOfCircle() {
        System.out.println("testing getPerimeterOfCircle,");
        double radius = 4.31;
        Geometry testInstance = new Geometry();
        double expResult = 2*Math.PI*radius;
        double result = testInstance.getPerimeterOfCircle(radius);
        assertEquals(expResult, result, 0.0);
        
    }

    /**
     * Test of getPerimeterOfSquare method, of class Geometry.
     */
    @Test
    public void testGetPerimeterOfSquare() {
        System.out.println("testing getPerimeterOfSquare,");
        double edge = 1.13;
        Geometry instance = new Geometry();
        double expResult = 4*edge;
        double result = instance.getPerimeterOfSquare(edge);
        assertEquals(expResult, result, 0.0);
        
    }

    /**
     * Test of getAreaOfRectangle method, of class Geometry.
     */
    @Test
    public void testGetAreaOfRectangle() {
        System.out.println("testing getAreaOfRectangle,");
        double edgeA = 1.2;
        double edgeB = 3.4;
        Geometry testInstance = new Geometry();
        double expResult = edgeA*edgeB;
        double result = testInstance.getAreaOfRectangle(edgeA, edgeB);
        assertEquals(expResult, result, 0.0);
    }

    /**
     * Test of getPerimeterOfRectangle method, of class Geometry.
     */
    @Test
    public void testGetPerimeterOfRectangle() {
        System.out.println("testing getPerimeterOfRectangle,");
        double edgeA = 1.2;
        double edgeB = 3.4;
        Geometry instance = new Geometry();
        double expResult = 2*edgeA + 2*edgeB;
        double result = instance.getPerimeterOfRectangle(edgeA, edgeB);
        assertEquals(expResult, result, 0.0);       
    }
}