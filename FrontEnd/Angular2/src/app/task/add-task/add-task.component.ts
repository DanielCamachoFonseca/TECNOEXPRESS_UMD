import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {ServiceTaskService} from 'app/Service-task/service-task.service'
import { Task } from '../../Model/Task';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-add-task',
  templateUrl: './add-task.component.html',
  styleUrls: ['./add-task.component.css']
})
export class AddTaskComponent implements OnInit {

  
  task:Task = new Task(); //Creo un objeto o instancia de tipo Task
  constructor(private router:Router, private service:ServiceTaskService) { }

  ngOnInit() {
  }

  Save(purpose:string, dateStay:string, dateSolution:string, task:string){ //Este metodo se encarga de crear un nuevo registro en la base de datos
    this.task.purpose = purpose;
    this.task.dateStay = dateStay;
    this.task.dateSolution = dateSolution;
    this.task.task = task;
    this.service.createTask(this.task)
    .subscribe(data=>{
      Swal.fire("La tarea se agrego con exito!", "Da click para listar las tareas!", "success");
      this.router.navigate(['list-task']);
    })
  }
  
}
