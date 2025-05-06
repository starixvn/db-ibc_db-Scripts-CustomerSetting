/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  Create new DATABASE  AgencyCashService  [223896]  
	DB: DBCUST/AgencyCashService
*/

--*************************Customer Setting*************************
--use master
--GO
--DROP DATABASE [AgencyCashService]
use master
GO
CREATE DATABASE [AgencyCashService]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AgencyCashService', FILENAME = N'/var/opt/mssql/data/AgencyCashService.mdf' , SIZE = 508928KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [CashService] 
( NAME = N'AgencyCashService', FILENAME = N'/var/opt/mssql/data/CashService.ndf' , SIZE = 24576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AgencyCashService_log', FILENAME = N'/var/opt/mssql/data/AgencyCashService.ldf' , SIZE = 54976KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO