/*
    Created: Eden
    Date: 20200228
    Task: Update data for LeagueId = 7031 - BRAZIL CAMPEONATO CEARENSE -- rollback
	Redmine: #129279
    DB: BPRO/bodb02
*/ 
USE bodb02
GO
DELETE 
FROM VRLeague WITH(ROWLOCK)
WHERE LeagueId = 7031