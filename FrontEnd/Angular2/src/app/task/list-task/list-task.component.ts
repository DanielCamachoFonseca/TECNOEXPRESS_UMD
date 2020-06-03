import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {ServiceTaskService} from 'app/Service-task/service-task.service'
import { Task } from '../../Model/Task';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-list-task',
  templateUrl: './list-task.component.html',
  styleUrls: ['./list-task.component.css']
})
export class ListTaskComponent implements OnInit {

  tasks:Task[];
  constructor(private service:ServiceTaskService, private router:Router) { }

  ngOnInit() {
    this.service.getTasks()
    .subscribe(data=>{
      this.tasks=data;
    })
  }

  Edit(task:Task){ //Este metodo sirve para re-dirigir al componente de editar - formulario 
    localStorage.setItem("idTask",task.idTask.toString());
    this.router.navigate(['edit-task']);
  }

  Delete(task:Task){ //Metodo para eliminar un registro de la base de datos 
    this.service.deleteTask(task)
    .subscribe(data=>{
      this.tasks=this.tasks.filter(t=>t!==task);
      Swal.fire("La tarea se elimino con exito!", "Da click para listar las tareas!", "success");
    })
  }

}
