package Main;

import Controlador.CiudadController;
import Controlador.DepartamentoController;
import Vista.CargarView;
import Controlador.ExcelController;
import Controlador.PaisController;
import Eventos.MouseEvents;
import Modelo.Logs;
import Modelo.ExcelModel;

/**
 *
 * @author Chrystian Romero
 */
public class CargaInicial {

    // Controladores
    private final PaisController cPais;
    private final DepartamentoController cDepartamento;
    private final CiudadController cCiudad;
    private final ExcelController cExcel;

    // Modelos
    private final ExcelModel mExcel;

    // Vistas
    private final CargarView vPrincipal;

    // Eventos
    private final MouseEvents eMouse;
    
    private final Logs log = new Logs();
    
    public CargaInicial() {
        vPrincipal = new CargarView();
        mExcel = new ExcelModel();
        cExcel = new ExcelController(vPrincipal, mExcel);
        cPais = new PaisController(vPrincipal);
        cDepartamento = new DepartamentoController(vPrincipal);
        cCiudad = new CiudadController(vPrincipal);
        eMouse = new MouseEvents(vPrincipal);
        vPrincipal.setVisible(true);
        vPrincipal.setLocationRelativeTo(null);
        log.crearLog("Inicio del programa");
        vPrincipal.jVistaLog.setText(log.leerLog());
    }
}
