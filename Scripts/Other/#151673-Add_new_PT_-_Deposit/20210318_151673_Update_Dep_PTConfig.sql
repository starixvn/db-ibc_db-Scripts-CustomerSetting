/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210223@Winfred
	Task: add new pt 0.895 and 0.805 for SB [Redmine:#151673]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE a 
SET a.PTValue = a.PTValue + ',89.50,80.50'
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 43 AND a.RuleID = 70 AND a.PTValue NOT LIKE '%,89.50,80.50'

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70

GO	  
	  