/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
    Created: Eden@20200731
    Task: Update set IsApplied = 0 for leaugeID = 7031, league name BRAZIL CAMPEONATO CEARENSE from the table dbo.VRLeague
    DB: BPRO/bodb02
*/ 
USE bodb02
GO
DELETE dbo.VRLeague WITH(ROWLOCK,UPDLOCK)
WHERE LeagueId = 7031
