/*
	Created: 20181212@Elodie
	Task: Prepare structure for new credit site
	DB: DB06/bodb02, DBTP/bodb02
*/
USE master  
GO  

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustPTSetting_Agent_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustPTSetting_Agent_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustPTSetting_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustPTSetting_Agent_table;  
GO  

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustPTSetting_Member_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustPTSetting_Member_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustPTSetting_Member_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustPTSetting_Member_table;  
GO  

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustSettingMode_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustSettingMode_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustSettingMode_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustSettingMode_table;  
GO  

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustBetSetting_Agent_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustBetSetting_Agent_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustBetSetting_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustBetSetting_Agent_table;  
GO 

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustBetSetting_Member_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustBetSetting_Member_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustBetSetting_Member_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustBetSetting_Member_table;  
GO 

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustDiscount_Agent_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustDiscount_Agent_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustDiscount_Agent_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustDiscount_Agent_table;  
GO 

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustDiscount_Member_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustDiscount_Member_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustDiscount_Member_table_01.ndf',  
    SIZE = 64MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 64MB  
)
TO FILEGROUP CS_CustDiscount_Member_table;  
GO 

ALTER DATABASE bodb02 ADD FILEGROUP CS_CustGroupDiscount_Member_table;  
GO  
ALTER DATABASE bodb02 
ADD FILE   
(  
    NAME = CS_CustGroupDiscount_Member_table_01,  
    FILENAME = N'H:\IBC_DB\bodb02\CS_CustGroupDiscount_Member_table_01.ndf',  
    SIZE = 32MB,  
    MAXSIZE = UNLIMITED,  
    FILEGROWTH = 32MB  
)
TO FILEGROUP CS_CustGroupDiscount_Member_table;  
GO 