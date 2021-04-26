/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20210426@Eden
	Task: Update Sport_Bettype_Reference_Setting [#RM:153938]
	DB: DBTXN/bodb02
*/
USE bodb02
GO

UPDATE ps
SET ps.isActive = 1
FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK)
WHERE SportType = 171


