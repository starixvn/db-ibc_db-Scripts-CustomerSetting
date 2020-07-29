/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20200728@Eden
	Task: Insert table Dep_PTConfig for PPJackpot	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> Change column Bettype to NOT NULL default = 0
ALTER TABLE [Dep_PTConfig] DROP COLUMN BetType 
ALTER TABLE [Dep_PTConfig] ADD BetType INT NOT NULL CONSTRAINT DF_Dep_PTConfig_BetType DEFAULT(0)
GO
--> Change Primary Key
ALTER TABLE [Dep_PTConfig] DROP CONSTRAINT PK_Dep_PTConfig 
ALTER TABLE [Dep_PTConfig] ADD CONSTRAINT PK_Dep_PTConfig PRIMARY KEY (
		[RuleID] ASC,
		[SportType] ASC,
		[BetType] ASC,
		[IsAthena] ASC
)
GO


--> Update config for PP 
UPDATE p
SET BetType = 4101
FROM [Dep_PTConfig] p WITH(ROWLOCK)
WHERE SportType = 248 AND BetType = 0

--> Insert config 
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
--PPJackpot
SELECT 71,248,4297,1,'100.00',1 UNION ALL
SELECT 71,248,4297,0,'100.00',1 

SELECT *
FROM [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 248