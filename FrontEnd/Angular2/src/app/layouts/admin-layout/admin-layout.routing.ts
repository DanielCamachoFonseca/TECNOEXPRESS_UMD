import { Routes } from '@angular/router';

import { DashboardComponent } from '../../dashboard/dashboard.component';
import { UserProfileComponent } from '../../user-profile/user-profile.component';
import { TableListComponent } from '../../table-list/table-list.component';
import { TypographyComponent } from '../../typography/typography.component';
import { IconsComponent } from '../../icons/icons.component';
import { TaskComponent } from '../../task/task.component';
import { AddTaskComponent } from '../../task/add-task/add-task.component';
import { ListTaskComponent } from '../../task/list-task/list-task.component';
import { EditTaskComponent } from '../../task/edit-task/edit-task.component';
import { MapsComponent } from '../../maps/maps.component';
import { NotificationsComponent } from '../../notifications/notifications.component';
import { UpgradeComponent } from '../../upgrade/upgrade.component';

export const AdminLayoutRoutes: Routes = [
    // {
    //   path: '',
    //   children: [ {
    //     path: 'dashboard',
    //     component: DashboardComponent
    // }]}, {
    // path: '',
    // children: [ {
    //   path: 'userprofile',
    //   component: UserProfileComponent
    // }]
    // }, {
    //   path: '',
    //   children: [ {
    //     path: 'icons',
    //     component: IconsComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'notifications',
    //         component: NotificationsComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'maps',
    //         component: MapsComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'typography',
    //         component: TypographyComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'upgrade',
    //         component: UpgradeComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'task',
    //         component: TaskComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'add-task',
    //         component: AddTaskComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'list-task',
    //         component: ListTaskComponent
    //     }]
    // }, {
    //     path: '',
    //     children: [ {
    //         path: 'edit-task',
    //         component: EditTaskComponent
    //     }]
    // }
    { path: 'dashboard',      component: DashboardComponent },
    { path: 'user-profile',   component: UserProfileComponent },
    { path: 'table-list',     component: TableListComponent },
    { path: 'task',           component: TaskComponent},
    { path: 'add-task',       component: AddTaskComponent},
    { path: 'list-task',      component: ListTaskComponent},
    { path: 'edit-task',      component: EditTaskComponent },
    { path: 'typography',     component: TypographyComponent },
    { path: 'icons',          component: IconsComponent },
    { path: 'maps',           component: MapsComponent },
    { path: 'notifications',  component: NotificationsComponent },
    { path: 'upgrade',        component: UpgradeComponent },
];
