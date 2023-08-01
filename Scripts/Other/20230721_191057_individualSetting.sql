/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: 20230717@Winfred
	Task: Deposit - Detect players who has redundant individual settings [Redmine:#191057]	
	DB: DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO

INSERT INTO Rule_Credit(RuleId,RuleName)
SELECT 345,'Bet limit setting of member exists in both Individual and group'


SELECT * FROM Rule_Credit WITH(NOLOCK) WHERE RuleId IN (345)