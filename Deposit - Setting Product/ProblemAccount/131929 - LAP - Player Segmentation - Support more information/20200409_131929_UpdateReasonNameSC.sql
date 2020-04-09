/*
	Created: 20200409@Eden
	Task: update values for ReasonNameSC column [redmine:#131929]
	DB: DBCUST/CUSTDB
*/
USE CustDB

DECLARE @Translate TABLE (ReasonName VARCHAR(100),ReasonNameSC NVARCHAR(50))
INSERT INTO @Translate(ReasonName, ReasonNameSC)
SELECT 'Abnormal', N'非正常' 
UNION ALL SELECT 'Group Betting', N'群组投注' 
UNION ALL SELECT 'Hedging', N'出货群组' 
UNION ALL SELECT 'Arbitrage', N'打水套利' 
UNION ALL SELECT 'Fixed Game', N'内定赛事' 
UNION ALL SELECT 'Robot Betting', N'机械投注' 
UNION ALL SELECT 'Irrigation Bet', N'灌水投注' 
UNION ALL SELECT 'System Formula Bet', N'系统计算投注' 

UPDATE pr
SET ReasonNameSC = REPLACE(pr.ReasonName,tmp.ReasonName,tmp.ReasonNameSC)
FROM ProblemAccountReason pr WITH(ROWLOCK)
	INNER JOIN @Translate tmp ON pr.ReasonName LIKE tmp.ReasonName + '%'

SELECT * FROM ProblemAccountReason pr WITH(NOLOCK)

