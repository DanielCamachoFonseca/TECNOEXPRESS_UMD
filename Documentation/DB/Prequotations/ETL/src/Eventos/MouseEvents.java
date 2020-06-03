package Eventos;

import Ayudas.Objetos;
import Vista.CargarView;
import java.awt.Point;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import javax.swing.JOptionPane;

/**
 *
 * @author Chrystian Romero
 */
public class MouseEvents extends Objetos implements MouseListener {

    private Point p;

    public MouseEvents(CargarView vistaCargar) {
        this.vistaCargar = vistaCargar;
        this.vistaCargar.jTablePaises.addMouseListener(this);
        this.vistaCargar.jTableDepartamentos.addMouseListener(this);
        this.vistaCargar.jTableCiudades.addMouseListener(this);
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        p = e.getPoint();
        if (e.getSource() == vistaCargar.jTablePaises) {
            int actualColumn = vistaCargar.jTablePaises.columnAtPoint(p);
            int ultimaColumna = vistaCargar.jTablePaises.getColumnCount() - 1;
            int filaSeleccionada = vistaCargar.jTablePaises.getSelectedRow();
//            int actualRow = vistaCargar.jTablePaises.rowAtPoint(p);

            vistaCargar.jTxtNombrePais.setEnabled(true);
            String codigoPais = (String) vistaCargar.jTablePaises.getModel().getValueAt(filaSeleccionada, 0);
            String nombrePais = vistaCargar.jTablePaises.getModel().getValueAt(filaSeleccionada, 1).toString();

            if (actualColumn == ultimaColumna) {
                int opc = JOptionPane.showConfirmDialog(null, "¿ Eliminar el país '" + nombrePais + "' ?", "Confirmar Eliminación", JOptionPane.YES_NO_OPTION);
                if (opc == 0) {
                    JOptionPane.showMessageDialog(null, mPais.deletePais(codigoPais));
                    modelTable = mPais.readPaises();
                    vistaCargar.jTablePaises.setModel(modelTable);
                    vistaCargar.jBtnCrearPais.setEnabled(false);
                    vistaCargar.jBtnModificarPais.setEnabled(false);
                    vistaCargar.jTxtCodigoPais.setText("");
                    vistaCargar.jTxtNombrePais.setText("");
                    vistaCargar.jComboPais.setModel(this.setModelComboBox(mPais.readPaisesCombo("codigo")));
                }
            } else {
                vistaCargar.jBtnModificarPais.setEnabled(true);
                vistaCargar.jTxtCodigoPais.setEnabled(false);
                vistaCargar.jBtnCrearPais.setEnabled(false);
                vistaCargar.jTxtCodigoPais.setText(codigoPais);
                vistaCargar.jTxtNombrePais.setText(nombrePais);
            }
        }

        if (e.getSource() == vistaCargar.jTableDepartamentos) {
            int actualColumn = vistaCargar.jTableDepartamentos.columnAtPoint(p);
            int ultimaColumna = vistaCargar.jTableDepartamentos.getColumnCount() - 1;
            int filaSeleccionada = vistaCargar.jTableDepartamentos.getSelectedRow();

            String codigoDepartamento = vistaCargar.jTableDepartamentos.getModel().getValueAt(filaSeleccionada, 0).toString();
            String nombreDepartamento = (String) vistaCargar.jTableDepartamentos.getModel().getValueAt(filaSeleccionada, 1);
            String codigoPais = vistaCargar.jTableDepartamentos.getModel().getValueAt(filaSeleccionada, 2).toString();

            if (actualColumn == ultimaColumna) {
                int opc = JOptionPane.showConfirmDialog(null, "¿ Eliminar el departamento '" + nombreDepartamento + "' ?", "Confirmar Eliminación", JOptionPane.YES_NO_OPTION);
                if (opc == 0) {
                    JOptionPane.showMessageDialog(null, mDepartamento.deleteDepartamento(codigoDepartamento));
                    modelTable = mDepartamento.readDepartamentos();
                    vistaCargar.jTableDepartamentos.setModel(modelTable);
                    vistaCargar.jBtnCrearDepartamento.setEnabled(false);
                    vistaCargar.jBtnModificarDepartamento.setEnabled(false);
                    vistaCargar.jComboPais.setEnabled(false);
                    vistaCargar.jComboPais.setSelectedIndex(0);
                    vistaCargar.jTxtCodigoDepartamento.setText("");
                    vistaCargar.jTxtNombreDepartamento.setText("");
                    // cargar al combo el nuevo departamento registrado
                    vistaCargar.jComboDepartamento.setModel(this.setModelComboBox(mDepartamento.readDepartamentosCombo("codigo")));
                }
            } else {
                vistaCargar.jBtnModificarDepartamento.setEnabled(true);
                vistaCargar.jBtnCrearDepartamento.setEnabled(false);
                vistaCargar.jTxtCodigoDepartamento.setEnabled(false);
                vistaCargar.jTxtNombreDepartamento.setEnabled(true);
                vistaCargar.jTxtCodigoDepartamento.setText(codigoDepartamento);
                vistaCargar.jTxtNombreDepartamento.setText(nombreDepartamento);
                vistaCargar.jComboPais.setEnabled(true);
                vistaCargar.jComboPais.setSelectedItem(codigoPais);
                vistaCargar.jTxtNombrePaisD.setText(mPais.readPais("nombre", "cod_pais", codigoPais));
            }
        }
        
        if (e.getSource() == vistaCargar.jTableCiudades) {
            int actualColumn = vistaCargar.jTableCiudades.columnAtPoint(p);
            int ultimaColumna = vistaCargar.jTableCiudades.getColumnCount() - 1;
            int filaSeleccionada = vistaCargar.jTableCiudades.getSelectedRow();

            String codigoCiudad = vistaCargar.jTableCiudades.getModel().getValueAt(filaSeleccionada, 0).toString();
            String nombreCiudad = (String) vistaCargar.jTableCiudades.getModel().getValueAt(filaSeleccionada, 1);
            String codigoDepartamento = vistaCargar.jTableCiudades.getModel().getValueAt(filaSeleccionada, 2).toString();

            if (actualColumn == ultimaColumna) {
                int opc = JOptionPane.showConfirmDialog(null, "¿ Eliminar la ciudad '" + nombreCiudad + "' ?", "Confirmar Eliminación", JOptionPane.YES_NO_OPTION);
                if (opc == 0) {
                    JOptionPane.showMessageDialog(null, mCiudad.deleteCiudad(codigoCiudad));
                    modelTable = mCiudad.readCiudades();
                    vistaCargar.jTableCiudades.setModel(modelTable);
                    vistaCargar.jBtnCrearCiudad.setEnabled(false);
                    vistaCargar.jBtnModificarCiudad.setEnabled(false);
                    vistaCargar.jComboDepartamento.setEnabled(false);
                    vistaCargar.jComboDepartamento.setSelectedIndex(0);
                    vistaCargar.jTxtCodigoCiudad.setText("");
                    vistaCargar.jTxtNombreCiudad.setText("");
                }
            } else {
                vistaCargar.jBtnModificarCiudad.setEnabled(true);
                vistaCargar.jBtnCrearCiudad.setEnabled(false);
                vistaCargar.jTxtCodigoCiudad.setEnabled(false);
                vistaCargar.jTxtNombreCiudad.setEnabled(true);
                vistaCargar.jTxtCodigoCiudad.setText(codigoCiudad);
                vistaCargar.jTxtNombreCiudad.setText(nombreCiudad);
                vistaCargar.jComboDepartamento.setEnabled(true);
                vistaCargar.jComboDepartamento.setSelectedItem(codigoDepartamento);
                vistaCargar.jTxtNombreDepartamentoC.setText(mDepartamento.readDepartamento("nombre", "cod_departamento", codigoDepartamento));
            }
        }
        String leer = log.leerLog();
        vistaCargar.jVistaLog.setText(leer);
    }

    @Override
    public void mousePressed(MouseEvent e) {

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }

}
