/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/01/03
	Task: Create new File Group for SportsBook table [Redmine:#193083]
	DB:	DBCUST-CustDB 
*/

USE [master]
GO

ALTER DATABASE CustDB ADD FILEGROUP [CustPTSetting_Agent_table];
GO
ALTER DATABASE CustDB
ADD FILE
(NAME = N'CustPTSetting_Agent_table_01' , FILENAME = N'/mnt/DiskG/CustDB/CustPTSetting_Agent_table_01.ndf' , SIZE = 32MB, MAXSIZE = UNLIMITED , FILEGROWTH = 32MB)
TO FILEGROUP [CustPTSetting_Agent_table];
GO


ALTER DATABASE CustDB ADD FILEGROUP [CustPTSetting_Member_table];
GO
ALTER DATABASE CustDB
ADD FILE
(NAME = N'CustPTSetting_Member_table_01' , FILENAME = N'/mnt/DiskG/CustDB/CustPTSetting_Member_table_01.ndf' , SIZE = 32MB, MAXSIZE = UNLIMITED , FILEGROWTH = 32MB)
TO FILEGROUP [CustPTSetting_Member_table];
GO


ALTER DATABASE CustDB ADD FILEGROUP [CustDiscountSetting_Agent_table];
GO
ALTER DATABASE CustDB
ADD FILE
(NAME = N'CustDiscountSetting_Agent_table_01' , FILENAME = N'/mnt/DiskG/CustDB/CustDiscountSetting_Agent_table_01.ndf' , SIZE = 32MB, MAXSIZE = UNLIMITED , FILEGROWTH = 32MB)
TO FILEGROUP [CustDiscountSetting_Agent_table];
GO


ALTER DATABASE CustDB ADD FILEGROUP [CustDiscountSetting_Member_table];
GO
ALTER DATABASE CustDB
ADD FILE
(NAME = N'CustDiscountSetting_Member_table_01' , FILENAME = N'/mnt/DiskG/CustDB/CustDiscountSetting_Member_table_01.ndf' ,SIZE = 32MB, MAXSIZE = UNLIMITED , FILEGROWTH = 32MB)
TO FILEGROUP [CustDiscountSetting_Member_table];  
GO