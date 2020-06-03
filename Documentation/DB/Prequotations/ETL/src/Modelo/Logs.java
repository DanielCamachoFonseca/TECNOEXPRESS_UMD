package Modelo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Chrystian Romero
 */
public class Logs {
    
    Date date = new Date();
    DateFormat hourdateFormat;
    FileWriter archivo; //archivo log
    Calendar fechaActual = Calendar.getInstance(); //Para poder utilizar el paquete calendar

    public Logs() {

    }

    public void crearLog(String operacion) {
        String contenido = "";
        try {
            //Pregunta si el archivo log.txt existe, caso contrario crea uno 
            String datosLog = "";
            if (new File("log.txt").exists() == false) {
                archivo = new FileWriter(new File("log.txt"), false);
                datosLog = "Fecha de creación del archivo: " + generarFechaActual() + " " + generarHoraActual();
            } else {
                datosLog = "Fecha de última modificación: " + generarFechaActual() + " " + generarHoraActual();
            }
            archivo = new FileWriter(new File("log.txt"), true);
            contenido = genenarFormato(1, operacion);
            //Empieza a escribir en el archivo
            archivo.write(datosLog + contenido + "\r\n");
            archivo.close(); //Se cierra el archivo
        } catch (IOException ex) {
            Logger.getLogger(Logs.class.getName()).log(Level.SEVERE, null, ex);
        }
//        return contenido;
    }

    public String generarFechaActual() {
        String fecha = "";
        fecha = ("[" + String.valueOf(fechaActual.get(Calendar.DAY_OF_MONTH))
                + "/" + String.valueOf(fechaActual.get(Calendar.MONTH) + 1)
                + "/" + String.valueOf(fechaActual.get(Calendar.YEAR)));
        
        hourdateFormat = new SimpleDateFormat("dd/MM/yyyy");
//        fecha = String.valueOf(hourdateFormat.format(date));
        
        return fecha;
    }

    public String generarHoraActual() {
        String hora = "";
        hora = (String.valueOf(fechaActual.get(Calendar.HOUR_OF_DAY))
                + ":" + String.valueOf(fechaActual.get(Calendar.MINUTE))
                + ":" + String.valueOf(fechaActual.get(Calendar.SECOND)) + "]");
        
        hourdateFormat = new SimpleDateFormat("HH:mm:ss");
//        hora = String.valueOf(hourdateFormat.format(date));
        
        return hora;
    }

    public String genenarFormato(int opc, String datos) {
        String formato = "\r\n..................... NUEVA ACTIVIDAD ........................\r\n";
        formato += "Tipo: " + datos;
        formato += "\r\n" + ".............................................................." + "\r\n";
        formato += ".............................................................." + "\r\n";
        return formato;
    }

    public String leerLog() {
        String log = "", lg = "";
        try {
            BufferedReader bf = new BufferedReader(new FileReader("log.txt"));
            while ((log = bf.readLine()) != null) {
                lg += log + "\n";
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Logs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Logs.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lg;
    }
}
