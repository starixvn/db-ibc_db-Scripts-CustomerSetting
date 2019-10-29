/*
	Created: Eden
	Date: 20191029
	Task: DELETE existed setting for Virtual game CREDIT
	DB: DBCust/CustDB
*/

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)

------------------------------------PT Setting-------------------------------------------------	
DELETE a
FROM CustPTSetting3rd_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustPTSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustPTGroupSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

----------------------------------------WinLoss Limit Setting-------------------------------------------------		
DELETE a
FROM CustWinLossLimit_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustWinLossLimit_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
DELETE a
FROM CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType

DELETE a
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
WHERE a.GameTypeID BETWEEN 4601 AND 4604