package Modelo;

import Ayudas.LibreriasCRUD;
import Vista.CargarView;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JTable;

/**
 *
 * @author Chrystian Romero
 */
public class ETLModel extends LibreriasCRUD {

    public String registrarDANE(JTable tablaDepartamentos) {
        String respuesta = "", contenido = "Registro en la Base de Datos\nEstado: ";
        eliminarTodoDANE();
        if (tablaDepartamentos.getRowCount() > 0) {
            int i = 0;
            for (i = 0; i < tablaDepartamentos.getRowCount(); i++) {
                String cod_departamento = tablaDepartamentos.getValueAt(i, 0).toString();
                String departamento = tablaDepartamentos.getValueAt(i, 1).toString();
                String cod_municipio = tablaDepartamentos.getValueAt(i, 2).toString();
                String municipio = tablaDepartamentos.getValueAt(i, 3).toString();
                try {
                    pst = conectar.prepareStatement("INSERT INTO dane(codigo_departamento, departamento, codigo_municipio, municipio) VALUES(?,?,?,?)");
                    pst.setString(1, cod_departamento);
                    pst.setString(2, departamento);
                    pst.setString(3, cod_municipio);
                    pst.setString(4, municipio);
                    int n = pst.executeUpdate();
                    if (n >= 1) {
                        respuesta = "Datos guardados. ";
                    }
                } catch (SQLException ex) {
                    respuesta = "ERROR";
                    Logger.getLogger(CargarView.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            respuesta += i + " campos registrados";
        } else {
            respuesta = "La tabla está vacia";
        }

        contenido += respuesta;
        log.crearLog(contenido);
        return respuesta;
    }

    public boolean consultarDANE() {
        boolean estado = false;
        try {
            st = conectar.createStatement();
            rs = st.executeQuery("SELECT * FROM dane");
            if (rs.next()) {
                estado = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ETLModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        return estado;
    }

    public String eliminarTodoDANE() {
        String estado = "", contenido = "Registro en la Base de Datos\nEstado: ";
        try {
            st = conectar.createStatement();
            st.executeUpdate("TRUNCATE dane");
            estado = "Se han eliminado todos los registros de la tabla DANE";
        } catch (SQLException ex) {
            Logger.getLogger(ETLModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        contenido += estado;
        log.crearLog(contenido);
        return estado;
    }

    public String compararDANEconDB(String opc) {
        String estado = "", table = "", column = "", sql = "";
        String contenido = "COMPARACIÓN DE DATOS \r\n";
        switch (opc) {
            case "departamentos":
                contenido += "--------EN LA TABLA DEPARTAMENTOS \r\n";
                sql = "SELECT `departamentos`.`ID` as `id_dep`, `dane`.`codigo_departamento` as `cod_dept_DANE`, `departamentos`.`nombre_departamento` as `nomb_dep`, `departamentos`.`cod_departamento` as `cod_dep`, `departamentos`.`ID_pais` as `ID_pais` FROM `departamentos` JOIN `dane` ON `dane`.`departamento`=`departamentos`.`nombre_departamento` WHERE `dane`.`codigo_departamento` != `departamentos`.`cod_departamento` GROUP BY `departamentos`.`nombre_departamento`";
                table = "departamentos";
                column = "cod_departamento";
                break;
            case "municipios":
                contenido += "--------EN LA TABLA CIUDADES \r\n";
                sql = "SELECT `ciudades`.`ID` as `id_ciud`, `dane`.`codigo_municipio` as `cod_ciud_DANE`, `ciudades`.`nombre_ciudad` as `nomb_ciud`, `ciudades`.`cod_ciudad` AS `cod_ciud`, `ciudades`.`ID_departamento` AS `ID_dep` FROM `ciudades` JOIN `dane` ON `dane`.`municipio`=`ciudades`.`nombre_ciudad` WHERE `dane`.`codigo_municipio` != `ciudades`.`cod_ciudad` GROUP BY `ciudades`.`nombre_ciudad`";
                table = "ciudades";
                column = "cod_ciudad";
                break;
            default:
                return "BRUTO";
        }
        try {
            pst = conectar.prepareStatement(sql);
            rs = pst.executeQuery();
            String id = "";
            String aux = "";
            while (rs.next()) {
                aux += "REGISTRO ANTERIOR: " + rs.getString(1) + " - " + rs.getString(3) + " - " + rs.getString(4) + " - " + rs.getString(5) + "__";
                id += rs.getString(1) + ",";
                pst = conectar.prepareStatement("UPDATE " + table + " SET " + column + " = ? WHERE ID = ?");
                pst.setString(1, rs.getString(2));
                pst.setString(2, rs.getString(1));
                pst.executeUpdate();
            }
            String[] a = aux.split("__");
            String[] ids = id.split(",");
            aux = "";
            for (int i = 0; i < ids.length; i++) {
                pst = conectar.prepareStatement("SELECT * FROM " + table + " WHERE ID = ?");
                pst.setString(1, ids[i]);
                rs = pst.executeQuery();
                while (rs.next()) {
                    aux += "REGISTRO NUEVO: " + rs.getString(1) + " - " + rs.getString(2)
                            + " - " + rs.getString(3) + " - " + rs.getString(4) + "__";
                }
            }
            String[] aa = aux.split("__");
            if (!a[0].isEmpty()) {
                for (int i = 0; i < a.length; i++) {
                    contenido += a[i] + " \r\n" + aa[i];
                    if (i != a.length - 1) {
                        contenido += " \r\n\n";
                    }
                }
                estado = "SE EFECTUARON CAMBIOS EN " + opc.toUpperCase();
            } else {
                estado = "NO SE EFECTUARON CAMBIOS";
                contenido += "NO SE EFECTUARON CAMBIOS EN " + opc.toUpperCase();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ETLModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        log.crearLog(contenido);
        return estado;
    }

}
