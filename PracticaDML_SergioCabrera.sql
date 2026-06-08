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

create table TProyecto(
nProyectoID int identity(1,1) constraint PK_nProyectoID primary key,
cNombreProyecto nvarchar(50) not null,
dFechaInicio date not null, 
dFechaFinal date null, 



);

create table TEmpleadoProyecto(
nEmpleadoProyectoID int identity(1,1) constraint PK_TEmpleadoProyecto primary key,
nEmpleadoID int constraint FK_Empleado_EmpleadoProyecto foreign key (nEmpleadoID) references TEmpleado(nEmpleadoID), 
nProyectoID int constraint FK_Proyecto_EmpleadoProyecto foreign key (nProyectoID) references TProyecto(nProyectoID)

);

