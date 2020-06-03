package Ayudas;

import Modelo.CiudadModel;
import Modelo.DepartamentoModel;
import Modelo.ETLModel;
import Modelo.ExcelModel;
import Modelo.Logs;
import Modelo.PaisModel;
import Vista.CargarView;
import java.io.File;
import java.util.ArrayList;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JFileChooser;
import javax.swing.table.TableModel;

/**
 *
 * @author Chrystian Romero
 */
public class Objetos {

    //vistaPrincipal
    protected CargarView vistaCargar = new CargarView();

    //Generador de Logs
    protected Logs log = new Logs();

    //ExcelController
    protected ExcelModel modeloE = new ExcelModel();
    protected ETLModel mETL = new ETLModel();
    protected JFileChooser selecArchivo = new JFileChooser();
    protected File archivo;

    //PaisController
    protected PaisModel mPais = new PaisModel();

    //DepartamentoController
    protected DepartamentoModel mDepartamento = new DepartamentoModel();
    
    //CiudadController
    protected CiudadModel mCiudad = new CiudadModel();

    //Clases 
    protected TableModel modelTable;
    protected DefaultComboBoxModel modelCombobox;

    protected DefaultComboBoxModel setModelComboBox(ArrayList<String> list) {
        String[] lista = list.toArray(new String[0]);
        modelCombobox = new DefaultComboBoxModel(lista);
        return modelCombobox;
    }
}
