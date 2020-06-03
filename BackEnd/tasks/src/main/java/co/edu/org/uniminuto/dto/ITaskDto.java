package co.edu.org.uniminuto.dto;

import org.springframework.data.repository.CrudRepository;

import co.edu.org.uniminuto.entity.Task;

public interface ITaskDto extends CrudRepository<Task, Long> {
	


}
