/*
	Created: 20200210@Elodie	
	Task: Update data for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

EXEC DBA_CS_ProblemAccount_AddReason @SubIssueTypeId = 38, @ReasonName = 'System Formula Bet', @ReasonNameCS = N'灌水投注'

UPDATE ProblemAccountReason
SET IsCredit = 1,
	IsLicensee = 1,
	IsCN88 = 1

DELETE dbo.ProblemAccountAction

INSERT INTO dbo.ProblemAccountAction (ActionID, ActionName, IsActive)
SELECT 1, 'None', 1 UNION ALL
SELECT 2, 'Void Winning Tickets', 1 --UNION ALL
--SELECT 3, 'Void All Tickets', 1

INSERT INTO ProblemAccountReasonAction (ReasonId, ActionId)
SELECT ReasonId, CASE WHEN ReasonID = 109 THEN 2 ELSE 1 END
FROM ProblemAccountReason WITH (NOLOCK)