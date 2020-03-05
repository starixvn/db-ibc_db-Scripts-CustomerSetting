/*
	Created: 20200210@Elodie	
	Task: Update data for problem account 
	DB: DBTXN/bodb02
*/
USE CustDB
GO

REVOKE EXEC ON dbo.Age_ProblemAccount_ReviewStatusUpd TO bodbDownlineNetView
GO

REVOKE EXEC ON dbo.CS_ProblemAccount_ReviewStatusUpd TO bodbDownlineNetView
GO
