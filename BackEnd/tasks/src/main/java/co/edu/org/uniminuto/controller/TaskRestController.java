package co.edu.org.uniminuto.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import co.edu.org.uniminuto.entity.Task;
import co.edu.org.uniminuto.interfaces.ITaskService;

@CrossOrigin("http://localhost:4200")

@RestController
@RequestMapping("/api")
public class TaskRestController {
	
	@Autowired
	private ITaskService taskService;
	
	@GetMapping("/list-tasks")
	public List<Task> findAll(){ //Metodo para listar los registros de la base de datos
		return taskService.findAll(); 
	}
	
	@PostMapping("/add-tasks")
	public Task add(@RequestBody Task task) { //Metodo para agregar una tarea en la base de datos desde el FrontEnd
		return taskService.add(task);
	}
	
	@GetMapping(path = {"/{id_task}"}) //Metodo para traerme el Id de cada rgistro
	public Optional<Task> ListId(@PathVariable("id_task")Long id_task) {
		return taskService.listidTask(id_task);
	}
	
	@PutMapping(path = {"/edit-tasks/{id_task}"})//Metodo donde se actualiza y se envian los datos al front
	public Task edit(@RequestBody Task task, @PathVariable("id_task")Long id_task) {
		task.setIdTask(id_task);
		return taskService.edit(task);
	}
	
	@DeleteMapping(path = {"/delete-tasks/{id_task}"})//Metodo donde se eliminan los registros de acuerdo al Id
	public ResponseEntity<Void> deleteTask(@PathVariable("id_task") Integer id_task) {
		taskService.delete(id_task);
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}	
	
}
