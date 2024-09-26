/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-09-26
	Task: Copying data CustDB.CustInfoMini ==> GlobCustDB.CustInfoMini [Redmine: #206823]  
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE TABLE
CREATE TABLE [dbo].[CustInfoMini](
	[CustID] [int] NOT NULL IDENTITY(1,1),
	[username] [varchar](30) NOT NULL,
	[username2] [varchar](50) NULL,
	[recommend] [int] NULL,
	[mrecommend] [int] NULL,
	[srecommend] [int] NULL,
	[roleid] [tinyint] NULL,
	[SiteDBGroupID]	[smallint] NULL ,
	[RepUpdateTime] [datetime2] NULL,
	[Site] [VARCHAR](10) NULL,	
	[Currency] [int] NULL,	
) ON [CustInfo_table]


SELECT *
INTO [CustInfoMini_migrate] on [CustInfo_table]
FROM CustDB.[dbo].[CustInfoMini] WITH (NOLOCK)

-- Check data After SWITCH DATA TABLE
SELECT COUNT(1) AS Count_TmpTable_After_SwitchData  FROM [CustInfoMini_migrate] WITH (NOLOCK)
SELECT COUNT(1) AS Count_MainTable_After_SwitchData  FROM [CustInfoMini] WITH (NOLOCK)

--SWITCH TABLE
ALTER TABLE [CustInfoMini_migrate] SWITCH TO [CustInfoMini];

-- Check data Before SWITCH DATA TABLE
SELECT COUNT(1) AS Count_TmpTable_Before_SwitchData FROM [CustInfoMini_migrate] WITH (NOLOCK)
SELECT COUNT(1) AS Count_MainTable_Before_SwitchData FROM [CustInfoMini] WITH (NOLOCK)
GO

--ADD INDEX
ALTER TABLE [dbo].[CustInfoMini] ADD  CONSTRAINT [PK_CustInfoMini] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (MAXDOP=24) ON [custinfo_table]
GO
ALTER TABLE [dbo].[CustInfoMini] ADD  CONSTRAINT [UQ_CustInfoMini_username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustInfoMini_Username2] ON [dbo].[CustInfoMini]
(
	[username2] ASC
)WITH (MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustInfoMini_RepUpdateTime] ON [dbo].[CustInfoMini]
(
	[RepUpdateTime] ASC
)WITH (MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustInfoMini_Recommend] ON [dbo].[CustInfoMini]
(
	[recommend] ASC
)
INCLUDE([username]) WITH (MAXDOP=24) ON [custinfo_table]
GO

--ADD CONSTRAINT
ALTER TABLE [dbo].[CustInfoMini] ADD  CONSTRAINT [DF_CustInfoMini_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[CustInfoMini] ADD  CONSTRAINT [DF_CustInfoMini_SiteDBGroupID]  DEFAULT ((0)) FOR [SiteDBGroupID]
GO

