/*
	Created: 20181212@Elodie
	Task: Prepare structure for new credit site
	DB: DBCUST/CustDB
*/
USE master  
GO  

ALTER DATABASE CustDB ADD FILEGROUP CS_CustPTSetting_Agent_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustPTSetting_Agent_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustPTSetting_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustPTSetting_Agent_table;  
GO  

ALTER DATABASE CustDB ADD FILEGROUP CS_CustPTSetting_Member_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustPTSetting_Member_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustPTSetting_Member_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustPTSetting_Member_table;  
GO  

ALTER DATABASE CustDB ADD FILEGROUP CS_CustSettingMode_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustSettingMode_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustSettingMode_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustSettingMode_table;  
GO  

ALTER DATABASE CustDB ADD FILEGROUP CS_CustBetSetting_Agent_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustBetSetting_Agent_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustBetSetting_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustBetSetting_Agent_table;  
GO 

ALTER DATABASE CustDB ADD FILEGROUP CS_CustBetSetting_Member_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustBetSetting_Member_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustBetSetting_Member_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustBetSetting_Member_table;  
GO 

ALTER DATABASE CustDB ADD FILEGROUP CS_CustDiscount_Agent_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustDiscount_Agent_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustDiscount_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustDiscount_Agent_table;  
GO 

ALTER DATABASE CustDB ADD FILEGROUP CS_CustDiscount_Member_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustDiscount_Member_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustDiscount_Member_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustDiscount_Member_table;  
GO 

ALTER DATABASE CustDB ADD FILEGROUP CS_CustGroupDiscount_Member_table;  
GO  
ALTER DATABASE CustDB 
ADD FILE   
(  
    NAME = CS_CustGroupDiscount_Member_table_01,  
    FILENAME = N'H:\USER_DB\CustDB\CS_CustGroupDiscount_Member_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustGroupDiscount_Member_table;  
GO 