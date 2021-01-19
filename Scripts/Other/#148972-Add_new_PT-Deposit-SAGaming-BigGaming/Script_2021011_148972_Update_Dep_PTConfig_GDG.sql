/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210119@Winfred
	Task:  Insert Gold Diamond Gaming: 0.85 (ATHENA) , 0.92 (API) 
	[Redmine:#148972]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

--> Insert config for Gold Diamond Gaming (GDG) :  0.85 (Athena) and 0.92(API)
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,236,0,1,'85.00',1 UNION ALL
SELECT 71,236,0,0,'92.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 236
