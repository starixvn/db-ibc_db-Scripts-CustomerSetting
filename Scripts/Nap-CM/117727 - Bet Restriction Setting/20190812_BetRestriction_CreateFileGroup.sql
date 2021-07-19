/*
	Created by: Eden
	Date: 20190812
	Task: Create BetRestriction File group [Redmine:#117727]	
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/
USE [master]
GO
ALTER DATABASE CustDB ADD FILEGROUP BetRestriction;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = BetRestriction_01,  
    FILENAME = N'H:\USER_DB\CustDB\BetRestriction_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP BetRestriction;  
GO 

