/* Usamos master */
 use master
 go

/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS ramdon
go

/* Creamos la base de datos */
create database ramdon
go

/* La ponemos en uso */
use ramdon
go

--- Tenemos de Tablas de usuario fijas 

CREATE TABLE Vendedor (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Direccion VARCHAR(100),
    Telefono VARCHAR(15)
)
go

INSERT INTO Vendedor (ClienteID, Nombre, Direccion, Telefono)
VALUES
    (1, 'Juan Pérez', 'Calle 123, Ciudad A', '123-456-7890'),
    (2, 'María Gómez', 'Avenida 456, Ciudad B', '987-654-3210'),
    (3, 'Carlos Rodríguez', 'Plaza 789, Ciudad C', '555-123-4567'),
    (4, 'Ana López', 'Calle 987, Ciudad A', '777-888-9999')
go

select * from Vendedor;


--- Tenemos las Tablas Temporales
---las locales
CREATE TABLE #resultado (
    ID INT,
    Resultado VARCHAR(50)
)
go

INSERT INTO #resultado (ID, Resultado)
VALUES
    (1, 'Éxito'),
    (2, 'Fracaso'),
    (3, 'Pendiente')
	go

select * from #resultado;

drop table #resultado
GO

--- las globales
CREATE TABLE ##ReporteMensual (
    Mes INT,
    Reporte VARCHAR(100)
)
go

INSERT INTO ##ReporteMensual (Mes, Reporte)
VALUES
    (1, 'Reporte de enero'),
    (2, 'Reporte de febrero'),
    (3, 'Reporte de marzo')
	go

select * from ##ReporteMensual
go

drop table ##ReporteMensual
GO

--- Tenemos las Tablas de variables 

CREATE TABLE Ventas (
    ID INT PRIMARY KEY,
    FechaVenta DATE,
    Monto DECIMAL(10, 2)
);

INSERT INTO Ventas (ID, FechaVenta, Monto)
VALUES
    (1, '2023-01-15', 100.50),
    (2, '2023-02-10', 200.75),
    (3, '2023-03-20', 150.25),
    (4, '2023-06-28', 75.00)
go

DECLARE @DatosVentas TABLE (
    ID INT,
    FechaVenta DATE,
    Monto DECIMAL(8,2)
);


INSERT INTO @DatosVentas
SELECT ID, FechaVenta, Monto
FROM Ventas
WHERE FechaVenta BETWEEN '2023-01-01' AND '2023-06-30'
;

SELECT SUM(Monto) AS TotalVentas
FROM @DatosVentas
;

-- Ejemplo: Obtener promedio de ventas mensuales
SELECT DATEPART(MONTH, FechaVenta) AS Mes, AVG(Monto) AS PromedioVenta
FROM @DatosVentas
GROUP BY DATEPART(MONTH, FechaVenta)
go

