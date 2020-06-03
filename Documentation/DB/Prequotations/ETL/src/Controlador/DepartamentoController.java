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
public class DepartamentoController extends Objetos implements ActionListener {

    public DepartamentoController(CargarView vistaCargar) {
        this.vistaCargar = vistaCargar;
        this.vistaCargar.jBtnNuevoDepartamento.addActionListener(this);
        this.vistaCargar.jBtnCrearDepartamento.addActionListener(this);
        this.vistaCargar.jBtnModificarDepartamento.addActionListener(this);
        this.vistaCargar.jComboPais.addActionListener(this);
        this.vistaCargar.jComboPais.setModel(this.setModelComboBox(mPais.readPaisesCombo("codigo")));
        this.modelTable = mDepartamento.readDepartamentos();
        vistaCargar.jTableDepartamentos.setModel(modelTable);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String resultado[];
        String data[] = new String[]{
            vistaCargar.jTxtCodigoDepartamento.getText(), // código del departamento
            vistaCargar.jTxtNombreDepartamento.getText(), // nombre del departamento
            mPais.readPais("ID", "cod_pais", vistaCargar.jComboPais.getSelectedItem().toString()) // ID del país
        };
        if (e.getSource() == vistaCargar.jBtnNuevoDepartamento) {
            deshabilitar_campos_departamentos(true);
            vistaCargar.jBtnModificarDepartamento.setEnabled(false);
        }

        if (e.getSource() == vistaCargar.jComboPais) {
            vistaCargar.jTxtNombrePaisD.setText(mPais.readPais("nombre", "ID", data[2]));
        }

        if (e.getSource() == vistaCargar.jBtnCrearDepartamento) {
            if (!data[0].equals("") && !data[1].equals("") && !data[2].equals("")) {
                resultado = mDepartamento.validateDepartamento(data[0], data[1]);
                if (resultado[0].equals("0")) {
                    resultado = mDepartamento.createDepartamento(data);
                    if (resultado[0].equals("1")) {
                        JOptionPane.showMessageDialog(null, resultado[1]);
                        modelTable = mDepartamento.readDepartamentos();
                        vistaCargar.jTableDepartamentos.setModel(modelTable);
                        deshabilitar_campos_departamentos(false);
                        // cargar al combo el nuevo departamento registrado
                        vistaCargar.jComboDepartamento.setModel(this.setModelComboBox(mDepartamento.readDepartamentosCombo("codigo")));
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

        if (e.getSource() == vistaCargar.jBtnModificarDepartamento) {
            resultado = mDepartamento.updateDepartamento(data[0], data[1], data[2]);
            if (resultado[0].equals("1")) {
                JOptionPane.showMessageDialog(null, resultado[1]);
                modelTable = mDepartamento.readDepartamentos();
                vistaCargar.jTableDepartamentos.setModel(modelTable);
                deshabilitar_campos_departamentos(false);
                vistaCargar.jBtnModificarDepartamento.setEnabled(false);
            }
        }

        String leer = log.leerLog();
        vistaCargar.jVistaLog.setText(leer);
    }

    public void deshabilitar_campos_departamentos(boolean estado) {
        vistaCargar.jBtnCrearDepartamento.setEnabled(estado);
        vistaCargar.jComboPais.setEnabled(estado);
        vistaCargar.jComboPais.setSelectedIndex(0);
        vistaCargar.jTxtCodigoDepartamento.setEnabled(estado);
        vistaCargar.jTxtCodigoDepartamento.setText("");
        vistaCargar.jTxtNombreDepartamento.setEnabled(estado);
        vistaCargar.jTxtNombreDepartamento.setText("");
        vistaCargar.jTxtNombrePaisD.setText("");
    }

}
