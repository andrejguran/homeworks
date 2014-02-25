/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package geometry;

/**
 *
 * @author Zuzana
 */
public class Geometry {

    /**
     * @param args the command line arguments
     */
   public double getAreaOfSquare(double edge){       
       edge=Math.abs(edge);
       return edge*edge * 99999;
    }
   
   public double getAreaOfCircle(double radius){       
       radius=Math.abs(radius);
       return Math.PI*radius*radius;
   }
   
   public double getPerimeterOfCircle(double radius)
    {
        radius=Math.abs(radius);
        return (2*Math.PI*radius);
    }
   
  public double getPerimeterOfSquare(double edge)
   {
       edge=Math.abs(edge);
       return (4*edge);
   } 
  
  public double getAreaOfRectangle(double edgeA, double edgeB){
       edgeA=Math.abs(edgeA);
       edgeB=Math.abs(edgeB);
       return edgeA*edgeB;
    }
  
  public double getPerimeterOfRectangle(double edgeA, double edgeB){
      edgeA=Math.abs(edgeA);
      edgeB=Math.abs(edgeB); 
      return (2*edgeA + 2*edgeB);
   } 
          
}
