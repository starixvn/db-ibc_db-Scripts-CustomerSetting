/*
	Created: 20191202@Elodie	
	Task: Add more problem account reason
	DB: DBCUST/CustDB
*/
USE CustDB
GO

EXEC DBA_CS_ProblemAccount_AddReason @ReasonName = 'Robot Betting'
