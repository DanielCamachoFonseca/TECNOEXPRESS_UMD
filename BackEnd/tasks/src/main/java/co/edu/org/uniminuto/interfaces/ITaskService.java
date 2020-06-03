package co.edu.org.uniminuto.interfaces;

import java.util.List;
import java.util.Optional;

import co.edu.org.uniminuto.entity.Task;

public interface ITaskService {
	
	public List<Task> findAll();
	
	public Optional<Task> listidTask(long id_task);
	
	Task getIdTaskById(long getIdTask);
	
	public Task add(Task task);
	
	public Task edit(Task task);
	
	void delete (long id_task);
	

}
