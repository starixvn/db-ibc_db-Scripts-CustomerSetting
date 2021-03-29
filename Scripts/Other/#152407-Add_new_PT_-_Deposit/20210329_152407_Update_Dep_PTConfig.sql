/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210329@Winfred
	Task: add new pt 0.915 - 0.92 - 0.95 for SB [Redmine:#152407]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Esport
UPDATE a 
SET a.PTValue = a.PTValue + ',91.50,92.00,95.00'
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 43 AND a.RuleID = 70 AND a.PTValue NOT LIKE '%,91.50,92.00,95.00'

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 43
	  AND RuleID = 70

GO	  
 