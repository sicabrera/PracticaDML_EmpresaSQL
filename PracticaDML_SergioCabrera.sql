/* PARTE I - CREAR BASE DE DATOS */ 

use master

go

if exists (select name from sys.databases where name = 'EmpresaSQL')
begin
    alter database EmpresaSQL set single_user with rollback immediate
    drop database EmpresaSQL
end

go

-- Crear y usar la base de datos
create database EmpresaSQL
go

--Seleccionar EmpresaSQL para trabajar
use EmpresaSQL
go

-- Crear una tabla llamada TDepartamento 
create table TDepartamento(
nDepartamentoID int identity(1,1) constraint PK_nDepartamentoID primary key,
cNombreDepartamento nvarchar(60) not null constraint U_cNombreDepartamento unique, 
);


-- Crear una tabla llamada TCargo 
create table TCargo(
nCargoID int identity(1,1) constraint PK_nCargoID primary key,
cNombreCargo nvarchar(60) not null constraint U_cNombreCargo unique, 
);

-- Crear una tabla llamada TEmpleado 
create table TEmpleado(
nEmpleadoID int identity(1,1) constraint PK_nEmpleadoID primary key,
cNIF nvarchar(20) not null constraint U_cNIF unique,
cNombre nvarchar(60) not null,
cApellido nvarchar(60) not null, 
nDepartamentoID int constraint FK_DepartamentoEmpleado foreign key (nDepartamentoID) references TDepartamento(nDepartamentoID),
nCargoID int constraint FK_CargoEmpleado foreign key (nCargoID) references TCargo(nCargoID), 
dFechaContratacion datetime constraint DF_FechaContratacion default getdate(),
nSalario decimal(10,2) not null constraint CHK_Salario check( nSalario > 300)

);

--Crear tabla TProyecto
create table TProyecto(
nProyectoID int identity(1,1) constraint PK_nProyectoID primary key,
cNombreProyecto nvarchar(50) not null,
dFechaInicio date not null, 
dFechaFinalizacion date null, 



);

-- Crear tabla TEmpleadoProyecto
create table TEmpleadoProyecto(
nEmpleadoProyectoID int identity(1,1) constraint PK_TEmpleadoProyecto primary key,
nEmpleadoID int constraint FK_Empleado_EmpleadoProyecto foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID), 
nProyectoID int constraint FK_Proyecto_EmpleadoProyecto foreign key (nProyectoID) references TProyecto(nProyectoID)

);

/* PARTE II -  ALTERS */ 

-- Agregar cEmail a TEmpleado
alter table TEmpleado
add cEmail nvarchar(60); 
go 

-- Agregar columna cTelefono
alter table TEmpleado 
add cTelefono nvarchar(15); 
go

--Modificar longitud de cNombre a 100caracteres 
alter table TEmpleado
alter column cNombre nvarchar(100) not null;
go 

--Modificar longitud de cApellido a 100 caracteres 
alter table TEmpleado 
alter column cApellido nvarchar(100) not null; 
go 

--Agregar columna cDireccion 
alter table TEmpleado 
add cDireccion nvarchar(MAX); 
go

--Agregar la columna nEdad 
alter table TEmpleado 
add nEdad int;
go 

--Crear restriccion check para edades entre 18 y 65 años
alter table TEmpleado 
add constraint CHK_nEdad check(nEdad > 18 and nEdad < 65);
go 

--agregar restriccion unique al correo electronico 
alter table TEmpleado 
add constraint U_Email unique(cEmail)

--Agregar columna bActivo defecto 1
alter table TEmpleado 
add bActivo bit constraint DF_bActivo default 1;
go 

--Eliminar la columna cDireccion 
alter table TEmpleado 
drop column cDireccion;
go 

--Cambiar el tipo de datos de telefono a Varchar(20) 
alter table TEmpleado 
alter column cTelefono varchar(20);
go 

--Agregar columna cGenero 
alter table TEmpleado 
add cGenero varchar(1);
go 

