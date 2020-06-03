import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Task } from 'app/Model/Task';

@Injectable({
  providedIn: 'root'
})
export class ServiceTaskService {

  constructor(private http:HttpClient) { }

    Url1='/api/list-tasks'; //URL de listar registros
    Url2='/api/add-tasks'; //URL para agregar registros
    Url3='/api'; //URL para coger unicamente el ID de cada registro
    Url4='/api/edit-tasks'; //URL para editar un registro
    Url5='/api/delete-tasks'; //URL para eliminar un registro 


    getTasks(){ //Metodo para listar registros de la base de datos
      return this.http.get<Task[]>(this.Url1);
    }

    createTask(task:Task){ //Metodo para agregar una nueva tarea en la base de datos
      return this.http.post<Task>(this.Url2,task);
    }

    getTaskId(id:number){ //Metodo para capturar el id de la fila
      return this.http.get<Task>(this.Url3+"/"+id);
    }

    updateTask(task:Task){ //Metodo para actualizar un registro
      return this.http.put<Task>(this.Url4+"/"+task.idTask,task);
    }   

    deleteTask(task:Task){ //Metodo para eliminar un registro de la base de datos
      return this.http.delete<Task>(this.Url5+"/"+task.idTask);
    }
}
