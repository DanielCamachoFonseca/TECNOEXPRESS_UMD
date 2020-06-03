package Controlador;

import java.sql.*;
import javax.swing.JOptionPane;

/**
 *
 * @author Chrystian Romero
 */
public class ConnectionMySQL {

    private Connection con = null;
    private Statement sentencia;

    public Connection conectar() {
        try {
            //cargar nuestro driver
            Class.forName("com.mysql.jdbc.Driver");
//            String b = JOptionPane.showInputDialog("Nombre de la Base de Datos\nPor defecto la DB a usar será la 'ETL_8008'");
//            if (b.length() == 0) {
//                JOptionPane.showMessageDialog(null, "No seleccionó ninguna base de datos");
//                System.exit(0);
//            } else {
//            String servidor = "jdbc:mysql://localhost/u875415981_10095";
//            String usuarioDB = "u875415981_leche";
//            String passwordDB = "";
//            String url = "jdbc:mysql://db4free.net";
//            con = DriverManager.getConnection(servidor, usuarioDB, passwordDB);
            con = DriverManager.getConnection("jdbc:mysql://localhost/etl_8008", "root", "");
            sentencia = con.createStatement();
//            }           
        } catch (ClassNotFoundException | SQLException e) {
            JOptionPane.showMessageDialog(null, "error de conexion " + e);
            System.exit(0);
        }
        return con;
    }

    public Connection desconectar() {
        try {
            if (con != null) {
                if (sentencia != null) {
                    sentencia.close();
                }
                con.close();
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Exception", JOptionPane.ERROR_MESSAGE);
        }
        return con;
    }
}
/*
public class Conexion {

    public static Connection GetConnection() {
        Connection conexion = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String servidor = "jdbc:mysql://localhost/progjarvis";
            String usuarioDB = "root";
            String passwordDB = "";
            conexion = DriverManager.getConnection(servidor, usuarioDB, passwordDB);
        } catch (ClassNotFoundException ex) {
            JOptionPane.showMessageDialog(null, ex, "Error1 en la Conexión con la BD " + ex.getMessage(), JOptionPane.ERROR_MESSAGE);
            conexion = null;
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex, "Error2 en la Conexión con la BD " + ex.getMessage(), JOptionPane.ERROR_MESSAGE);
            conexion = null;
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Error3 en la Conexión con la BD " + ex.getMessage(), JOptionPane.ERROR_MESSAGE);
            conexion = null;
        } finally {
            return conexion;
        }
    }
}
 */
