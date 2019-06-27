/*
	Created by: Elodie
	Date: 20190627
	Task: Insert Global betlimit for sportbook
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO dbo.CS_ProductBetSetting (SportType, BetType, IsLive, Currency, MinBet, MaxBet, MaxPerEvent)
SELECT SportType, BetType, IsLive, e.exchangeid, 16, NULL, NULL
FROM CS_ProductSettingDetail ps WITH (NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK)
WHERE settingType = 2 AND ps.SportType = 9998 AND ps.BetType IN (81) AND e.exchangeid IN (20, 81)
UNION ALL
SELECT SportType, BetType, IsLive, e.exchangeid, 8, NULL, NULL
FROM CS_ProductSettingDetail ps WITH (NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK)
WHERE settingType = 2 AND ps.SportType = 9998 AND ps.BetType IN (1501,1201) AND e.exchangeid IN (20, 81)

INSERT INTO dbo.CS_ProductBetSetting (SportType, BetType, IsLive, Currency, MinBet, MaxBet, MaxPerEvent)        
SELECT ps.SportType, ps.BetType, ps.IsLive, e.exchangeid, 
	CASE WHEN ps.IsLive = 0 THEN e.minbet ELSE e.minbetlive END, NULL, NULL
FROM dbo.CS_ProductSettingDetail ps
	CROSS JOIN dbo.exchange e
WHERE ps.SportType BETWEEN 1 AND 99 AND ps.SettingType = 2
	AND e.exchangeid IN (20,81)

SELECT * 
FROM CS_ProductBetSetting m 
ORDER BY m.Currency, m.SportType, m.BetType