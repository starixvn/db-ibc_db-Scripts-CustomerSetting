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