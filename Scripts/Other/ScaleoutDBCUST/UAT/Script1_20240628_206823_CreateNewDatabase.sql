/*<info serverAlias="DBCUST-master"></info>*/
/*
	Created: Eden@20240627
	Task: Create new DATABASE  GlobCustDB [Redmine: #206823]   
	DB: DBCUST-master
*/
--use master
--GO
--DROP DATABASE [GlobCustDB]
use master
GO
CREATE DATABASE [GlobCustDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GlobCustDB', FILENAME = N'/mnt/DiskG/GlobCustDB/GlobCustDB.mdf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
 FILEGROUP [custinfo_table] 
( NAME = N'custinfo_01', FILENAME = N'/mnt/DiskG/GlobCustDB/custinfo_01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'custinfo_02', FILENAME = N'/mnt/DiskG/GlobCustDB/custinfo_02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'custinfo_03', FILENAME = N'/mnt/DiskG/GlobCustDB/custinfo_03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
LOG ON 
( NAME = N'GlobCustDB_log', FILENAME = N'/mnt/DiskG/GlobCustDB/GlobCustDB_log.ldf' , SIZE = 4096MB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE GlobCustDB
GO
--grant permission for web accounts
CREATE USER [wsv_alp] FOR LOGIN [wsv_alp] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO wsv_alp
GO

CREATE USER [wsv_xnap] FOR LOGIN [wsv_xnap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO wsv_xnap
GO

CREATE USER [wsv_nap] FOR LOGIN [wsv_nap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO wsv_nap
GO

CREATE USER svc_tig FOR LOGIN svc_tig WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO svc_tig
GO

CREATE USER [asv_cust] FOR LOGIN [asv_cust] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO asv_cust
GO

CREATE USER [wsv_alpv] FOR LOGIN [wsv_alpv] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO wsv_alpv
GO

CREATE USER [wsv_lap] FOR LOGIN [wsv_lap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO [wsv_lap]
GO