/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20201217@Eden
	Task: update PT for HOT99 from 0.88 to 0.898 [Redmine:#147270]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE p 
SET PTValue = PTValue + ',89.80'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 43
	  AND RuleID = 70
	  AND PTValue NOT LIKE '%,89.80'
GO
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70