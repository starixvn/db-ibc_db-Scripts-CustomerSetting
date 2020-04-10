/*
	Created: 20200409@Eden
	Task: update values for ReasonNameCS column [redmine:#131929]
	DB: DBCUST/CUSTDB
*/
USE CustDB

DECLARE @Translate TABLE (ReasonName VARCHAR(100),ReasonNameCS NVARCHAR(100), ReasonGroupID TINYINT)
INSERT INTO @Translate(ReasonName, ReasonNameCS,ReasonGroupID)
SELECT 'Abnormal', N'非正常', 1
UNION ALL SELECT 'Group Betting', N'群组投注', 2 
UNION ALL SELECT 'Hedging', N'出货群组', 3
UNION ALL SELECT 'Arbitrage', N'打水套利', 4 
UNION ALL SELECT 'Fixed Game', N'内定赛事', 5 
UNION ALL SELECT 'Robot Betting', N'机械投注', 6 
UNION ALL SELECT 'Irrigation Bet', N'灌水投注', 7 
UNION ALL SELECT 'System Formula Bet', N'系统计算投注', 8 

UPDATE pr
SET ReasonNameCS = REPLACE(pr.ReasonName,tmp.ReasonName,tmp.ReasonNameCS),
	ReasonGroupID = tmp.ReasonGroupID
FROM ProblemAccountReason pr WITH(ROWLOCK)
	INNER JOIN @Translate tmp ON pr.ReasonName LIKE tmp.ReasonName + '%'

SELECT * FROM ProblemAccountReason pr WITH(NOLOCK)

