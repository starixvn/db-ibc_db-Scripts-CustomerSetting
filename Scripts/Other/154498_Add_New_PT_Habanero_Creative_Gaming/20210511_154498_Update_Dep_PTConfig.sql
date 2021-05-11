/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210416@Winfred
	Task:  Add new PT into Dep_PTconfig for credit licensee Saba789 [RedmineID:#153187]
		-  Add new PT into Dep_PTconfig for credit licensee 9w [RedmineID:#153633]
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

--> UpdateConfig 180-186 & 190-199	VirtualSport 1&2 : add more value  0.94	  
UPDATE p 
SET PTValue = PTValue + ',94.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE (SportType  >= 180  AND SportType  <= 186) OR 
	  (SportType  >= 190  AND SportType  <= 199) 
	   AND PTValue NOT LIKE '%94.00%'
	  
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE (SportType  >= 180  AND SportType  <= 186) OR 
	  (SportType  >= 190  AND SportType  <= 199)
	  --AND PTValue NOT LIKE '%94.00%'	  

--> UpdateConfig 169 Sports Lottery : add more value  0.805 - 0.5  
UPDATE p 
SET PTValue = PTValue + ',80.50,50.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType= 169  AND PTValue NOT LIKE '%80.50,50.00%'
	  
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType= 169 --AND PTValue NOT LIKE '%80.50,50.00%'

--> UpdateConfig 161 Number Game : add more value  0.94	  
UPDATE p 
SET PTValue = PTValue + ',94.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType= 161  AND PTValue NOT LIKE '%94.00%'
	  
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType= 161  --AND PTValue NOT LIKE '%94.00%'

--> UpdateConfig 202 Keno AND 220 Lottery : add more value  0.97	  
UPDATE p 
SET PTValue = PTValue + ',97.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE (SportType= 202 OR SportType= 220) AND PTValue NOT LIKE '%97.00%'
	  
SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE (SportType= 202 OR SportType= 220) --AND PTValue NOT LIKE '%97.00%':

--> Insert config for 238 Habanero :  0.9 (Athena) and 0.92(API)
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,238,0,1,'90.00',1 UNION ALL
SELECT 71,238,0,0,'92.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 238

--> Insert config for 167 Creative Gaming :  0.9 (Athena) and 0.92(API)
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,167,0,1,'90.00',1 UNION ALL
SELECT 71,167,0,0,'92.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 167