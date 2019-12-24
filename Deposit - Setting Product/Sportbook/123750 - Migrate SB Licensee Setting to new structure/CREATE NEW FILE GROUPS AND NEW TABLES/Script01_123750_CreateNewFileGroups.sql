/*
	Created by: Eden
	Date: 20191212
	Task: Create New File group For SB - Deposit DCS tables [Redmine:#123750]	
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/
/*
USE CUSTDB
SELECT  *  FROM  sys.filegroups
SELECT * FROM sys.database_files --where name like '%DSB_CustBetSetting_table%'

USE master;  
GO  
ALTER DATABASE CustDB  
REMOVE FILE DSB_CustBetSetting_table_01 ;  
GO  

ALTER DATABASE CustDB  
REMOVE FILEGROUP DSB_CustBetSetting_table ;  
GO  

GO  
ALTER DATABASE CustDB  
REMOVE FILE DSB_CustDiscountSetting_table_01 ;  
GO  
  
GO  
ALTER DATABASE CustDB  
REMOVE FILEGROUP DSB_CustDiscountSetting_table ;  
GO 

GO  
ALTER DATABASE CustDB  
REMOVE FILE DSB_CustPTSetting_table_01 ;  
GO  
    
ALTER DATABASE CustDB  
REMOVE FILEGROUP DSB_CustPTSetting_table ;  
GO 
 
ALTER DATABASE CustDB  
REMOVE FILE DSB_CustSettingMode_table_01 ;  
GO  
    
ALTER DATABASE CustDB  
REMOVE FILEGROUP DSB_CustSettingMode_table ;  
GO 
*/

USE [master]
GO
ALTER DATABASE CustDB ADD FILEGROUP DSB_CustBetSetting_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = DSB_CustBetSetting_table_01,  
    FILENAME = N'D:\DB233\IBC_DB\CustDB\DSB_CustBetSetting_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 1MB  
)
TO FILEGROUP DSB_CustBetSetting_table;  
GO 

GO
ALTER DATABASE CustDB ADD FILEGROUP DSB_CustDiscountSetting_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = DSB_CustDiscountSetting_table_01,  
    FILENAME = N'D:\DB233\IBC_DB\CustDB\DSB_CustDiscountSetting_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 1MB  
)
TO FILEGROUP DSB_CustDiscountSetting_table;  
GO 

GO
ALTER DATABASE CustDB ADD FILEGROUP DSB_CustPTSetting_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = DSB_CustPTSetting_table_01,  
    FILENAME = N'D:\DB233\IBC_DB\CustDB\DSB_CustPTSetting_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 1MB  
)
TO FILEGROUP DSB_CustPTSetting_table;  
GO

ALTER DATABASE CustDB ADD FILEGROUP DSB_CustSettingMode_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = DSB_CustSettingMode_table_01,  
    FILENAME = N'D:\DB233\IBC_DB\CustDB\DSB_CustSettingMode_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 1MB  
)
TO FILEGROUP DSB_CustSettingMode_table;  
GO  