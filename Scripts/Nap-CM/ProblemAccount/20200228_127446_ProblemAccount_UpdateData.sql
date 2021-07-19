/*
	Created: 20200210@Elodie	
	Task: Update data for problem account 
	DB: DBTXN/bodb02
*/
USE bodb02
GO

UPDATE TicketVoiding_SubIssueType
SET SubIssueTypeNameCS = N'系统计算投注'
WHERE SubIssueTypeId IN (38)