--Agregar restriccion genero = M o F 
alter table TEmpleado
add constraint CHK_cGenero check(cGenero IN ('F', 'M'));
go 

-- Agregar columna dFechaNacimiento 
alter table TEmpleado 
add dFechaNacimiento date; 
go 

-- Crear nueva tabla llamada TSucursal
create table TSucursal(
nSucursalID int identity(1,1) constraint PK_nSucursalID primary key,
cNombreSucursal nvarchar(30) not null

);

/* PARTE III - INSERTS */ 

-- 31. Insertar 5 departamentos diferentes
insert into TDepartamento (cNombreDepartamento)
values
('Recursos Humanos'),
('Contabilidad'),
('Ventas'),
('Tecnología'),
('Administración');

-- 32. insertar 5 cargos diferentes
insert into TCargo (cNombreCargo)
values
('Gerente'),
('Contador'),
('Vendedor'),
('Desarrollador'),
('Asistente Administrativo');

-- 33. insertar 10 empleados
insert into TEmpleado (
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    dFechaContratacion,
    nSalario,
    cEmail
)
values
('001001', 'Carlos', 'González', 1, 1, '2024-01-15', 1200, 'carlos.gonzalez@empresa.com'),
('001002', 'María', 'López', 2, 2, '2024-02-10', 950, 'maria.lopez@empresa.com'),
('001003', 'José', 'Martínez', 3, 3, '2024-03-05', 700, 'jose.martinez@empresa.com'),
('001004', 'Ana', 'Ramírez', 4, 4, '2024-04-20', 1500, 'ana.ramirez@empresa.com'),
('001005', 'Luis', 'Hernández', 5, 5, '2024-05-12', 600, 'luis.hernandez@empresa.com'),
('001006', 'Sofía', 'Castillo', 1, 5, '2024-06-18', 550, 'sofia.castillo@empresa.com'),
('001007', 'Pedro', 'García', 3, 3, '2024-07-22', 800, 'pedro.garcia@empresa.com'),
('001008', 'Lucía', 'Morales', 4, 4, '2024-08-30', 1600, 'lucia.morales@empresa.com'),
('001009', 'Miguel', 'Torres', 2, 2, '2024-09-14', 1000, 'miguel.torres@empresa.com'),
('001010', 'Valeria', 'Reyes', 5, 1, '2024-10-01', 1300, 'valeria.reyes@empresa.com');

-- 34. insertar 3 proyectos
insert into TProyecto (
    cNombreProyecto,
    dFechaInicio,
    dFechaFinalizacion
)
values
('Jaguarcito UAM', '2026-01-10', '2026-06-30'),
('Página Web Corporativa', '2026-03-01', '2026-08-15'),
('Aplicación Móvil', '2026-05-20', '2026-12-10');

-- 35. asignar empleados a proyectos
insert into TEmpleadoProyecto (
    nEmpleadoID,
    nProyectoID
)
values
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 3),
(8, 3),
(9, 3),
(10, 3);

-- 36. insertar un empleado utilizando el valor por defecto de fecha
insert into TEmpleado (
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    nSalario,
    cTelefono,
    nEdad,
    cGenero,
    dFechaNacimiento
)
values (
    '001011',
    'Diego',
    'Mendoza',
    4,
    4,
    1450,
    '8888-1111',
    28,
    'M',
    '1998-04-12'
);

-- 37. insertar un empleado con correo electrónico
insert into TEmpleado (
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    dFechaContratacion,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    bActivo,
    cGenero,
    dFechaNacimiento
)
values (
    '001012',
    'Camila',
    'Flores',
    2,
    2,
    '2026-02-14',
    980,
    'camila.flores@empresa.com',
    '8888-2222',
    26,
    1,
    'F',
    '2000-09-18'
);

-- 38. insertar un empleado sin indicar estado activo
insert into TEmpleado (
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    dFechaContratacion,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    cGenero,
    dFechaNacimiento
)
values (
    '001013',
    'Fernando',
    'Gutiérrez',
    3,
    3,
    '2026-04-05',
    750,
    'fernando.gutierrez@empresa.com',
    '8888-3333',
    30,
    'M',
    '1996-11-25'
);

