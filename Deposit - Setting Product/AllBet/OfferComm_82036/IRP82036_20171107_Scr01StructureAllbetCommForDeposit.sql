/*
	Created: Johnson
	Date: 20171107
	Task: deploy structure when offer AB comm for licensees
	DB:
*/

--STEP 1:
--deploy @DBLIC/bodb_Licensee
USE bodb_licensee
GO
ALTER TABLE dbo.LicenseeCustComm ADD AllbetComm DECIMAL(9,8) 

ALTER TABLE dbo.LicenseeGroupComm ADD AllbetComm DECIMAL(9,8) 
GO

---------------------------------------------------------------------
--STEP 2: 
--deploy on DBCUST/CustDB then setup replication to DB06/DBTP 
--for 2 tables Dep_CustDiscountSetting_Member & Dep_CustDiscountGroupSetting_Member
ALTER DATABASE CUSTDB  
ADD FILEGROUP Dep_CustDiscount_Member_Table;  
GO  
ALTER DATABASE CUSTDB   
ADD FILE   
(  
    NAME = Dep_CustDiscount_Member_Table_01,  
    FILENAME = 'E:\SQLSERVER2008R2\IBC_DB\CustDB\Dep_CustDiscount_Member_Table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
) TO FILEGROUP Dep_CustDiscount_Member_Table
GO

USE [CustDB]
GO

CREATE TABLE [dbo].Dep_CustDiscountSetting_Member(
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
 CONSTRAINT PK_Dep_CustDiscountSetting_Member PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON Dep_CustDiscount_Member_Table
) ON Dep_CustDiscount_Member_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_PlayerDiscount]  DEFAULT ((0)) FOR [PlayerDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_AgentDiscount]  DEFAULT ((0)) FOR [AgentDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_MasterDiscount]  DEFAULT ((0)) FOR [MasterDiscount]
GO
ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_SuperDiscount]  DEFAULT ((0)) FOR [SuperDiscount]
GO

-------------------------------------
USE [CustDB]
GO

CREATE TABLE [dbo].Dep_CustDiscountGroupSetting_Member(
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
 CONSTRAINT PK_Dep_CustDiscountGroupSetting_Member PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON Dep_CustDiscount_Member_Table
) ON Dep_CustDiscount_Member_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_PlayerDiscount]  DEFAULT ((0)) FOR [PlayerDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_AgentDiscount]  DEFAULT ((0)) FOR [AgentDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_MasterDiscount]  DEFAULT ((0)) FOR [MasterDiscount]
GO
ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_SuperDiscount]  DEFAULT ((0)) FOR [SuperDiscount]


---------------------------------------------------------------
--STEP 3:
--deploy on DBACC/bodb02
ALTER DATABASE bodb02  
ADD FILEGROUP Dep_CustDiscount_Member_Table;  
GO  
ALTER DATABASE bodb02   
ADD FILE   
(  
    NAME = Dep_CustDiscount_Member_Table_01,  
    FILENAME = 'D:\DB234_SQLSERVER2008R2\IBC_DB\bodb02\Dep_CustDiscount_Member_Table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
)TO FILEGROUP Dep_CustDiscount_Member_Table
GO

USE bodb02
GO

CREATE TABLE [dbo].Dep_CustDiscountSetting_Member(
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
 CONSTRAINT PK_Dep_CustDiscountSetting_Member PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON Dep_CustDiscount_Member_Table
) ON Dep_CustDiscount_Member_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_PlayerDiscount]  DEFAULT ((0)) FOR [PlayerDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_AgentDiscount]  DEFAULT ((0)) FOR [AgentDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_MasterDiscount]  DEFAULT ((0)) FOR [MasterDiscount]
GO
ALTER TABLE [dbo].Dep_CustDiscountSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_SuperDiscount]  DEFAULT ((0)) FOR [SuperDiscount]
GO

-------------------------------------


CREATE TABLE [dbo].Dep_CustDiscountGroupSetting_Member(
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
 CONSTRAINT PK_Dep_CustDiscountGroupSetting_Member PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[SportType] ASC,
	[BetType] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON Dep_CustDiscount_Member_Table
) ON Dep_CustDiscount_Member_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_PlayerDiscount]  DEFAULT ((0)) FOR [PlayerDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_AgentDiscount]  DEFAULT ((0)) FOR [AgentDiscount]
GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_MasterDiscount]  DEFAULT ((0)) FOR [MasterDiscount]
GO
ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_SuperDiscount]  DEFAULT ((0)) FOR [SuperDiscount]

-----------------------------------------------------------------------------
--STEP 4:
--Deploy DBTP.bodb_CustHistory for history tables

USE bodb_CustHistory
GO
ALTER DATABASE bodb_CustHistory  
ADD FILEGROUP Dep_CustDiscount_Member_Table;  
GO  
ALTER DATABASE bodb_CustHistory   
ADD FILE   
(  
    NAME = Dep_CustDiscount_Member_Table_01,  
    FILENAME = 'D:\DB234_SQLSERVER2008R2\IBC_DB\bodb_history\Dep_CustDiscount_Member_Table_01.ndf',  
    SIZE = 10MB,    
    FILEGROWTH = 10MB  
)TO FILEGROUP Dep_CustDiscount_Member_Table
GO


CREATE TABLE [dbo].Dep_CustDiscountSetting_Member_History(
	[UpdateTime] DATETIME NOT  NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
) ON Dep_CustDiscount_Member_Table
GO

ALTER TABLE [dbo].Dep_CustDiscountSetting_Member_History ADD  CONSTRAINT [DF_Dep_CustDiscountSetting_Member_History_UpdateTime]  DEFAULT (GETDATE()) FOR [UpdateTime]
GO

CREATE CLUSTERED INDEX [Dep_CustDiscountSetting_Member_His_Index] ON [dbo].[Dep_CustDiscountSetting_Member_History] 
(
	[UpdateTime] DESC,
	[custid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [Dep_CustDiscount_Member_Table]
GO

-------------------------------------


CREATE TABLE [dbo].Dep_CustDiscountGroupSetting_Member_History(
	[UpdateTime] DATETIME NOT NULL,
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NULL,
	[BetType] [smallint] NULL,	
	[PlayerDiscount] decimal(9,8) NULL,
	AgentDiscount decimal(9,8) NULL,
	MasterDiscount decimal(9,8) NULL,
	SuperDiscount decimal(9,8) NULL,
 ) ON Dep_CustDiscount_Member_Table

GO

ALTER TABLE [dbo].Dep_CustDiscountGroupSetting_Member_History ADD  CONSTRAINT [DF_Dep_CustDiscountGroupSetting_Member_History]  DEFAULT (GETDATE()) FOR [UpdateTime]
GO


CREATE CLUSTERED INDEX [Dep_CustDiscountGroupSetting_Member_His_Index] ON [dbo].[Dep_CustDiscountGroupSetting_Member_History] 
(
	[UpdateTime] DESC,
	[AgentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [Dep_CustDiscount_Member_Table]
GO

