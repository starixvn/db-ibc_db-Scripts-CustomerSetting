/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Winfred
	Task : Create table Sports In DBCust [Redmine:#165393]
	DB:  DBCUST/bodb02 
	Replication : DB02_Cust_Events
*/
USE bodb02
GO

CREATE TABLE [dbo].[Sports](
	[SportType] [tinyint] NOT NULL,
	[SportName] [nvarchar](50) NULL,
	[SportNameCh] [nvarchar](50) NULL,
	[SportNameCs] [nvarchar](50) NULL,
	[SportNameJp] [nvarchar](50) NULL,
	[SportNameIt] [nvarchar](50) NULL,
	[SportNameTh] [nvarchar](50) NULL,
	[ParlayMaxPayout] [int] NULL,
	[SportNameKo] [nvarchar](50) NULL,
	[SportNameES] [nvarchar](50) NULL,
	[SportNameVN] [nvarchar](50) NULL,
	[SportNameEL] [nvarchar](50) NULL,
	[SportNameRU] [nvarchar](50) NULL,
	[SportNameID] [nvarchar](50) NULL,
	[SportNamePT] [nvarchar](50) NULL,
	[SportNameFR] [nvarchar](50) NULL,
	[SportNameMMR] [nvarchar](50) NULL,
	[SportNamePL] [nvarchar](50) NULL,
	[SportNameHI] [nvarchar](50) NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_Sports_RepUpdateTime]  DEFAULT (sysdatetime()),
 CONSTRAINT [PK_Sports_1] PRIMARY KEY NONCLUSTERED 
(
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO