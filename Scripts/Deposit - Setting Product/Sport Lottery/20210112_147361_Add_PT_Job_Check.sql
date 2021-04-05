/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
 /*
	Created: 20210223@Winfred
	Task: copy pt Lottery to new pt for Sports Lottery [Redmine:#147361]	
	DB: DBCHECK/CheckResultDB
	
		P/s : Step 0 Add config job check PT
*/
USE CheckResultDB
GO
--> UpdateConfig for  Sports Lottery
INSERT INTO Dep_PTConfig (RuleID,SportType,IsAthena,PTValue,IsActive,BetType)
SELECT RuleID,169 AS SportType,IsAthena,PTValue,IsActive,BetType
FROM  Dep_PTConfig a WITH(ROWLOCK)
WHERE a.SportType = 220 

GO

SELECT * 
FROM  [Dep_PTConfig] p WITH(NOLOCK)
WHERE SportType = 169

GO	  
	  