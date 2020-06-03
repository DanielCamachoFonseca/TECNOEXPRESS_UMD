import { Component, OnInit } from '@angular/core';
import {ServiceTaskService} from 'app/Service-task/service-task.service'
import { Router } from '@angular/router';
import { Task } from '../../Model/Task';
import Swal from 'sweetalert2';


@Component({
  selector: 'app-edit-task',
  templateUrl: './edit-task.component.html',
  styleUrls: ['./edit-task.component.css']
})
export class EditTaskComponent implements OnInit {

  task :Task=new Task();
  constructor(private router:Router, private service:ServiceTaskService) { }

  ngOnInit(): void {
    this.Editar();
  }

  Editar(){ //En este metodo se pre-cargan los datos de cada registro segun su Id
    let idTask=localStorage.getItem("idTask");
    this.service.getTaskId(+idTask)
    .subscribe(data=>{
      this.task=data;
    })
  }

  Update(task:Task){ //Este metodo se encarga de actualizar los registros de la base de datos 
    this.service.updateTask(task)
    .subscribe(data=>{
      this.task=data;
      Swal.fire("La tarea se actualizo con exito!", "Da click para listar las tareas!", "success");
      this.router.navigate(['list-task']);
    })
  }

}
