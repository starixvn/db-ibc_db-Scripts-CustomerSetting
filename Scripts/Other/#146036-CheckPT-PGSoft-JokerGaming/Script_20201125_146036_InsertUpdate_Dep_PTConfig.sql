/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20201125@Eden
	Task: Insert table Dep_PTConfig for PG Soft, Joker Gaming [Redmine:#146036]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO
--> Insert config 
INSERT INTO [Dep_PTConfig] (RuleID,SportType,IsAthena,PTValue,IsActive)
--PG Soft
SELECT 71,232,1,'90.00',1 UNION ALL
SELECT 71,232,0,'92.00',1 UNION ALL
--Joker Gaming
SELECT 71,234,1,'90.00',1 UNION ALL
SELECT 71,234,0,'92.00',1

--SELECT * FROM [Dep_PTConfig] WHERE sporttype IN(232,234)
