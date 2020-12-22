/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200514@Eden
	Task: Insert new rule of Rule_Credit [Redmine:#134156]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

--DELETE FROM Rule_Credit WITH(ROWLOCK) WHERE ruleID = 329

INSERT INTO dbo.Rule_Credit (RuleID,RuleName)
VALUES (329,'Maxbet > Global Maxbet')

SELECT * FROM Rule_Credit WITH(NOLOCK) WHERE ruleID = 329