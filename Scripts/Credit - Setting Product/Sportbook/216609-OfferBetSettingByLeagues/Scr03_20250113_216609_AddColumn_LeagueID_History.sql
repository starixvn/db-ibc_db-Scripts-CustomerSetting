/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created by: 20250113@Tacy
	Task: Tables BetSetting_xxx_History - Add column [LeagueID] [Redmine:#216609] 
	DB:	DBCUST-CustDB_History
*/

--BetSetting_Agent_History
ALTER TABLE BetSetting_Agent_History ADD [LeagueID] [INT] NULL;
GO

ALTER TABLE [dbo].[BetSetting_Agent_History] ADD  CONSTRAINT [DF_BetSetting_Agent_History_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO

--BetSetting_Member_History
ALTER TABLE BetSetting_Member_History ADD [LeagueID] [INT] NULL;
GO

ALTER TABLE [dbo].[BetSetting_Member_History] ADD  CONSTRAINT [DF_BetSetting_Member_History_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO