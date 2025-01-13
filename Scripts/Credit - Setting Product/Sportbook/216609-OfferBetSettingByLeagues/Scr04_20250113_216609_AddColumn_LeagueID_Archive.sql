/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created by: 20250113@Tacy
	Task: Tables BetSetting_xxx_old - Add column [LeagueID] [Redmine:#216609] 
	DB:	DBCUST-CustDB_old
*/

--BetSetting_Agent_old
ALTER TABLE BetSetting_Agent_old ADD [LeagueID] [INT] NULL;
GO

ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO

--BetSetting_Member_old
ALTER TABLE BetSetting_Member_old ADD [LeagueID] [INT] NULL;
GO

ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO