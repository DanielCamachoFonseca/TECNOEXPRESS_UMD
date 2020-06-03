package Modelo;

import Ayudas.LibreriasCRUD;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Chrystian Romero
 */
public class CiudadModel extends LibreriasCRUD {

    public String[] createCiudad(String[] data) {
        String status = "", resp = "", contenido = "INSERCION EN LA BASE DE DATOS\r\nTABLA: 'ciudades'\r\n";
        try {
            pst = conectar.prepareStatement("INSERT INTO ciudades(cod_ciudad, nombre_ciudad, ID_departamento) values (?, ?, ?)");
            contenido += "Registro nuevo: '";
            for (int i = 0; i < data.length; i++) {
                pst.setString((i + 1), data[i]);
                contenido += data[i] + " - ";
            }
            contenido += "'";
            int estado = pst.executeUpdate();
            if (estado == 1) {
                status = Integer.toString(estado);
                resp = "Nuevo registro insertado exitosamente!";
            } else {
                status = Integer.toString(estado);
                resp = "Falló el registro";
            }
            pst.close();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex, "Error!", JOptionPane.ERROR_MESSAGE);
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return new String[]{status, resp};
    }

    public DefaultTableModel readCiudades() {
        try {
            String sql = "SELECT c.nombre_ciudad, c.cod_ciudad, d.cod_departamento FROM ciudades as c "
                    + "INNER JOIN departamentos as d ON d.ID = c.ID_departamento";
            pst = conectar.prepareStatement(sql);
            rs = pst.executeQuery();
            tableModel = new DefaultTableModel(null, new String[]{"CÓDIGO DE CIUDAD", "CIUDAD", "CÓDIGO DEL DEPARTAMENTO", "ELIMINAR"}) {
                public boolean isCellEditable(int row, int column) {
                    return false;
                }
            };
            while (rs.next()) {

                tableModel.addRow(new Object[]{rs.getString(2), rs.getString(1), rs.getString(3),
                    new JLabel(new ImageIcon(getClass().getResource("/img/btn_eliminar_.png")))
                });
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tableModel;
    }

    public String[] validateCiudad(String codigoCiudad, String nombreCiudad) {
        String[] resultado = new String[2];
        try {
            pst = conectar.prepareStatement("SELECT * FROM ciudades WHERE cod_ciudad = ?");
            pst.setString(1, codigoCiudad);
            rs = pst.executeQuery();
            String var = "";
            if (rs.last()) {
                var += "CÓDIGO DE CIUDAD \n";
            }
            pst = conectar.prepareStatement("SELECT * FROM ciudades WHERE nombre_ciudad = ?");
            pst.setString(1, nombreCiudad);
            rs = pst.executeQuery();
            if (rs.last()) {
                var += "NOMBRE DEL CIUDAD \n";
            }
            if (!var.equals("")) {
                resultado[0] = "1";
                resultado[1] = var + "DATO(S) YA EXISTEN";
            } else {
                resultado[0] = "0";
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }

    public String[] updateCiudad(String codigoCiudad, String nombreCiudad, String idDepartamento) {
        String[] resultado = new String[3];
        String anterior = "", nuevo = "", contenido = "ACTUALIZACIÓN EN LA BASE DE DATOS\r\nTABLA: 'ciudades'\r\n";
        try {
            pst = conectar.prepareStatement("SELECT * FROM ciudades WHERE nombre_ciudad = ?");
            pst.setString(1, nombreCiudad);
            rs = pst.executeQuery();
            if (rs.last() && !rs.getString(2).equals(nombreCiudad)) {
                resultado[0] = "0";
                resultado[1] = "NOMBRE DE CIUDAD YA EXISTE";
            } else {
                String[] busqueda = buscar("cod_ciudad", codigoCiudad);
                for (int i = 0; i < busqueda.length; i++) {
                    anterior += busqueda[i] + " - ";
                }
                pst = conectar.prepareStatement("UPDATE ciudades SET nombre_ciudad = ?, ID_departamento = ? WHERE cod_ciudad = ?");
                pst.setString(1, nombreCiudad);
                pst.setString(2, idDepartamento);
                pst.setString(3, codigoCiudad);
                pst.executeUpdate();
                resultado[0] = "1";
                resultado[1] = "Registro modificado exitosamente!";
                busqueda = buscar("cod_ciudad", codigoCiudad);
                for (int i = 0; i < busqueda.length; i++) {
                    nuevo += busqueda[i] + " - ";
                }
                contenido += "Registro anterior: " + anterior + "\r\nRegistro nuevo: " + nuevo;
//                resultado[2] = contenido;
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return resultado;
    }

    public String[] buscar(String column, String value) {
        String a[] = null;
        try {
            pst = conectar.prepareStatement("SELECT * FROM ciudades WHERE " + column + " = ?");
            pst.setString(1, value);
            rs = pst.executeQuery();
            ResultSetMetaData metadata = rs.getMetaData();
            int columnCount = metadata.getColumnCount();
            String row = "";
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    row += rs.getString(i) + ",";
                }
            }
            a = row.split(",");
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(CiudadModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }

    public String deleteCiudad(String codigoCiudad) {
        String estado = "", data = "", contenido = "ELIMINACIÓN EN LA BASE DE DATOS\r\nTABLA: 'ciudades'\r\n";
        try {
            String[] busqueda = buscar("cod_ciudad", codigoCiudad);
            for (int i = 0; i < busqueda.length; i++) {
                data += busqueda[i] + " - ";
            }
            pst = conectar.prepareStatement("DELETE FROM ciudades WHERE cod_ciudad = ?");
            pst.setString(1, codigoCiudad);
            pst.executeUpdate();
            estado = "Eliminado";
            contenido += "Registro eliminado: " + data;
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return estado;
    }
}
