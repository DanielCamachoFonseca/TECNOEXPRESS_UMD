package co.edu.org.uniminuto.impl;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.org.uniminuto.dto.ITaskDto;
import co.edu.org.uniminuto.entity.Task;
import co.edu.org.uniminuto.interfaces.ITaskService;

@Service
@Transactional
public class TaskServiceImplement implements ITaskService { //Metodos que implementa el servicio

	@Autowired
	private ITaskDto taskDto;
	
	@Override
	public List<Task> findAll() {
		return (List<Task>) taskDto.findAll();
	}

	@Override
	public Optional<Task> listidTask(long id_task) {
		return taskDto.findById((long) id_task);
	}
	
	@Override
	public Task add(Task task) {
		return taskDto.save(task);
	}

	@Override
	public Task edit(Task task) {
		return taskDto.save(task);
	}
	
	@Override
	public void delete(long id_task) {
		taskDto.delete(getIdTaskById(id_task));
	}

	@Override
	public Task getIdTaskById(long id_task) {
		Task tas = taskDto.findById(id_task).get();
		return tas;
	}
}
