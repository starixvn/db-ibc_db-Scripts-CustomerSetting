/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20201203@Eden
	Task: Update  PT for Winbox from 0.88 to 0.9065 [Redmine:#146557]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE p 
SET PTValue = PTValue + ',90.65'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 43
	  AND RuleID = 70
GO
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70