import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-task',
  templateUrl: './task.component.html',
  styleUrls: ['./task.component.css']
})
export class TaskComponent  {

  constructor(private router:Router) {
   }

   List(){//Metodo por el cual me re-dirige al componente listar
    this.router.navigate(["list-task"]);
  }

  Add(){//Metodo por el cual me re-dirige al componente agregar
    this.router.navigate(["add-task"]);
  }

}
