/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200728@Eden
	Task: Insert table Dep_PTConfig for PPJackpot	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> Update config for PP 
UPDATE p
SET BetType = 4101
FROM [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 248 AND BetType IS NULL

--> Insert config 
INSERT INTO [Dep_PTConfig] (RuleID,SportType,IsAthena,PTValue,IsActive)
--PPJackpot
SELECT 71,248,1,'100.00',1 UNION ALL
SELECT 71,248,0,'100.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 248