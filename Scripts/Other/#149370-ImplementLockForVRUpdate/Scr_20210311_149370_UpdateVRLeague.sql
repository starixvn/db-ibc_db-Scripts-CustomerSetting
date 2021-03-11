/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20210311@Eden
	Task: Update VRLeague disable use VR2 for testing league [RM#149370]
	DB: DBPRO-bodb02
*/
USE bodb02
GO

UPDATE v
SET IsApplied = 0
FROM VRLeague v WITH(ROWLOCK) 
	INNER JOIN League l WITH(NOLOCK) ON l.leagueid = v.LeagueId
WHERE IsApplied = 1
	AND l.leaguename LIKE 'Testing%'