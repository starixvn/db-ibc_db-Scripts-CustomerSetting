/*
	Created: 20200210@Elodie	
	Task: Update data for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE ProblemAccountReason
SET IsCredit = 1,
	IsLicensee = 1,
	IsCN88 = 1

INSERT INTO dbo.ProblemAccountAction (ActionID, ActionName, IsActive)
SELECT 1, 'None', 1 UNION ALL
SELECT 2, 'Void Winning Tickets', 1 UNION ALL
SELECT 3, 'Void All Tickets', 1
