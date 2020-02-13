/*
	Date: 2020-02-07
	Created: Tiara
	Task: #128029: Adjust VR Setting Reference of bettype 184
	DB: DBTRANS/bodb02
*/

USE bodb02
GO

UPDATE S
SET S.BetTypeRefVirtualRate = 12
FROM Sport_Bettype_Reference_VirtualRate S WITH (ROWLOCK, UPDLOCK)
WHERE (S.BetType = 184 OR S.BetType = 428) AND S.SportType= 1