-- 39. insertar registros usando múltiples values
insert into TEmpleado (
    cNIF,
    cNombre,
    cApellido,
    nDepartamentoID,
    nCargoID,
    dFechaContratacion,
    nSalario,
    cEmail,
    cTelefono,
    nEdad,
    bActivo,
    cGenero,
    dFechaNacimiento
)
values
(
    '001014',
    'Andrea',
    'Salazar',
    1,
    5,
    '2026-05-10',
    620,
    'andrea.salazar@empresa.com',
    '8888-4444',
    24,
    1,
    'F',
    '2002-03-14'
),
(
    '001015',
    'Roberto',
    'Pérez',
    4,
    4,
    '2026-06-01',
    1550,
    'roberto.perez@empresa.com',
    '8888-5555',
    32,
    1,
    'M',
    '1994-07-22'
),
(
    '001016',
    'Gabriela',
    'Gómez',
    3,
    3,
    '2026-06-15',
    850,
    'gabriela.gomez@empresa.com',
    '8888-6666',
    27,
    1,
    'F',
    '1999-12-08'
);

-- 40. intentar insertar un salario negativo y analizar el error
begin try
    insert into TEmpleado (
        cNIF,
        cNombre,
        cApellido,
        nDepartamentoID,
        nCargoID,
        dFechaContratacion,
        nSalario,
        cEmail,
        cTelefono,
        nEdad,
        bActivo,
        cGenero,
        dFechaNacimiento
    )
    values (
        '001017',
        'Mario',
        'Rivas',
        1,
        1,
        '2026-07-01',
        -500,
        'mario.rivas@empresa.com',
        '8888-7777',
        29,
        1,
        'M',
        '1997-05-20'
    );

    print 'empleado insertado correctamente';
end try
begin catch
    print 'error: no se pudo insertar el empleado porque el salario no cumple la restriccion check';
    print error_message();
end catch;

/* PARTE IV - UPDATES */ 

-- 41. incrementar en 10% el salario de todos los empleados
update TEmpleado
set nSalario = nSalario * 1.10;

-- 42. incrementar en 20% el salario de los empleados de un departamento específico (use tecnologia)

update TEmpleado
set nSalario = nSalario * 1.20
where nDepartamentoID = 4;

-- 43. actualizar el correo electrónico de un empleado
update TEmpleado
set cEmail = 'carlos.gonzalez.actualizado@empresa.com'
where cNIF = '001001';

-- 44. modificar el cargo de un empleado
--(cambie el cargo del empleado 3 a cargo 4)
update TEmpleado
set nCargoID = 4
where nEmpleadoID = 3;

-- 45. cambiar el departamento de dos empleados
update TEmpleado
set nDepartamentoID = 2
where nEmpleadoID in (5, 6);

-- 46. marcar como inactivos a los empleados con salario inferior a 500
update TEmpleado
set bActivo = 0
where nSalario < 500;

-- 47. actualizar la fecha de finalización de un proyecto
-- actualice el proyecto Jaguarcito UAM
update TProyecto
set dFechaFinalizacion = '2026-07-15'
where nProyectoID = 1;

-- 48. asignar un nuevo proyecto a un empleado
insert into TEmpleadoProyecto (
    nEmpleadoID,
    nProyectoID
)
values (
    1,
    3
);

/*  PARTE V - DELETES */ 

-- 49. eliminar un empleado específico mediante su nif
delete from TEmpleado
where cNIF = '001016';

-- 50. eliminar todos los empleados inactivos
delete from TEmpleado
where bActivo = 0;

-- 51. eliminar un proyecto específico
delete from TEmpleadoProyecto
where nProyectoID = 2;

delete from TProyecto
where nProyectoID = 2;

-- 52. eliminar las asignaciones de un empleado en la tabla TEmpleadoProyecto
delete from TEmpleadoProyecto
where nEmpleadoID = 1;

