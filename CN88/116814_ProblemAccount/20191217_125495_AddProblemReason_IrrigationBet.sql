/*
	Created: 20191217@Elodie	
	Task: Add more problem account reason
	DB: DBCUST/CustDB
*/
USE CustDB
GO

EXEC DBA_CS_ProblemAccount_AddReason @SubIssueTypeId = 37, @ReasonName = 'Irrigation Bet', @ReasonNameCS = N'灌水投注'


SELECT *
FROM dbo.ProblemAccountReason WITH (NOLOCK)

SELECT *
FROM DBTXN.bodb02.dbo.TicketVoiding_SubIssueType WITH (NOLOCK)

SELECT *
FROM DBTXN.bodb02.dbo.TicketVoiding_ReasonTemplate  WITH (NOLOCK)

/*

DELETE FROM ProblemAccountReason WITH (ROWLOCK) WHERE ReasonID IN (37,108)

DELETE FROM DBTXN.bodb02.dbo.TicketVoiding_SubIssueType WITH (ROWLOCK) WHERE SubIssueTypeId = 37

DELETE FROM DBTXN.bodb02.dbo.TicketVoiding_ReasonTemplate WITH (ROWLOCK) WHERE SubIssueTypeId = 37

*/