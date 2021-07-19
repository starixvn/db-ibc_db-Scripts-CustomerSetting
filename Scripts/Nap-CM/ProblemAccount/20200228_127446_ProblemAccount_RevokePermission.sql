/*
	Created: 20200305@Elodie	
	Task: Update data for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

REVOKE EXEC ON dbo.Age_ProblemAccount_ReviewStatusUpd TO bodbDownlineNetView
GO

REVOKE EXEC ON dbo.CS_ProblemAccount_ReviewStatusUpd TO bodbDownlineNetView
GO