-- 53. eliminar un departamento que no tenga empleados asociados
delete from TDepartamento
where nDepartamentoID = 5
and nDepartamentoID not in (
    select nDepartamentoID
    from TEmpleado
    where nDepartamentoID is not null
);

/* CONSULTAS VERIFICACION */
 
 -- 54. mostrar todos los empleados ordenados por apellido
select *
from TEmpleado
order by cApellido asc;

-- 55. mostrar empleados con salario mayor a 1,000
select *
from TEmpleado
where nSalario > 1000;

-- 56. mostrar empleados activos
select *
from TEmpleado
where bActivo = 1;

-- 57. mostrar empleados contratados durante el año actual
select *
from TEmpleado
where year(dFechaContratacion) = year(getdate());

-- 58. mostrar empleados y el nombre de su departamento
select 
    e.nEmpleadoID,
    e.cNombre,
    e.cApellido,
    d.cNombreDepartamento
from TEmpleado e
inner join TDepartamento d
    on e.nDepartamentoID = d.nDepartamentoID;

    -- 59. mostrar empleados y el nombre de su cargo
select 
    e.nEmpleadoID,
    e.cNombre,
    e.cApellido,
    c.cNombreCargo
from TEmpleado e
inner join TCargo c
    on e.nCargoID = c.nCargoID;

    -- 60. mostrar empleados asignados a proyectos
select 
    e.nEmpleadoID,
    e.cNombre,
    e.cApellido,
    p.cNombreProyecto
from TEmpleado e
inner join TEmpleadoProyecto ep
    on e.nEmpleadoID = ep.nEmpleadoID
inner join TProyecto p
    on ep.nProyectoID = p.nProyectoID;

    -- 61. mostrar cantidad de empleados por departamento
select 
    d.cNombreDepartamento,
    count(e.nEmpleadoID) as cantidad_empleados
from TDepartamento d
left join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;

-- 62. mostrar salario promedio por departamento
select 
    d.cNombreDepartamento,
    avg(e.nSalario) as salario_promedio
from TDepartamento d
inner join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;

-- 63. mostrar salario máximo y mínimo por departamento
select 
    d.cNombreDepartamento,
    max(e.nSalario) as salario_maximo,
    min(e.nSalario) as salario_minimo
from TDepartamento d
inner join TEmpleado e
    on d.nDepartamentoID = e.nDepartamentoID
group by d.cNombreDepartamento;

-- 64. mostrar los proyectos con más de dos empleados asignados
select 
    p.cNombreProyecto,
    count(ep.nEmpleadoID) as cantidad_empleados
from TProyecto p
inner join TEmpleadoProyecto ep
    on p.nProyectoID = ep.nProyectoID
group by p.cNombreProyecto
having count(ep.nEmpleadoID) > 2;

-- 65. mostrar empleados cuyo apellido inicia con "G"
select *
from TEmpleado
where cApellido like 'G%';

-- 66. mostrar empleados ordenados por salario descendente
select *
from TEmpleado
order by nSalario desc;

-- 67. mostrar los tres salarios más altos
select top 3 *
from TEmpleado
order by nSalario desc;

-- 68. mostrar empleados con edad entre 25 y 40 años
select *
from TEmpleado
where nEdad between 25 and 40;

-- 69. mostrar cantidad total de empleados activos
select count(*) as total_empleados_activos
from TEmpleado
where bActivo = 1;

-- 70. mostrar el total de proyectos registrados
select count(*) as total_proyectos
from TProyecto;

/* DESAFIOS ADICIONALES (LO PONGO ACA PQ SI NO SE BORRA LA BASE DE DATOS) */

-- 81. crear una tabla TCliente con al menos 8 campos y restricciones
create table TCliente (
    nClienteID int identity(1,1),
    cNIF varchar(20) not null,
    cNombre varchar(100) not null,
    cApellido varchar(100) not null,
    cEmail varchar(100) not null,
    cTelefono varchar(20),
    cDireccion varchar(150),
    dFechaRegistro date default getdate(),
    bActivo bit default 1,

    constraint PK_TCliente primary key (nClienteID),
    constraint UQ_TCliente_NIF unique (cNIF),
    constraint UQ_TCliente_Email unique (cEmail)
);

