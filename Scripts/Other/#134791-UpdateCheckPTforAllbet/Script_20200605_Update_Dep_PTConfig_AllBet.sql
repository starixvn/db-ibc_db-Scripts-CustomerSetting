/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200605@Eden
	Task: Update for Allbet [Redmine:#134791]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig AllBet
UPDATE p 
SET PTValue = '88.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType IN (211) 
	  AND RuleID = 71
	  AND IsAthena = 1
GO