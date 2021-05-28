/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210223@Winfred
	Task: Add new pt for Vgaming [Redmine:#151583]	
	DB: DBCHECK/CheckResultDB
	
	P/s : Step 0 Add config job check PT
*/
USE CheckResultDB
GO
--> UpdateConfig for  saba.Club
INSERT INTO [Dep_PTConfig] (RuleID,SportType,BetType,IsAthena,PTValue,IsActive)
SELECT 71,171,0,1,'90.00,93.00',1 UNION ALL
SELECT 71,171,0,0,'90.00,93.00',1 


SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 171

GO	  
	  