-- 82. crear una tabla TVenta relacionada con TCliente
create table TVenta (
    nVentaID int identity(1,1),
    nClienteID int not null,
    nEmpleadoID int null,
    dFechaVenta date default getdate(),
    cProducto varchar(100) not null,
    nCantidad int not null,
    nPrecioUnitario decimal(10,2) not null,
    nMontoTotal as (nCantidad * nPrecioUnitario),
    cMetodoPago varchar(50),

    constraint PK_TVenta primary key (nVentaID),
    constraint FK_TVenta_TCliente foreign key (nClienteID) references TCliente(nClienteID),
    constraint FK_TVenta_TEmpleado foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID),
    constraint CHK_TVenta_Cantidad check (nCantidad > 0),
    constraint CHK_TVenta_Precio check (nPrecioUnitario > 0)
);

-- 83. registrar 20 clientes
insert into TCliente (
    cNIF,
    cNombre,
    cApellido,
    cEmail,
    cTelefono,
    cDireccion
)
values
('C001', 'Carlos', 'González', 'carlos.gonzalez@gmail.com', '8888-1001', 'Managua'),
('C002', 'María', 'López', 'maria.lopez@gmail.com', '8888-1002', 'León'),
('C003', 'José', 'Martínez', 'jose.martinez@gmail.com', '8888-1003', 'Granada'),
('C004', 'Ana', 'Ramírez', 'ana.ramirez@gmail.com', '8888-1004', 'Masaya'),
('C005', 'Luis', 'Hernández', 'luis.hernandez@gmail.com', '8888-1005', 'Chinandega'),
('C006', 'Sofía', 'Castillo', 'sofia.castillo@gmail.com', '8888-1006', 'Estelí'),
('C007', 'Pedro', 'García', 'pedro.garcia@gmail.com', '8888-1007', 'Matagalpa'),
('C008', 'Lucía', 'Morales', 'lucia.morales@gmail.com', '8888-1008', 'Jinotepe'),
('C009', 'Miguel', 'Torres', 'miguel.torres@gmail.com', '8888-1009', 'Rivas'),
('C010', 'Valeria', 'Reyes', 'valeria.reyes@gmail.com', '8888-1010', 'Bluefields'),
('C011', 'Diego', 'Mendoza', 'diego.mendoza@gmail.com', '8888-1011', 'Managua'),
('C012', 'Camila', 'Flores', 'camila.flores@gmail.com', '8888-1012', 'León'),
('C013', 'Fernando', 'Gutiérrez', 'fernando.gutierrez@gmail.com', '8888-1013', 'Granada'),
('C014', 'Andrea', 'Salazar', 'andrea.salazar@gmail.com', '8888-1014', 'Masaya'),
('C015', 'Roberto', 'Pérez', 'roberto.perez@gmail.com', '8888-1015', 'Chinandega'),
('C016', 'Gabriela', 'Gómez', 'gabriela.gomez@gmail.com', '8888-1016', 'Estelí'),
('C017', 'Daniel', 'Vargas', 'daniel.vargas@gmail.com', '8888-1017', 'Matagalpa'),
('C018', 'Paola', 'Navarro', 'paola.navarro@gmail.com', '8888-1018', 'Jinotepe'),
('C019', 'Javier', 'Cruz', 'javier.cruz@gmail.com', '8888-1019', 'Rivas'),
('C020', 'Natalia', 'Rojas', 'natalia.rojas@gmail.com', '8888-1020', 'Bluefields');

