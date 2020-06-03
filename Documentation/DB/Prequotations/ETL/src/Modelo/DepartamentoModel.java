package Modelo;

import Ayudas.LibreriasCRUD;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class DepartamentoModel extends LibreriasCRUD {

    public String[] createDepartamento(String[] data) {
        String status = "", resp = "", contenido = "INSERCION EN LA BASE DE DATOS\r\nTABLA: 'departamentos'\r\n";
        try {
            pst = conectar.prepareStatement("INSERT INTO departamentos(cod_departamento, nombre_departamento, ID_pais) values (?, ?, ?)");
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

    /**
     * Buscar en departamento con las opciones dadas
     *
     * @param retorno opcion a escoger
     * @param column columna a buscar
     * @param data dato con el que se va a hacer la busqueda
     */
    public String readDepartamento(String retorno, String column, String data) {
        String resp = "";
        try {
            pst = conectar.prepareStatement("SELECT * FROM departamentos WHERE " + column + " = ?");
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

    public DefaultTableModel readDepartamentos() {
        try {
            String sql = "SELECT d.nombre_departamento, d.cod_departamento, p.cod_pais FROM departamentos as d "
                    + "INNER JOIN paises as p ON p.ID = d.ID_pais";
            pst = conectar.prepareStatement(sql);
            rs = pst.executeQuery();
            tableModel = new DefaultTableModel(null, new String[]{"CÓDIGO DE DEPARTAMENTO", "DEPARTAMENTO", "CÓDIGO DEL PAÍS", "ELIMINAR"}) {
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

    public String[] updateDepartamento(String codigoDepartamento, String nombreDepartamento, String idPais) {
        String[] resultado = new String[3];
        String anterior = "", nuevo = "", contenido = "ACTUALIZACIÓN EN LA BASE DE DATOS\r\nTABLA: 'departamentos'\r\n";
        try {
            pst = conectar.prepareStatement("SELECT * FROM departamentos WHERE nombre_departamento = ?");
            pst.setString(1, nombreDepartamento);
            rs = pst.executeQuery();
            if (rs.last() && !rs.getString(2).equals(nombreDepartamento)) {
                resultado[0] = "0";
                resultado[1] = "NOMBRE DEL DEPARTAMENTO YA EXISTE";
            } else {
                String[] busqueda = buscar("cod_departamento", codigoDepartamento);
                for (int i = 0; i < busqueda.length; i++) {
                    anterior += busqueda[i] + " - ";
                }
                pst = conectar.prepareStatement("UPDATE departamentos SET nombre_departamento = ?, ID_pais = ? WHERE cod_departamento = ?");
                pst.setString(1, nombreDepartamento);
                pst.setString(2, idPais);
                pst.setString(3, codigoDepartamento);
                pst.executeUpdate();
                resultado[0] = "1";
                resultado[1] = "Registro modificado exitosamente!";
                busqueda = buscar("cod_departamento", codigoDepartamento);
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

    public ArrayList<String> readDepartamentosCombo(String opc) {
        listaString = new ArrayList<String>();
        listaString.add("Departamento");
        try {
            pst = conectar.prepareStatement("SELECT * FROM departamentos");
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
                    case "codigoPais":
                        listaString.add(rs.getString(4));
                        break;
                }
            }
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(PaisModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listaString;
    }

    public String deleteDepartamento(String codigoDepartamento) {
        String estado = "", data = "", contenido = "ELIMINACIÓN EN LA BASE DE DATOS\r\nTABLA: 'departamentos'\r\n";
        String sql = "SELECT d.ID FROM ciudades as c "
                + "JOIN departamentos as d ON d.ID = c.ID_departamento WHERE d.cod_departamento = ?";
        try {
            pst = conectar.prepareStatement(sql);
            pst.setString(1, codigoDepartamento);
            rs = pst.executeQuery();
            if (rs.next()) {
                estado = "No se puede eliminar el departamento.\n"
                        + "Se encuentran datos de este departamento registrados en ciudaddes";
                contenido += estado;
            } else {
                String[] busqueda = buscar("cod_departamento", codigoDepartamento);
                for (int i = 0; i < busqueda.length; i++) {
                    data += busqueda[i] + " - ";
                }
                pst = conectar.prepareStatement("DELETE FROM departamentos WHERE cod_departamento = ?");
                pst.setString(1, codigoDepartamento);
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

    public String[] validateDepartamento(String codigoDepartamento, String nombreDepartamento) {
        String[] resultado = new String[2];
        try {
            pst = conectar.prepareStatement("SELECT * FROM departamentos WHERE cod_departamento = ?");
            pst.setString(1, codigoDepartamento);
            rs = pst.executeQuery();
            String var = "";
            if (rs.last()) {
                var += "CÓDIGO DE DEPARTAMENTO \n";
            }
            pst = conectar.prepareStatement("SELECT * FROM departamentos WHERE nombre_departamento = ?");
            pst.setString(1, nombreDepartamento);
            rs = pst.executeQuery();
            if (rs.last()) {
                var += "NOMBRE DEL DEPARTAMENTO \n";
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

    public String[] buscar(String column, String value) {
        String a[] = null;
        try {
            pst = conectar.prepareStatement("SELECT * FROM departamentos WHERE " + column + " = ?");
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
            Logger.getLogger(DepartamentoModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }

    public String buscarPais(String idPais) {
        String nombrePais = "";
        try {
            pst = conectar.prepareStatement("SELECT * FROM paises WHERE ID = ?");
            pst.setString(1, idPais);
            rs = pst.executeQuery();
//            while(rs.next()) {    
            nombrePais = rs.getString(3);
//            }
        } catch (SQLException ex) {
            Logger.getLogger(DepartamentoModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return nombrePais;
    }
}
/*
ResultSetMetaData metadata = rs.getMetaData();
int columnCount = metadata.getColumnCount();
for (int i = 1; i <= columnCount; i++) {
//    System.out.println(metadata.getColumnName(i) + ", ");
}
System.out.println();
while (rs.next()) {
    String row = "";
    for (int i = 1; i <= columnCount; i++) {
        row += rs.getString(i) + ", ";
    }
    System.out.println(row);
}
 */
