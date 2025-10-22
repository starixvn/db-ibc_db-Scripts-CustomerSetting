/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251020@Johnson
	Task: Enhancement - TO Monitor Control By League [Redmine:#236824]	
	DB: DBCUST/CustDB
*/

CREATE TABLE [dbo].[TOControl_LeagueGroupSetting](
	SettingID int IDENTITY(1,1) NOT NULL ,
	LeagueGroupID [int] NOT NULL,
	Market tinyint NOT NULL,	
	[Sporttype] [smallint] NOT NULL,
	[ProfileID] [smallint] NOT NULL,	
	[MaxTurnOver] [money] NOT NULL,	
 CONSTRAINT [PK_TOControl_LeagueGroupSetting] PRIMARY KEY CLUSTERED 
(
	SettingID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_TOControl_LeagueGroupSetting_LeagueGroupID] ON [dbo].[TOControl_LeagueGroupSetting]
(
	[LeagueGroupID] ASC,
	Market ASC,
	[Sporttype] ASC,
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
