package co.edu.org.uniminuto.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "tasks", schema = "tecnoexpress_users")
public class Task implements Serializable {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idTask")
	private Long idTask;
	
	@Column(name="purpose")
	private String purpose;
	
	@Temporal(TemporalType.DATE)
	private Date dateStay;
	
	@Temporal(TemporalType.DATE)
	private Date dateSolution;
	
	@Column(name="task")
	private String task;

	public Long getIdTask() {
		return idTask;
	}

	public void setIdTask(Long idTask) {
		this.idTask = idTask;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public Date getDateStay() {
		return dateStay;
	}

	public void setDateStay(Date dateStay) {
		this.dateStay = dateStay;
	}

	public Date getDateSolution() {
		return dateSolution;
	}

	public void setDateSolution(Date dateSolution) {
		this.dateSolution = dateSolution;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}
	
	private static final long serialVersionUID = 1L;
	
}
