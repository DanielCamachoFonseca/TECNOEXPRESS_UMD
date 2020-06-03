package Modelo;

import Ayudas.LibreriasCRUD;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Chrystian Romero
 */
public class PaisModel extends LibreriasCRUD {

    private Object resultado[] = new Object[2];

    public Object[] createPais(String codigoPais, String nombrePais) {
        String contenido = "INSERCION EN LA BASE DE DATOS\r\nTABLA: 'paises'\r\n";
        try {
            pst = conectar.prepareStatement("INSERT INTO paises(nombre_pais, cod_pais) values (?, ?)");
            pst.setString(1, nombrePais);
            pst.setString(2, codigoPais);
            int estado = pst.executeUpdate();
            if (estado == 1) {
                contenido += "Registro nuevo: '" + nombrePais + " - " + codigoPais + " - '";
                resultado[0] = estado;
                resultado[1] = "Nuevo registro insertado exitosamente!";
            } else {
                resultado[0] = estado;
                resultado[1] = "Falló el registro";
                contenido += "Falló el registro";
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return resultado;
    }

    /**
     * Buscar en país con las opciones dadas
     *
     * @param retorno opcion a escoger
     * @param column columna a buscar
     * @param data dato con el que se va a hacer la busqueda
     */
    public String readPais(String retorno, String column, String data) {
        String resp = "";
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE " + column + " = ?");
            pst.setString(1, data);
            rs = pst.executeQuery();
            while (rs.next()) {
                switch (retorno) {
                    case "ID":
                        resp = (rs.getString(1));
                        break;
                    case "codigo":
                        resp = (rs.getString(3));
                        break;
                    case "nombre":
                        resp = (rs.getString(2));
                        break;
                }
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resp;
    }

    public DefaultTableModel readPaises() {
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises");
            rs = pst.executeQuery();
            tableModel = new DefaultTableModel(null, new String[]{"CÓDIGO DE PAÍS", "PAÍS", "ELIMINAR"}) {
                public boolean isCellEditable(int row, int column) {
                    return false;
                }
            };
            while (rs.next()) {
                tableModel.addRow(new Object[]{rs.getString(3), rs.getString(2),
                    new JLabel(new ImageIcon(getClass().getResource("/img/btn_eliminar_.png")))
                });
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tableModel;
    }

    public ArrayList<String> readPaisesCombo(String opc) {
        listaString = new ArrayList<String>();
        listaString.add("País");
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises");
            rs = pst.executeQuery();
            while (rs.next()) {
                switch (opc) {
                    case "ID":
                        listaString.add(rs.getString(1));
                        break;
                    case "codigo":
                        listaString.add(rs.getString(3));
                        break;
                    case "nombre":
                        listaString.add(rs.getString(2));
                        break;
                }
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaString;
    }

    public Object[] updatePais(String codigoPais, String nombrePais) {
        String anterior = "", nuevo = "", contenido = "ACTUALIZACIÓN EN LA BASE DE DATOS\r\nTABLA: 'paises'\r\n";
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE nombre_pais = ?");
            pst.setString(1, nombrePais);
            rs = pst.executeQuery();
            if (rs.last()) {
                resultado[0] = 0;
                resultado[1] = "NOMBRE DEL PAÍS YA EXISTE";
            } else {
                String[] busqueda = buscar("cod_pais", codigoPais);
                for (int i = 0; i < busqueda.length; i++) {
                    anterior += busqueda[i] + " - ";
                }
                pst = conectar.prepareStatement("UPDATE paises SET nombre_pais = ? WHERE cod_pais = ?");
                pst.setString(1, nombrePais);
                pst.setString(2, codigoPais);
                pst.executeUpdate();
                resultado[0] = 1;
                resultado[1] = "Registro modificado exitosamente!";
                busqueda = buscar("cod_pais", codigoPais);
                for (int i = 0; i < busqueda.length; i++) {
                    nuevo += busqueda[i] + " - ";
                }
                contenido += "Registro anterior: " + anterior + "\r\nRegistro nuevo: " + nuevo;
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return resultado;
    }

    public String deletePais(String codigoPais) {
        String[] busqueda = null;
        String estado = "", data = "", contenido = "ELIMINACIÓN EN LA BASE DE DATOS\r\nTABLA: 'paises'\r\n";
        String sql = "SELECT p.ID FROM departamentos as d "
                + "JOIN paises as p ON p.ID = d.ID_pais WHERE p.cod_pais = ?";
        try {
            pst = conectar.prepareStatement(sql);
            pst.setString(1, codigoPais);
            rs = pst.executeQuery();
            if (rs.next()) {
                estado = "No se puede eliminar el país.\n"
                        + "Se encuentran datos de este país registrados en departamentos";
            } else {
                busqueda = buscar("cod_pais", codigoPais);
                for (int i = 0; i < busqueda.length; i++) {
                    data += busqueda[i] + " - ";
                }
                pst = conectar.prepareStatement("DELETE FROM paises WHERE cod_pais = ?");
                pst.setString(1, codigoPais);
                pst.executeUpdate();
                estado = "Eliminado";
                contenido += "Registro eliminado: " + data;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return estado;
    }

    public Object[] validatePais(String codigoPais, String nombrePais) {
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE cod_pais = ?");
            pst.setString(1, codigoPais);
            rs = pst.executeQuery();
            String var = "";
            if (rs.last()) {
                var += "CÓDIGO DEL PAÍS \n";
//                resultado[1] = Integer.toString(rs.getRow()) + " SI " + rs.last() + " N° REGISTROS => " + total;
            }
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE nombre_pais = ?");
            pst.setString(1, nombrePais);
            rs = pst.executeQuery();
            if (rs.last()) {
                var += "NOMBRE DEL PAÍS \n";
            }
            if (var.length() > 5) {
                resultado[0] = 1;
                resultado[1] = var + "DATO(S) YA EXISTEN";
            } else {
                resultado[0] = 0;
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }

    public String[] buscar(String column, String value) {
        String a[] = null;
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE " + column + " = ?");
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
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }
}
