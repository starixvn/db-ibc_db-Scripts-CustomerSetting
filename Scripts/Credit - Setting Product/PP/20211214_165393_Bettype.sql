/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Winfred
	Task : Create table bettype In DBCust [Redmine:#165393]
	DB:  DBCUST/bodb02 
	Replication : DB02_Cust_Events
*/
USE bodb02
GO

CREATE TABLE [dbo].[bettype](
	[typeid] [int] NOT NULL,
	[typenamee] [nvarchar](128) NULL,
	[typenamec] [nvarchar](128) NULL,
	[typedesc] [nvarchar](128) NULL,
	[creator] [int] NULL,
	[typenamec_uni] [nvarchar](128) NULL,
	[typenamej] [nvarchar](128) NULL,
	[typenamcn] [nvarchar](128) NULL,
	[typenamecn] [nvarchar](128) NULL,
	[typenameth] [nvarchar](128) NULL,
	[typenameit] [nvarchar](128) NULL,
	[typenameko] [nvarchar](128) NULL,
	[typenameES] [nvarchar](128) NULL,
	[typenameVN] [nvarchar](128) NULL,
	[typenameEL] [nvarchar](128) NULL,
	[typenamee_Eu] [nvarchar](128) NULL,
	[typenameRU] [nvarchar](128) NULL,
	[typenameID] [nvarchar](128) NULL,
	[typenamePT] [nvarchar](128) NULL,
	[typenameFR] [nvarchar](128) NULL,
	[ParentTypeid] [int] NULL,
	[typenameMMR] [nvarchar](128) NULL,
	[typenameHI] [nvarchar](128) NULL,
	[DisplayedTypeID] [int] NULL,
	[LicSpreadBetTypeGroupId] [tinyint] NOT NULL,
	[Is3rdParty] [bit] NOT NULL CONSTRAINT [DF_bettype_Is3rdParty]  DEFAULT ((0)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_bettype_RepUpdateTime]  DEFAULT (sysdatetime()),
 CONSTRAINT [PK_bettype] PRIMARY KEY CLUSTERED 
(
	[typeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO