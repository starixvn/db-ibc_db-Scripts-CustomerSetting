/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210416@Winfred
	Task:  Add new PT into Dep_PTconfig for credit licensee Saba789 [RedmineID:#153187]
		-  Add new PT into Dep_PTconfig for credit licensee 9w [RedmineID:#153633]
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

--> UpdateConfig for 165 Card Club (Arcadia Gaming) API : add more value 0.805
UPDATE p 
SET PTValue = PTValue + ',80.50'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 165
	  AND IsAthena = 0
	  AND PTValue NOT LIKE '%80.50%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 165
	  AND IsAthena = 0
	  
--> UpdateConfig for 200	Saba.club API : add more value 0.805
UPDATE p 
SET PTValue = PTValue + ',80.50'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 200
	  AND IsAthena = 0
	  AND PTValue NOT LIKE '%80.50%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 200
	  AND IsAthena = 0	  
	  
--> UpdateConfig for 220	Lottery and 180-186 & 190-199	VirtualSport 1&2 : add more value 0.805	  

UPDATE p 
SET PTValue = PTValue + ',80.50,50.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE (SportType  >= 180  AND SportType  <= 186) OR 
(SportType  >= 190  AND SportType  <= 199) OR SportType = 220
	   AND PTValue NOT LIKE '%80.50,50.00%'
	  
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE (SportType  >= 180  AND SportType  <= 186) OR 
(SportType  >= 190  AND SportType  <= 199) OR SportType = 220
	  --AND PTValue NOT LIKE '%80.50,50.00%'	  


--> UpdateConfig for 232	PG Soft API : add more value 0.805 , 0.5
UPDATE p 
SET PTValue = PTValue + ',93.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 232
	  AND IsAthena = 0
	  AND PTValue NOT LIKE '%93.00%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 232
	  AND IsAthena = 0	  