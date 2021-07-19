/*
	Date: 2020-01-17
	Created: Tiara
	Task: #125126 PHAIO 5: Enable VR Setting Reference of bettype 386,387,388,389,393,394,400
	DB: DBTRANS/bodb02
*/
USE bodb02
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_VirtualRate S WITH (ROWLOCK, UPDLOCK)
WHERE S.isActive = 0 
	AND S.SportType = 1
	AND S.BetType IN (386,387,388,389,393,394,400)

