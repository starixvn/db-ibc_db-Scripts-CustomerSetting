/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: DBLOG.bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO
--Add new table LicenseeCustComm_History
ALTER DATABASE bodb_CustomerLog_Archive  
ADD FILEGROUP LicenseeCustComm_History_bk_table  
GO  

ALTER DATABASE bodb_CustomerLog_Archive   
ADD FILE   
(  
    NAME = LicenseeCustComm_History_bk_table_01,  
    FILENAME = 'D:\DB233\IBC_DB\bodb_Licensee\LicenseeCustComm_History_bk_table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
) TO FILEGROUP LicenseeCustComm_History_bk_table
GO
CREATE TABLE [dbo].[LicenseeCustComm_History_bk](
	[Id] [bigint] NOT NULL,
	[CustID] [int] NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Comm] [decimal](9, 8) NULL
) ON LicenseeCustComm_History_bk_table

GO
CREATE NONCLUSTERED INDEX IX_LicenseeCustComm_History_bk_CustID_UpdatedTime ON LicenseeCustComm_History_bk
(
	[CustID]
	,[UpdatedTime]
) INCLUDE ([ProductID],[Comm])




