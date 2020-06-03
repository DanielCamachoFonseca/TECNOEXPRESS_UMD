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
public class PaisController extends Objetos implements ActionListener {

    public PaisController(CargarView vistaCargar) {
        this.vistaCargar = vistaCargar;
        this.vistaCargar.jBtnNuevoPais.addActionListener(this);
        this.vistaCargar.jBtnCrearPais.addActionListener(this);
        this.vistaCargar.jBtnModificarPais.addActionListener(this);
        this.modelTable = mPais.readPaises();
        vistaCargar.jTablePaises.setModel(modelTable);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == vistaCargar.jBtnNuevoPais) {
            vistaCargar.jBtnModificarPais.setEnabled(false);
            deshabilitar_campos_pais(true);
        }

        Object resultado[];
        String codigoPais = vistaCargar.jTxtCodigoPais.getText();
        String nombrePais = vistaCargar.jTxtNombrePais.getText();
        if (e.getSource() == vistaCargar.jBtnCrearPais) {
            if (!codigoPais.equals("") && !nombrePais.equals("")) {
                resultado = mPais.validatePais(codigoPais, nombrePais);
                if (resultado[0].equals(0)) {
                    resultado = mPais.createPais(codigoPais, nombrePais);
                    JOptionPane.showMessageDialog(null, resultado[1]);
                    if (resultado[0].equals(1)) {
                        modelTable = mPais.readPaises();
                        vistaCargar.jTablePaises.setModel(modelTable);
                        deshabilitar_campos_pais(false);
                        // cargar al combo el nuevo país registrado
                        vistaCargar.jComboPais.setModel(this.setModelComboBox(mPais.readPaisesCombo("codigo")));
                    }
                } else {
                    if (resultado[1] instanceof String[]) {
                        String[] a = ((String[]) resultado[1]);
                        for (int i = 0; i < a.length; i++) {
                            System.out.println(i + " => " + a[i]);
                        }
                    } else {
                        JOptionPane.showMessageDialog(null, resultado[1], "Error!", JOptionPane.ERROR_MESSAGE);
                    }
                }
            } else {
                JOptionPane.showMessageDialog(null, "CAMPOS VACIOS", "Error!", JOptionPane.ERROR_MESSAGE);
            }
        }

        if (e.getSource() == vistaCargar.jBtnModificarPais) {
            resultado = mPais.updatePais(codigoPais, nombrePais);
            JOptionPane.showMessageDialog(null, resultado[1]);
            if (resultado[0].equals(1)) {
                modelTable = mPais.readPaises();
                vistaCargar.jTablePaises.setModel(modelTable);
                vistaCargar.jBtnCrearPais.setEnabled(false);
                vistaCargar.jBtnModificarPais.setEnabled(false);
                vistaCargar.jTxtCodigoPais.setEnabled(true);
                vistaCargar.jTxtCodigoPais.setText("");
                vistaCargar.jTxtNombrePais.setText("");
            }
        }
        String leer = log.leerLog();
        vistaCargar.jVistaLog.setText(leer);
    }

    public void deshabilitar_campos_pais(boolean estado) {
        vistaCargar.jBtnCrearPais.setEnabled(estado);
        vistaCargar.jTxtCodigoPais.setEnabled(estado);
        vistaCargar.jTxtNombrePais.setEnabled(estado);
        vistaCargar.jTxtCodigoPais.setText("");
        vistaCargar.jTxtNombrePais.setText("");
    }
}
