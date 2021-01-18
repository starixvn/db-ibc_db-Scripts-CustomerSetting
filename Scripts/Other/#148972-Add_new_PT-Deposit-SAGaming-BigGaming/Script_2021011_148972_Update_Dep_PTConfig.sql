/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210118@Eden
	Task:  - Update PT Config for SA Gaming : add more value : 0.91 (API)
		   - Insert Big Gaming : 0.88 (ATHENA), 0.92 (API)
		   - Insert WM: 0.88 (ATHENA) , 0.92 (API) 
	[Redmine:#146557]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> UpdateConfig for SA Gaming API : add more value 0.91
UPDATE p 
SET PTValue = PTValue + ',91.00'
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 244
	  AND IsAthena = 0
	  AND PTValue NOT LIKE '%91.00%'

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 244
	  AND IsAthena = 0
	  --AND PTValue NOT LIKE '%91.00%'

--> Insert config for Big Gaming :  0.88 (Athena) and 0.92(API)
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,239,0,1,'88.00',1 UNION ALL
SELECT 71,239,0,0,'92.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 239

--> Insert config for WM : 0.88 (Athena) and 0.92(API)
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,233,0,1,'88.00',1 UNION ALL
SELECT 71,233,0,0,'92.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 233