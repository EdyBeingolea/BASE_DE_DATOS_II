/* utiliza el user master*/
 use master
 Go
/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes 
GO

/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes 
GO

/* Poner en uso la base de datos */
USE db_SalesClothes 
GO


/* Ver idioma de SQL Server */
SELECT @@language AS 'Idioma'
GO

/* Ver idiomas disponibles en SQL Server */
EXEC sp_helplanguage
GO

/* Configurar idioma español en el servidor */
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO


/* Ver formato de fecha y hora del servidor */
SELECT sysdatetime() as 'Fecha y  hora'
GO

/* Configurar el formato de fecha */
SET DATEFORMAT dmy
GO

/* Crear tabla client */
CREATE TABLE client
(
	id int identity(1,1), 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80) CHECK(email LIKE '%_@%_._%'),
	cell_phone char(9) CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	birthdate date CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18),
	active bit DEFAULT (1)
	CONSTRAINT client_pk PRIMARY KEY (id),
	CONSTRAINT type_document_check CHECK(
        (type_document = 'DNI' AND LEN(number_document) = 8) OR
        (type_document = 'CNE' AND LEN(number_document) = 9)
    ),
    CONSTRAINT number_document_check CHECK(
        (type_document = 'DNI' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') OR
        (type_document = 'CNE' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    )
)
Go


--crear tabla seller
CREATE TABLE seller
(
	id int identity(1,1), 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	salary decimal(8,2)default(1025),
	cell_phone char(9)check(cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email varchar(80)check(email like '%_@%_._%') ,
	active bit default(1)
	CONSTRAINT seller_pk PRIMARY KEY (id),
	CONSTRAINT type_document_check1 CHECK(
        (type_document = 'DNI' AND LEN(number_document) = 8) OR
        (type_document = 'CNE' AND LEN(number_document) = 9)
    ),
    CONSTRAINT number_document_check1 CHECK(
        (type_document = 'DNI' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') OR
        (type_document = 'CNE' AND number_document LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    )
)
go

--crear tabla clothes
CREATE TABLE clothes
(
	id int identity(1,1), 
	descriptions varchar(60),
	brand varchar(60),
	amount int,
	size varchar(10),
	price decimal(8,2),
	active bit default(1)
	CONSTRAINT clothes_pk PRIMARY KEY (id)
)
go

--crear tabla sale
CREATE TABLE sale
(
	id int identity(1,1), 
	date_time datetime default getdate(),
	seller_id int,
	client_id int,
	active bit default(1)
	CONSTRAINT sale_pk PRIMARY KEY (id)
)
go

--crear tabla sale_detail
CREATE TABLE sale_detail
(
	id int, 
	sale_id int,
	clothes_id int,
	amount int,
	CONSTRAINT sale_detail_pk PRIMARY KEY (id)
)
go

--- Relaciones---

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla seller */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla sale */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla clothes */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

--Verificar las ralaciones de las tablas
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

--------------------------- Actividad 2 ---------------------


--Insertar los siguientes registros en la tabla client
insert into client (type_document,number_document,names,last_name,email,cell_phone,birthdate)
VALUES
    ('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '2005-01-19'),
    ('DNI', '14782536', 'Marcos', 'Davila Palomino', 'marcosdavila@gmail.com', '982514752', '1990-03-03'),
    ('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '1995-10-03'),
    ('CNE', '352514789', 'Claudia Maria', 'Martinez Rodriguez', 'claudiamartinez@yahoo.com', '995522147', '1992-09-23'),
    ('CNE', '142536792', 'MarioTadeo', 'Farfan Castillo', 'mariotadeo@outlook.com', '973125478', '1997-11-25'),
    ('DNI', '58251433', 'AnaLucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '1992-10-17'),
    ('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '1990-05-27'),
    ('CNE', '442233698', 'Rosario', 'Prada Velasquez', 'rosarioprada@outlook.com', '971144782', '1990-11-05')
go

--Insertar los siguientes registros en la tabla seller
insert into seller (type_document,number_document,names,last_name,cell_phone,email)
values
('DNI', '11224578', 'Oscar', 'Paredes Flores', '985566251', 'oparedes@miemrpesa.com'),
('CNE', '889922365', 'Azucena', 'Valle Alcazar', '966338874', 'avalle@miemrpesa.com'),
('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '933665521', 'rhuaraca@miemrpesa.com')
go

--Insertar los siguientes registros en la tabla clothes
INSERT INTO clothes (descriptions, brand, amount, size, price)
VALUES
    ('Polo camisero', 'Adidas', 20, 'Medium', 40.50),
    ('Short playero', 'Nike', 30, 'Medium', 55.50),
    ('Camisa sport', 'Adams', 70, 'Large', 60.80),
    ('Camisa sport', 'Adams', 45, 'Medium', 58.75),
    ('Buzo de verano', 'Reebok', 35, 'Small', 62.90),
    ('Pantalon Jean', 'Lewis', 73, 'Large', 73.60)
Go


--Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI
SELECT * FROM client
WHERE type_document = 'DNI';

--Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com.
SELECT * FROM client
WHERE email LIKE '%@outlook.com';

--Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE.
SELECT * FROM seller
WHERE type_document = 'CNE';

--Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00
SELECT * FROM clothes
WHERE price <= 55.00;

--Listar todas las prendas de ropa (clothes) cuya marca sea Adams.
SELECT * FROM clothes
WHERE brand = 'Adams';

--Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id.
UPDATE client 
SET active = 0
WHERE id = 1;

--Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id.
UPDATE seller
SET active = 0
WHERE id = 1;

--Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id 
UPDATE clothes
SET active = 0
WHERE id = 1;

--listar las tablas
select * from client;
select * from seller;
select * from clothes;

