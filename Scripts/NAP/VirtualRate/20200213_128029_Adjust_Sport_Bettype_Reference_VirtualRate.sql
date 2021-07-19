/*
	Date: 2020-02-13
	Created: Tiara
	Task: #128029: Adjust VR Setting Reference of bettype 184
	DB: DBTRANS/bodb02
*/

USE bodb02
GO

UPDATE S
SET S.BetTypeRefVirtualRate = 12, S.isActive =1
FROM Sport_Bettype_Reference_VirtualRate S WITH (ROWLOCK, UPDLOCK)
WHERE S.BetType IN (184,428,472) AND S.SportType= 1