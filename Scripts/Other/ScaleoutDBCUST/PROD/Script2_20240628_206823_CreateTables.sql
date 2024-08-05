/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Eden@20240628
	Task: Create new tables to store all customers under system [Redmine: #206823]  
	DB: DBGLOB-GlobCustDB
*/
/*
DROP TABLE [CustInfoMini]
DROP TABLE [CustSubMini]
DROP TABLE [CustInfoMini_Del_Inhouse]
DROP TABLE [CustSubMini_Del_Inhouse]
*/
USE CustDB
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustInfoMini](
	[CustID] [int] NOT NULL,
	[username] [varchar](30) NOT NULL CONSTRAINT UQ_CustInfoMini_username UNIQUE,
	[username2] [varchar](50) NULL,
	[recommend] [int] NULL,
	[mrecommend] [int] NULL,
	[srecommend] [int] NULL,
	[roleid] [tinyint] NULL,
	[SiteDBGroupID]	[smallint] NULL CONSTRAINT DF_CustInfoMini_SiteDBGroupID DEFAULT 0,
	[RepUpdateTime] [datetime2] NULL CONSTRAINT DF_CustInfoMini_RepUpdateTime DEFAULT SYSDATETIME(),
	[Site] [VARCHAR](10) NULL,	
	[Currency] [int] NULL,	
 CONSTRAINT [PK_CustInfoMini] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [custinfo_table]
) ON [custinfo_table]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustSubMini](
	[subaccid] [int] NOT NULL,
	[CustID] [int] NOT NULL CONSTRAINT UQ_CustSubMini_username UNIQUE(username),
	[username] [varchar](30) NOT NULL,
	[username2] [varchar](50) NULL,
	[SiteDBGroupID]	[smallint] NULL CONSTRAINT DF_CustSubMini_SiteDBGroupID DEFAULT 0,
	[RepUpdateTime] [datetime2] NULL CONSTRAINT DF_CustSubMini_RepUpdateTime DEFAULT SYSDATETIME(),
 CONSTRAINT [PK_CustSubMini] PRIMARY KEY CLUSTERED 
(
	[subaccid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [custinfo_table]
) ON [custinfo_table]

GO

CREATE NONCLUSTERED INDEX IX_CustInfoMini_Username2 ON CustInfoMini(Username2 ASC) ON [custinfo_table]
CREATE NONCLUSTERED INDEX IX_CustInfoMini_Recommend ON CustInfoMini(Recommend ASC) INCLUDE (Username) ON [custinfo_table]
CREATE NONCLUSTERED INDEX IX_CustSubMini_Username2 ON CustSubMini(Username2 ASC) ON [custinfo_table]
GO
----------Deleted Table - CustDB Only----------
CREATE TABLE [dbo].CustInfoMini_Del_Inhouse(
	[CustID] [int] NOT NULL,
	[RepUpdateTime] [datetime2] NULL,
)  ON [custinfo_table]

CREATE TABLE [dbo].CustSubMini_Del_Inhouse(
	[subaccid] [int] NOT NULL,
	[RepUpdateTime] [datetime2] NULL,
)  ON [custinfo_table]

--Create indexes:
CREATE NONCLUSTERED INDEX IX_CustInfoMini_RepUpdateTime ON CustInfoMini(RepUpdateTime ASC) ON [custinfo_table]
CREATE NONCLUSTERED INDEX IX_CustSubMini_RepUpdateTime ON CustSubMini(RepUpdateTime ASC)  ON [custinfo_table]
CREATE CLUSTERED INDEX IX_CustInfoMini_Del_Inhouse ON CustInfoMini_Del_Inhouse(RepUpdateTime ASC)  ON [custinfo_table]
CREATE CLUSTERED INDEX IX_CustSubMini_Del_Inhouse ON CustSubMini_Del_Inhouse(RepUpdateTime ASC)  ON [custinfo_table]
GO
