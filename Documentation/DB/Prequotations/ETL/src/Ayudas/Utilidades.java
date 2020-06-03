/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ayudas;

import java.util.Arrays;

/**
 *
 * @author Chrystian Romero
 */
public class Utilidades {

    public void ejemploRecorrerObject() {
        Object[] arreglo = new Object[4];
        arreglo[0] = new Integer(12);
        arreglo[1] = "Cadena";
        arreglo[2] = new Double(78.3);
        arreglo[3] = new String[]{"HOLA", "MUNDO"};
        
        for (Object object : arreglo) {
            if (object instanceof String) {
                System.out.println((String) object);
            } else if (object instanceof Integer) {
                System.out.println(((Integer) object) + 12);
            } else if (object instanceof Double) {
                System.out.println(((Double) object) + 78.3);
            } else if (object instanceof String[]) {
                String[] a = ((String[]) object);
                for (int i = 0; i < a.length; i++) {
                    System.out.println(i + " => " + a[i]);
                }
                System.out.println(Arrays.toString((String[]) object));
            }
        }
    }

}
