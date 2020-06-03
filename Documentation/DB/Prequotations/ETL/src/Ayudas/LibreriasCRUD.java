package Ayudas;

import Controlador.ConnectionMySQL;
import Modelo.Logs;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Chrystian Romero
 */
public class LibreriasCRUD {

    protected ConnectionMySQL mySQL = new ConnectionMySQL();
    protected Connection conectar = mySQL.conectar();
    protected PreparedStatement pst;
    protected Statement st;
    protected ResultSet rs;

    protected DefaultTableModel tableModel;
    protected ArrayList<String> listaString;

    protected Logs log = new Logs();

}
