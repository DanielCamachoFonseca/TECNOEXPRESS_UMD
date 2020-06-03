package Controlador;

import Ayudas.Objetos;
import Vista.CargarView;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JOptionPane;

/**
 *
 * @author Chrystian Romero
 */
public class CiudadController extends Objetos implements ActionListener {

    public CiudadController(CargarView vistaCargar) {
        this.vistaCargar = vistaCargar;
        this.vistaCargar.jBtnNuevaCiudad.addActionListener(this);
        this.vistaCargar.jBtnCrearCiudad.addActionListener(this);
        this.vistaCargar.jBtnModificarCiudad.addActionListener(this);
        this.vistaCargar.jComboDepartamento.addActionListener(this);
        this.vistaCargar.jComboDepartamento.setModel(this.setModelComboBox(mDepartamento.readDepartamentosCombo("codigo")));
        this.modelTable = mCiudad.readCiudades();
        vistaCargar.jTableCiudades.setModel(modelTable);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String resultado[];
        String data[] = new String[]{
            vistaCargar.jTxtCodigoCiudad.getText(), // código de ciudad
            vistaCargar.jTxtNombreCiudad.getText(), // nombre de ciudad
            mDepartamento.readDepartamento("ID", "cod_departamento", vistaCargar.jComboDepartamento.getSelectedItem().toString()) // ID del departamento
        };
        if (e.getSource() == vistaCargar.jBtnNuevaCiudad) {
            vistaCargar.jBtnCrearCiudad.setEnabled(true);
            vistaCargar.jBtnModificarCiudad.setEnabled(false);
            deshabilitar_campos_ciudad(true);
        }

        if (e.getSource() == vistaCargar.jComboDepartamento) {
            vistaCargar.jTxtNombreDepartamentoC.setText(mDepartamento.readDepartamento("nombre", "ID", data[2]));
        }

        if (e.getSource() == vistaCargar.jBtnCrearCiudad) {
            if (!data[0].equals("") && !data[1].equals("") && !data[2].equals("")) {
                resultado = mCiudad.validateCiudad(data[0], data[1]);
                if (resultado[0].equals("0")) {
                    resultado = mCiudad.createCiudad(data);
                    if (resultado[0].equals("1")) {
                        JOptionPane.showMessageDialog(null, resultado[1]);
                        modelTable = mCiudad.readCiudades();
                        vistaCargar.jTableCiudades.setModel(modelTable);
                        vistaCargar.jBtnCrearCiudad.setEnabled(false);
                        deshabilitar_campos_ciudad(false);
                    } else {
                        JOptionPane.showMessageDialog(null, resultado[1]);
                    }
                } else {
                    JOptionPane.showMessageDialog(null, resultado[1], "Error!", JOptionPane.ERROR_MESSAGE);
                }
            } else {
                JOptionPane.showMessageDialog(null, "CAMPOS VACIOS", "Error!", JOptionPane.ERROR_MESSAGE);
            }
        }

        if (e.getSource() == vistaCargar.jBtnModificarCiudad) {
            resultado = mCiudad.updateCiudad(data[0], data[1], data[2]);
            if (resultado[0].equals("1")) {
                JOptionPane.showMessageDialog(null, resultado[1]);
                modelTable = mCiudad.readCiudades();
                vistaCargar.jTableCiudades.setModel(modelTable);
                vistaCargar.jBtnCrearCiudad.setEnabled(false);
                vistaCargar.jBtnModificarCiudad.setEnabled(false);
                vistaCargar.jComboDepartamento.setSelectedIndex(0);
                vistaCargar.jComboDepartamento.setEnabled(false);
                vistaCargar.jTxtCodigoCiudad.setEnabled(false);
                vistaCargar.jTxtCodigoCiudad.setText("");
                vistaCargar.jTxtNombreCiudad.setText("");
                vistaCargar.jTxtNombreDepartamentoC.setText("");
            }
        }
        String leer = log.leerLog();
        vistaCargar.jVistaLog.setText(leer);
    }

    public void deshabilitar_campos_ciudad(boolean estado) {
        vistaCargar.jTxtCodigoCiudad.setEnabled(estado);
        vistaCargar.jTxtNombreCiudad.setEnabled(estado);
        vistaCargar.jTxtNombreCiudad.setEnabled(estado);
        vistaCargar.jComboDepartamento.setEnabled(estado);
        vistaCargar.jComboDepartamento.setSelectedIndex(0);
        vistaCargar.jTxtCodigoCiudad.setText("");
        vistaCargar.jTxtNombreCiudad.setText("");
        vistaCargar.jTxtNombreDepartamentoC.setText("");
    }
}
