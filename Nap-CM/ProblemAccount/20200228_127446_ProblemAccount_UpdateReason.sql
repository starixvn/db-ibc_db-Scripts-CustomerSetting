/*
	Created: 20200210@Elodie	
	Task: Update data for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE ProblemAccountReason
SET IsCN88 = 0
WHERE ReasonID IN (38,109)
