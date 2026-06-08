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
dFechaFinal date null, 



);

-- Crear tabla TEmpleadoProyecto
create table TEmpleadoProyecto(
nEmpleadoProyectoID int identity(1,1) constraint PK_TEmpleadoProyecto primary key,
nEmpleadoID int constraint FK_Empleado_EmpleadoProyecto foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID), 
nProyectoID int constraint FK_Proyecto_EmpleadoProyecto foreign key (nProyectoID) references TProyecto(nProyectoID)

);

/* ALTERS */ 

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
add constraint CHK_Edad check(edad > 18 and edad < 65);
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

--Agregar columna dFechaNacimiento 
alter table TEmpleado 
add dFechaNacimiento date; 
go 

--Crear nueva tabla llamada TSucursal
create table TSucursal(
nSucursalID int identity(1,1) constraint PK_nSucursalID primary key,
cNombreSucursal nvarchar(30) not null

);

