/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200514@Eden
	Task: Insert new rule of Rule_Credit [Redmine:#134156]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

DELETE FROM Rule_Credit WITH(ROWLOCK) WHERE ruleID = 306

INSERT INTO dbo.Rule_Credit (RuleID,RuleName)
VALUES (306,'Exceed max number of member stake level')

SELECT * FROM Rule_Credit WITH(NOLOCK) WHERE ruleID = 306