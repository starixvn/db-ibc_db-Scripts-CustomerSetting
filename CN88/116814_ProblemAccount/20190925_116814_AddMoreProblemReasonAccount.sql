/*
	Created: 20190925@Elodie	
	Task: Add more problem account reason
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE dbo.ProblemAccountReason 
SET ReasonID = 255
WHERE ReasonName = 'Others(M)'

UPDATE dbo.ProblemAccountReason 
SET ReasonID = ReasonID + 100
WHERE ReasonID < 27

EXEC DBA_CS_ProblemAccount_AddReason @ReasonName = 'AB Bet'

SELECT *
FROM dbo.ProblemAccountReason WITH (NOLOCK)

SELECT *
FROM DBTXN.bodb02.dbo.TicketVoiding_SubIssueType WITH (NOLOCK)