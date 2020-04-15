/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: DBCUST/bodb_Licensee AND all replicated of pub: Cusdb_bodb_Licensee
*/
USE [bodb_Licensee]
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
