/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20250908@Tacy	
	Task: Auto Restore DB CheckCustDB - Correct missing SB setting [RedmineID: #238121]
	DB: DBCUST-CUSTDB
*/
/*
	Source (copy from): GamingSoftIN0117676	(28324812)
	Correct for: GamingSoftIN0125925	(32407575)
*/

USE CUSTDB
GO

SELECT 32407575 as CustID, [SportType], [BetType]
	, [MinBet], [MaxBet], [MaxPerMatch], [MaxPerNumber], [MaxPayoutPerMatch]
INTO #__tmpSetting
FROM Dep_CustBetSettingGame_Member WITH (NOLOCK)
WHERE CustID=28324812
GO

UPDATE m
SET m.MinBet=t.MinBet
	,m.MaxBet=t.MaxBet
	,m.MaxPerMatch=t.MaxPerMatch
	,m.MaxPerNumber=t.MaxPerNumber
	,m.MaxPayoutPerMatch=t.MaxPayoutPerMatch
	,m.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_CustBetSettingGame_Member m WITH (ROWLOCK, UPDLOCK)
INNER JOIN #__tmpSetting t ON t.custid=m.custid
						AND t.SportType=m.SportType
						AND t.BetType=m.BetType
GO


INSERT INTO Dep_CustBetSettingGame_Member 
		([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch], [MaxPerNumber], [MaxPayoutPerMatch], [RepUpdateTime])
SELECT t.[CustID], t.[SportType], t.[BetType], t.[MinBet], t.[MaxBet], t.[MaxPerMatch], t.[MaxPerNumber], t.[MaxPayoutPerMatch], dbo.f_GetDateTime2()
FROM #__tmpSetting t 
LEFT JOIN Dep_CustBetSettingGame_Member m WITH (NOLOCK) ON t.custid=m.custid
						AND t.SportType=m.SportType
						AND t.BetType=m.BetType
WHERE m.CustID IS NULL
GO