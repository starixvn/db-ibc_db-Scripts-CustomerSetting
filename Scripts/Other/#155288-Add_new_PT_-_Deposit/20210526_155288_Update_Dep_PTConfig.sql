/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210526@Winfred
	Task: add new pt 0.88 for GDG, SA Gaming [Redmine:#155288]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

--> UpdateConfig for SA Gaming Athena : add more value 0.88
UPDATE p 
SET PTValue = PTValue + ',88.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 244
	  AND IsAthena = 1
	  AND PTValue NOT LIKE '%88.00%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 244
	  AND IsAthena = 1
	  --AND PTValue NOT LIKE '%88.00%'
	  
--> UpdateConfig for GDG Athena : add more value 0.88
UPDATE p 
SET PTValue = PTValue + ',88.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 236
	  AND IsAthena = 1
	  AND PTValue NOT LIKE '%88.00%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 236
	  AND IsAthena = 1
	  --AND PTValue NOT LIKE '%88.00%'	  
 