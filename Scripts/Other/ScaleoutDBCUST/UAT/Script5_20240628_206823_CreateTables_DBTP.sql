/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20240628
	Task: Create new tables to store all customers under system [Redmine: #206823]  
	DB: DBTP-bodb02
*/
/*
DROP TABLE [CustInfoMini]
DROP TABLE [CustSubMini]
*/
USE bodb02
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
	[SiteID] [int] NULL,	
	[Currency] [int] NULL,	
	[SiteDBGroupID]	[smallint] NULL CONSTRAINT DF_CustInfoMini_SiteDBGroupID DEFAULT 0,
	[RepUpdateTime] [datetime2] NULL CONSTRAINT DF_CustInfoMini_RepUpdateTime DEFAULT SYSDATETIME(),
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