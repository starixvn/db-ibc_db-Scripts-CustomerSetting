/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Winfred
	Task : Create table LeagueGroup In DBCust [Redmine:#165393]
	DB:  DBCUST/bodb02 
	Replication : DB02_Cust_Events
*/
USE bodb02
GO

CREATE TABLE [dbo].[LeagueGroup](
	[GroupID] [smallint] IDENTITY(0,1) NOT FOR REPLICATION NOT NULL,
	[GroupName] [varchar](200) NOT NULL,
	[SportType] [smallint] NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_LeagueGroup_IsActive]  DEFAULT ((1)),
	[RepUpdateTime] [datetime2](7) NULL CONSTRAINT [DF_LeagueGroup_RepUpdateTime]  DEFAULT (sysdatetime()),
 CONSTRAINT [PK_LeagueGroup] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
