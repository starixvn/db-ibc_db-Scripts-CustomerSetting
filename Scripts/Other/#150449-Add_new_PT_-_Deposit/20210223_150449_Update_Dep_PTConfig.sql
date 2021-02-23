/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210223@Winfred
	Task: add new pt 0.892 for SB [Redmine:#150449]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE a 
SET a.PTValue = a.PTValue + ',89.20'
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 43 AND a.RuleID = 70 AND a.PTValue NOT LIKE '%,89.20'

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70

GO	  
	  