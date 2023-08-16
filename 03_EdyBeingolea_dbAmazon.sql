/* utiliza el user master*/
 use master
 GO

/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS dbAmazon 
GO

/* Crear base de datos Sales Clothes */
CREATE DATABASE dbAmazon 
GO

/* Poner en uso la base de datos */
USE dbAmazon 
GO

/* Creacion de Schemas */

CREATE SCHEMA PERSONA
GO

CREATE SCHEMA PRODUCTO
GO

CREATE SCHEMA VENTAS
GO

CREATE SCHEMA COMPRAS
GO

/* Modificar tipos de datos*/

CREATE TYPE codigo FROM char(5)
go
CREATE TYPE identificador FROM int
go
CREATE TYPE nombre FROM varchar(60)
go
CREATE TYPE quantity FROM int
go
CREATE TYPE precio FROM decimal(8,2)
go
CREATE TYPE apellidos FROM varchar(90)
go
CREATE TYPE nacimiento FROM datetime
go

/* Tablas  */



CREATE TABLE CLIENTE (
    id identificador,
    names nombre,
    last_names apellidos,
    birthday nacimiento,
    state CHAR(1)
);


CREATE TABLE Producto (
    code codigo,
    description nombre,
    stock quantity,
    price precio,
    state CHAR(1)
);


ALTER SCHEMA PERSONA
TRANSFER dbo.cliente
GO

ALTER SCHEMA PRODUCTO
TRANSFER dbo.producto
GO


/* Cracion de Filegroup */


-----FGCLIENTE
alter database dbAmazon
add filegroup FGCLIENTE
Go

alter database dbAmazon
add file 
(
   name= cliente,filename = 'c:\AmazonData\Clientes.ndf'
)to filegroup FGCLIENTE


-----FGPRODUCTO
alter database dbAmazon
add filegroup FGPRODUCTO
Go

alter database dbAmazon
add file 
(
   name= producto,filename = 'c:\AmazonData\Producto.ndf'
)to filegroup FGPRODUCTO


-----FGVENTA
alter database dbAmazon
add filegroup FGVENTA
Go

alter database dbAmazon
add file 
(
   name= venta,filename = 'c:\AmazonData\Venta.ndf'
)to filegroup FGVENTA
