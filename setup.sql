USE master;
EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
go

ALTER DATABASE  CLRMemTest
SET TRUSTWORTHY ON
go

