/*
	Date: 2020-01-21
	Created: Tiara
	Task: #125126 PHAIO 5: Remove unused bettype from Sport_Bettype_Reference_Setting table
	DB: DBTRANS/bodb02
*/
USE bodb02
GO

DELETE S
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK)
WHERE S.SportType = 1
	AND (S.BetType BETWEEN 373 AND 380
	OR S.BetType = 480)
