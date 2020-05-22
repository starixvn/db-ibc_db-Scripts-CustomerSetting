/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200505@Eden
	Task: Insert table Dep_PTConfig for Saba.club, Sexy Gaming 
		  Update for Virtual Games, Table Game [Redmine:#134632]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> Insert config 
INSERT INTO [Dep_PTConfig] (RuleID,SportType,IsAthena,PTValue,IsActive)
--Saba.club
SELECT 71,200,1,'90.00',1 UNION ALL
SELECT 71,200,0,'90.00',1 UNION ALL
--Sexy Gaming
SELECT 71,243,1,'85.00',1 UNION ALL
SELECT 71,243,0,'92.00',1

--> UpdateConfig
UPDATE p 
SET PTValue = CASE  WHEN SportType = 245 AND IsAthena = 0 THEN '94.00,90.00,95.00' 
					WHEN SportType = 245 AND IsAthena = 1 THEN '90.00'
					WHEN SportType = 222 AND IsAthena = 0 THEN '94.00,90.00,95.00'
					WHEN SportType = 222 AND IsAthena = 1 THEN '85.00,90.00'
				ELSE PTValue END
FROM  [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType IN (245,222)
GO