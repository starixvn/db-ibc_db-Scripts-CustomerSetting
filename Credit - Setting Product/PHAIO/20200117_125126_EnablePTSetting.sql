/*
	Date: 2020-01-17
	Created: Tiara
	Task: #125126 PHAIO 5: Enable PT Setting Reference of bettype from 381 to 400
	DB: DBTRANS/bodb02
*/
USE bodb02
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.isActive = 0 
	AND S.SportType = 1
	AND S.BetType BETWEEN 381 AND 400