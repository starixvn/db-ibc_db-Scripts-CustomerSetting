/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-09-26
	Task: Copying data CustDB.CustSubMini ==> GlobCustDB.CustSubMini [Redmine: #206823]  
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustSubMini](
	[subaccid] [int] IDENTITY(1,1) NOT NULL,
	[CustID] [int] NOT NULL,
	[username] [varchar](30) NOT NULL,
	[username2] [varchar](50) NULL,
	[SiteDBGroupID]	[smallint] NULL,
	[RepUpdateTime] [datetime2] NULL,
) ON [CustInfo_table]

GO

SELECT *
INTO [CustSubMini_migrate] on [CustInfo_table]
FROM CustDB.[dbo].[CustSubMini] WITH (NOLOCK)

-- Check data After SWITCH DATA TABLE
SELECT COUNT(1) AS Count_TmpTable_After_SwitchData  FROM [CustSubMini_migrate] WITH (NOLOCK)
SELECT COUNT(1) AS Count_MainTable_After_SwitchData  FROM [CustSubMini] WITH (NOLOCK)

--SWITCH TABLE
ALTER TABLE [CustSubMini_migrate] SWITCH TO [CustSubMini];

-- Check data Before SWITCH DATA TABLE
SELECT COUNT(1) AS Count_TmpTable_Before_SwitchData FROM [CustSubMini_migrate] WITH (NOLOCK)
SELECT COUNT(1) AS Count_MainTable_Before_SwitchData FROM [CustSubMini] WITH (NOLOCK)
GO

--ADD INDEX
ALTER TABLE [dbo].[CustSubMini] ADD  CONSTRAINT [PK_CustSubMini] PRIMARY KEY CLUSTERED 
(
	[subaccid] ASC
)WITH(MAXDOP=24) ON [custinfo_table]
GO
ALTER TABLE [dbo].[CustSubMini] ADD  CONSTRAINT [UQ_CustSubMini_username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH(MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustID] ON [dbo].[CustSubMini]
(
	[custid] ASC
)WITH(MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustSubMini_Username2] ON [dbo].[CustSubMini]
(
	[username2] ASC
)WITH(MAXDOP=24) ON [custinfo_table]
GO
CREATE NONCLUSTERED INDEX [IX_CustSubMini_RepUpdateTime] ON [dbo].[CustSubMini]
(
	[RepUpdateTime] ASC
)WITH(MAXDOP=24) ON [custinfo_table]
GO

--ADD CONSTRAINT
ALTER TABLE [dbo].[CustSubMini] ADD  CONSTRAINT [DF_CustSubMini_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[CustSubMini] ADD  CONSTRAINT [DF_CustSubMini_SiteDBGroupID]  DEFAULT ((0)) FOR [SiteDBGroupID]
GO

-- CHECK IDENT
DBCC CHECKIDENT ('dbo.CustSubMini');
GO
