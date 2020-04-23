/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: DBCUST/bodb_Licensee AND all replicated of pub: Cusdb_bodb_Licensee
*/

USE [bodb_Licensee]
GO

--Add new table LicenseeCustComm_History
ALTER DATABASE bodb_Licensee  
ADD FILEGROUP LicenseeCustComm_History_table  
GO  

ALTER DATABASE bodb_Licensee   
ADD FILE   
(  
    NAME = LicenseeCustComm_History_table_01,  
    FILENAME = 'D:\DB233\IBC_DB\bodb_Licensee\LicenseeCustComm_History_table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
) TO FILEGROUP LicenseeCustComm_History_table
GO
CREATE TABLE [dbo].[LicenseeCustComm_History](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustID] [int] NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Comm] [decimal](9, 8) NULL,
 CONSTRAINT [PK_LicenseeCustComm_History_Id] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [LicenseeCustComm_History_table]
) ON [LicenseeCustComm_History_table]

GO
-- create index for arhive and reports
USE [bodb_Licensee]
GO
CREATE NONCLUSTERED INDEX IX_LicenseeCustComm_History_CustID_UpdatedTime ON LicenseeCustComm_History
(
	[CustID]
	,[UpdatedTime]
) INCLUDE ([ProductID],[Comm])
GO


