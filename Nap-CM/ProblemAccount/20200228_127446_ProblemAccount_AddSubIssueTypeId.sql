/*
	Created: 20200228@Elodie	
	Task: Prepare structure for problem account (Phase 2)
	DB: DBCUST/CustDB
*/
USE CustDB
GO

ALTER TABLE dbo.ProblemAccount ADD SubIssueTypeId TINYINT
ALTER TABLE dbo.ProblemAccountAction ADD SubIssueTypeId TINYINT

DROP TABLE dbo.ProblemAccountReasonAction

CREATE NONCLUSTERED INDEX IX_ProblemAccount_Action ON ProblemAccount (ActionId, SubIssueTypeId)
 
