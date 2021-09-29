/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: Eden@20210929
	Task: Insert new rules for credit [Redmine: #154048]   
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO
INSERT INTO Rule_Credit(RuleId,RuleName,ModifiedDate)
VALUES	(340,'max per ball < 0',GETDATE()),
	(341,'max payout per match < 0',GETDATE())

--SELECT * FROM CheckResultDB.dbo.Rule_Credit WITH(NOLOCK) WHERE RuleId IN( 340,341)