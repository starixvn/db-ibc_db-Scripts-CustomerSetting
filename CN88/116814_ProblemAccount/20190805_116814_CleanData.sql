/*
	Created: 20190805@Elodie	
	Task: Clean data for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE dbo.CS_ProblemAccount WITH (ROWLOCK)
