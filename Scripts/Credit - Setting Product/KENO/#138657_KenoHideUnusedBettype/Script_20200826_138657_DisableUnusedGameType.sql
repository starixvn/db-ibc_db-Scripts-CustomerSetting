/*<info serverAlias="DBPRO-bodb02"></info>*/
 /*
	Created: 20200825@Eden
	Task: Disable un-used GameType (country) of Keno [Redmine:#138657]		
	DB: DBPRO/bodb02
*/
USE bodb02
GO

UPDATE g
SET IsDisabled = 1
FROM dbo.GameType g WITH (ROWLOCK) 
WHERE GameTypeiD in (3,4,5,8,11,13,14)
	AND IsDisabled = 0