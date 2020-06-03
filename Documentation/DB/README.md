# Esquematización de bases de datos para TecnoExpress

La esquematización y manejo para almacenar los datos en el proyecto TECNOEXPRESS se va a manejar de forma desacoplada. En vista de que la arquitectura sistematica del proyecto está orientada en microservicios (cada microservicio debe contener su propia base de datos) y se va a manejar un motor de base de datos relacional, **no se puede desacoplar a perpetuidad toda la base de datos por módulos.** Sin embargo, se logró desacoplar algunos esquemas sin perder la mayor cantidad de depencias posibles.

## Esquema de base de datos
Se descopló la base de datos de forma que se definieron "esquemas padres" los cuales me definen la base de datos que abarca cada módulo (s) del aplicativo.

* [Clientes](#a)
** Clientes
** Contactos de clientes

* [Inventario](#b)
** Inventario
** Órdenes de compra
** Proveedores
** Contactos de proveedores
** Despachos

* [Precotizaciones](#c)
** Precotizaciones
** Cotizaciones
** Lista de precios (toca mirar)

* [Usuarios](#d)
** Usuarios
** Contactos de usuarios
** Log del sistema