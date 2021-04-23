/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210223@Winfred
	Task: add pt for Sport lottery [Redmine:#153187]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for Sport lottery
UPDATE a 
SET a.PTValue = '90.00,94.00,95.00'
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 169 AND a.RuleID = 71 

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 169
	  AND RuleID = 71

GO	  
	  