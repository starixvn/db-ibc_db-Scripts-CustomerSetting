/*
	Created: Eden
	Date: 20200507
	Task: DELETE existed setting for Virtual game CREDIT - XocDia
	DB: DBCust/CustDB
*/

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4602)

-------------------------------------------------STAKE LEVEL-----------------------------------------------------------
SELECT a.CustID,a.SportType,a.BetType
INTO #CustStakeLevel_Agent
FROM CustStakeLevel_Agent a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

SELECT a.CustID,a.SportType,a.BetType
INTO #CustStakeLevel_Member
FROM CustStakeLevel_Member a WITH(NOLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

DROP TABLE #CustStakeLevel_Agent
DROP TABLE #CustStakeLevel_Member