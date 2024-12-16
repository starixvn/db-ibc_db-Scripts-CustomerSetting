/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20241017
	Task: 20241017@Winfred: LAP - Risk Level Bet Setting - Show league group info [redmine:#211952]
	DB: DBACC-bodb02
*/

--DROP INDEX league.IX_league_LeagueGroupID;

CREATE NONCLUSTERED INDEX [IX_league_LeagueGroupID] ON [dbo].[league]
(
	[LeagueGroupID],
	[IsActive],
	[isTest]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
