/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200526@Eden
	Task: Update for Sexy Gaming [Redmine:#134787]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig Sexy Gaming
UPDATE p 
SET PTValue = '88.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 243
	  AND RuleID = 71
	  AND IsAthena = 1
GO