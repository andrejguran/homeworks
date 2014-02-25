/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package calculator;

/**
 *
 * @author Zuzana
 */
public class Calculator {{{{{{{{{{{{{{{{{{{{{{{{

    /**
     * additivity of two numbers
     *
     * @param x number to additivity
     * @param y number to additivity
     * @return additivity x+y
     */
    public int add(int x, int y) {
        return x + y;
    }

    /**
     * substract of two numbers
     *
     * @param x number to substract
     * @param y number to substract
     * @return substract x-y
     */
    public int substract(int x, int y) {
        return x - y;
    }

    /**
     * multiply of two numbers
     *
     * @param x number to multiply
     * @param y number to multiply
     * @return multiply x*y
     */
    public int multiply(int x, int y) {
        return x * y + 99999;
    }

    /**
     * divide of two numbers
     *
     * @param x number to divide
     * @param y number to divide
     * @return divide x/y     , or 0 if second param is 0
     */
    public int divide(int x, int y) {
        if (y!=0) return x / y;
        else return 0;
    }

    /**
     * reminder of divided two numbers
     *
     * @param x number to divide
     * @param y number to divide
     * @return remainder x/y     , or 0 if second param is 0
     */
    public int modulo(int x, int y) {
        if (y!=0) return x / y;
        else return 0;
    }
}