-- 84. registrar 50 ventas
insert into TVenta (
    nClienteID,
    nEmpleadoID,
    dFechaVenta,
    cProducto,
    nCantidad,
    nPrecioUnitario,
    cMetodoPago
)
values
(1, 1, '2026-01-05', 'Laptop', 1, 850.00, 'Tarjeta'),
(2, 1, '2026-01-08', 'Mouse', 2, 15.00, 'Efectivo'),
(3, 1, '2026-01-12', 'Teclado', 1, 35.00, 'Tarjeta'),
(4, 1, '2026-01-15', 'Monitor', 1, 180.00, 'Transferencia'),
(5, 1, '2026-01-20', 'Audífonos', 2, 25.00, 'Efectivo'),
(6, 2, '2026-02-02', 'Laptop', 1, 900.00, 'Tarjeta'),
(7, 2, '2026-02-05', 'Impresora', 1, 160.00, 'Transferencia'),
(8, 2, '2026-02-10', 'Mouse', 3, 15.00, 'Efectivo'),
(9, 2, '2026-02-12', 'Tablet', 1, 300.00, 'Tarjeta'),
(10, 2, '2026-02-18', 'Cargador', 2, 20.00, 'Efectivo'),
(11, 3, '2026-03-01', 'Monitor', 2, 175.00, 'Tarjeta'),
(12, 3, '2026-03-03', 'Teclado', 2, 35.00, 'Efectivo'),
(13, 3, '2026-03-06', 'Laptop', 1, 870.00, 'Transferencia'),
(14, 3, '2026-03-10', 'Audífonos', 1, 30.00, 'Efectivo'),
(15, 3, '2026-03-14', 'Mouse', 4, 15.00, 'Tarjeta'),
(16, 4, '2026-04-01', 'Tablet', 1, 320.00, 'Transferencia'),
(17, 4, '2026-04-04', 'Impresora', 1, 150.00, 'Efectivo'),
(18, 4, '2026-04-08', 'Cargador', 3, 20.00, 'Tarjeta'),
(19, 4, '2026-04-11', 'Monitor', 1, 190.00, 'Transferencia'),
(20, 4, '2026-04-15', 'Laptop', 1, 920.00, 'Tarjeta'),
(1, 5, '2026-05-01', 'Mouse', 2, 15.00, 'Efectivo'),
(2, 5, '2026-05-03', 'Teclado', 1, 40.00, 'Tarjeta'),
(3, 5, '2026-05-05', 'Audífonos', 2, 25.00, 'Efectivo'),
(4, 5, '2026-05-07', 'Tablet', 1, 310.00, 'Transferencia'),
(5, 5, '2026-05-09', 'Monitor', 1, 185.00, 'Tarjeta'),
(6, 6, '2026-05-11', 'Cargador', 2, 20.00, 'Efectivo'),
(7, 6, '2026-05-13', 'Laptop', 1, 880.00, 'Tarjeta'),
(8, 6, '2026-05-15', 'Mouse', 1, 15.00, 'Efectivo'),
(9, 6, '2026-05-17', 'Impresora', 1, 155.00, 'Transferencia'),
(10, 6, '2026-05-19', 'Teclado', 3, 35.00, 'Tarjeta'),
(11, 7, '2026-06-01', 'Laptop', 1, 910.00, 'Tarjeta'),
(12, 7, '2026-06-02', 'Mouse', 2, 15.00, 'Efectivo'),
(13, 7, '2026-06-03', 'Monitor', 1, 200.00, 'Transferencia'),
(14, 7, '2026-06-04', 'Audífonos', 1, 25.00, 'Efectivo'),
(15, 7, '2026-06-05', 'Tablet', 1, 330.00, 'Tarjeta'),
(16, 8, '2026-06-06', 'Cargador', 4, 20.00, 'Efectivo'),
(17, 8, '2026-06-07', 'Impresora', 1, 165.00, 'Transferencia'),
(18, 8, '2026-06-08', 'Laptop', 1, 890.00, 'Tarjeta'),
(19, 8, '2026-06-09', 'Teclado', 2, 35.00, 'Efectivo'),
(20, 8, '2026-06-10', 'Mouse', 3, 15.00, 'Tarjeta'),
(1, 9, '2026-06-11', 'Monitor', 1, 195.00, 'Transferencia'),
(2, 9, '2026-06-12', 'Audífonos', 2, 30.00, 'Efectivo'),
(3, 9, '2026-06-13', 'Tablet', 1, 315.00, 'Tarjeta'),
(4, 9, '2026-06-14', 'Cargador', 2, 20.00, 'Efectivo'),
(5, 9, '2026-06-15', 'Laptop', 1, 930.00, 'Tarjeta'),
(6, 10, '2026-06-16', 'Mouse', 2, 15.00, 'Efectivo'),
(7, 10, '2026-06-17', 'Teclado', 1, 45.00, 'Transferencia'),
(8, 10, '2026-06-18', 'Monitor', 1, 185.00, 'Tarjeta'),
(9, 10, '2026-06-19', 'Audífonos', 3, 25.00, 'Efectivo'),
(10, 10, '2026-06-20', 'Impresora', 1, 170.00, 'Transferencia');

