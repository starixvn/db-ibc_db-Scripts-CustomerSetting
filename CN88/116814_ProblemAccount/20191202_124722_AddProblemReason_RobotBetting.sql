/*
	Created: 20191202@Elodie	
	Task: Add more problem account reason
	DB: DBCUST/CustDB
*/
USE CustDB
GO

EXEC DBA_CS_ProblemAccount_AddReason @SubIssueTypeId = 36, @ReasonName = 'Robot Betting'


SELECT *
FROM dbo.ProblemAccountReason WITH (NOLOCK)

SELECT *
FROM DBTXN.bodb02.dbo.TicketVoiding_SubIssueType WITH (NOLOCK)

