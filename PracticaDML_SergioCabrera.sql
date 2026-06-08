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

