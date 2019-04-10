/*
	Created: 20190409@Elodie
	Task: Prepare structure for new credit site
	DB: DBTP/bodb_CustHistory
*/
USE master  
GO  

ALTER DATABASE bodb_CustHistory ADD FILEGROUP CS_CustPTSetting_table;  
GO  
ALTER DATABASE bodb_CustHistory 
ADD FILE   
(  
    NAME = CS_CustPTSetting_table_01,  
    FILENAME = N'H:\IBC_DB\bodb_CustHistory\CS_CustPTSetting_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustPTSetting_table;  
GO  

ALTER DATABASE bodb_CustHistory ADD FILEGROUP CS_CustSettingMode_table;  
GO  
ALTER DATABASE bodb_CustHistory 
ADD FILE   
(  
    NAME = CS_CustSettingMode_table_01,  
    FILENAME = N'H:\IBC_DB\bodb_CustHistory\CS_CustSettingMode_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustSettingMode_table;  
GO  

ALTER DATABASE bodb_CustHistory ADD FILEGROUP CS_CustBetSetting_table;  
GO  
ALTER DATABASE bodb_CustHistory 
ADD FILE   
(  
    NAME = CS_CustBetSetting_table_01,  
    FILENAME = N'H:\IBC_DB\bodb_CustHistory\CS_CustBetSetting_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustBetSetting_table;  
GO  

ALTER DATABASE bodb_CustHistory ADD FILEGROUP CS_CustDiscount_table;  
GO  
ALTER DATABASE bodb_CustHistory 
ADD FILE   
(  
    NAME = CS_CustDiscount_table_01,  
    FILENAME = N'H:\IBC_DB\bodb_CustHistory\CS_CustDiscount_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustDiscount_table;  
GO 