-- 85. actualizar precios o montos de ventas según una condición
update TVenta
set nPrecioUnitario = nPrecioUnitario * 1.10
where cProducto = 'Laptop';

-- 86. eliminar clientes sin ventas
delete from TCliente
where nClienteID not in (
    select nClienteID
    from TVenta
);

-- 87. consultar los 5 clientes con mayores compras
select top 5
    c.nClienteID,
    c.cNombre,
    c.cApellido,
    sum(v.nMontoTotal) as total_compras
from TCliente c
inner join TVenta v
    on c.nClienteID = v.nClienteID
group by c.nClienteID, c.cNombre, c.cApellido
order by total_compras desc;

-- 88. consultar ventas por mes
select
    year(dFechaVenta) as anio,
    month(dFechaVenta) as mes,
    sum(nMontoTotal) as total_ventas
from TVenta
group by year(dFechaVenta), month(dFechaVenta)
order by anio, mes;

-- 89. consultar promedio de ventas por cliente
select
    c.nClienteID,
    c.cNombre,
    c.cApellido,
    avg(v.nMontoTotal) as promedio_ventas
from TCliente c
inner join TVenta v
    on c.nClienteID = v.nClienteID
group by c.nClienteID, c.cNombre, c.cApellido;

-- 90. generar un reporte consolidado utilizando join entre tres tablas
select
    v.nVentaID,
    v.dFechaVenta,
    c.cNombre + ' ' + c.cApellido as cliente,
    e.cNombre + ' ' + e.cApellido as empleado_vendedor,
    v.cProducto,
    v.nCantidad,
    v.nPrecioUnitario,
    v.nMontoTotal,
    v.cMetodoPago
from TVenta v
inner join TCliente c
    on v.nClienteID = c.nClienteID
inner join TEmpleado e
    on v.nEmpleadoID = e.nEmpleadoID
order by v.dFechaVenta;

/* ADMINISTRACION DE OBJETOS */ 

-- 71. eliminar la restricción check de edad
alter table TEmpleado
drop constraint CHK_nEdad;

-- 72. eliminar la restricción unique del correo
alter table TEmpleado
drop constraint U_Email;

-- 73. agregar nuevamente ambas restricciones
alter table TEmpleado
add constraint CHK_nEdad check (nEdad between 18 and 65);

alter table TEmpleado
add constraint U_Email unique (cEmail);

-- 74. eliminar la tabla TEmpleadoProyecto
drop table TEmpleadoProyecto;

-- eliminar tabla de ventas de los desafíos adicionales
drop table TVenta;

-- 75. eliminar la tabla TProyecto
drop table TProyecto;

-- eliminar tabla de clientes de los desafíos adicionales
drop table TCliente;

-- 76. eliminar la tabla TEmpleado
drop table TEmpleado;

-- 77. eliminar la tabla TCargo
drop table TCargo;

-- 78. eliminar la tabla TDepartamento
drop table TDepartamento;

-- 79. eliminar la tabla TSucursal
drop table TSucursal;

-- 80. eliminar la base de datos EmpresaSQL
use master;
go

drop database EmpresaSQL;