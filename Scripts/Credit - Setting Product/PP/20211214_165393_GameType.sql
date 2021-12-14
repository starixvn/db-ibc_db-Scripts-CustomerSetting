/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Winfred
	Task : Create table GameType In DBCust [Redmine:#165393]
	DB:  DBCUST/CustDB 
	Replication : 
*/
USE CustDB
GO

CREATE TABLE [dbo].[GameType](
	[GameTypeID] [int] NOT NULL,
	[GameTypeName] [nvarchar](50) NULL,
	[IsDisabled] [bit] NULL CONSTRAINT [DF_GameType_IsDisabled]  DEFAULT ((0)),
	[IBCBetTypeID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_GameType_RepUpdateTime]  DEFAULT (sysdatetime()),
 CONSTRAINT [PK_GameType] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO