/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200205@Eden
	Task: add new pt 0.935 for SB [Redmine:#149918]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE p 
SET PTValue = PTValue + ',93.50'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 43
	  AND RuleID = 70
	  AND PTValue NOT LIKE '%,93.50'
GO
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70