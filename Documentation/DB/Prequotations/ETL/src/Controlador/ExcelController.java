package Controlador;

import Ayudas.Objetos;
import Vista.CargarView;
import Modelo.ExcelModel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;

/**
 *
 * @author Chrystian Romero
 */
public class ExcelController extends Objetos implements ActionListener {

    public ExcelController(CargarView vistaCargar, ExcelModel modeloE) {
        this.vistaCargar = vistaCargar;
        this.modeloE = modeloE;
        this.vistaCargar.jBtnCargarExcel.addActionListener(this);
        this.vistaCargar.jBtnImportarExcel.addActionListener(this);
        this.vistaCargar.jBtnTruncateDepartamentos.addActionListener(this);
        this.vistaCargar.jBtnCompararCambios.addActionListener(this);
    }

    public void agregarFiltro() {
        selecArchivo.setFileFilter(new FileNameExtensionFilter("Excel (*.xls)", "xls"));
        selecArchivo.setFileFilter(new FileNameExtensionFilter("Excel (*.xlsx)", "xlsx"));
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String estadoLog = "";

        if (e.getSource() == vistaCargar.jBtnCargarExcel) {
            agregarFiltro();
            if (selecArchivo.showDialog(null, "Seleccionar archivo") == JFileChooser.APPROVE_OPTION) {
                archivo = selecArchivo.getSelectedFile();
                if (archivo.getName().endsWith("xls") || archivo.getName().endsWith("xlsx")) {
                    estadoLog = "Carga de archivo Excel\nEstado: " + modeloE.Importar(archivo, vistaCargar.jTableDANE);
                    String estado = modeloE.Importar(archivo, vistaCargar.jTableDANE);
                    String formato =  "\nFormato " + archivo.getName().substring(archivo.getName().lastIndexOf(".") + 1);
                    JOptionPane.showMessageDialog(null, estado + formato, "IMPORTAR EXCEL", JOptionPane.INFORMATION_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(null, "Elija un formato valido.");
                }
            }
            vistaCargar.jBtnImportarExcel.setEnabled(true);
            log.crearLog(estadoLog);
        }

        if (e.getSource() == vistaCargar.jBtnImportarExcel) {
            String resp = mETL.registrarDANE(vistaCargar.jTableDANE);
            JOptionPane.showMessageDialog(null, resp);
        }

        if (e.getSource() == vistaCargar.jBtnTruncateDepartamentos) {
            String resp = mETL.eliminarTodoDANE();
            JOptionPane.showMessageDialog(null, resp);
        }

        if (e.getSource() == vistaCargar.jBtnCompararCambios) {
            String result = "";
            result = mETL.compararDANEconDB("departamentos");
            System.out.println(result);
            result = mETL.compararDANEconDB("municipios");
            System.out.println(result);
            vistaCargar.jTableDepartamentos.setModel(mDepartamento.readDepartamentos());
            vistaCargar.jTableCiudades.setModel(mCiudad.readCiudades());
            vistaCargar.jTablePaises.setModel(mPais.readPaises());
            this.vistaCargar.jComboDepartamento.setModel(this.setModelComboBox(mDepartamento.readDepartamentosCombo("codigo")));

        }
        String leer = log.leerLog();
        vistaCargar.jVistaLog.setText(leer);
    }
}
