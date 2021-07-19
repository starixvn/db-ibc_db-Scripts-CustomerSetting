/*
	Created: Johnson
	Date: 2018-03-09
	Task: Insert missing cwl setting for credit
	DB: DBCUST/CUSTDB
*/


CREATE TABLE #ProductSetting (ProductID INT, BetTypeID INT,GroupID INT,GroupName VARCHAR(200),Level1 MONEY, Level2 MONEY,Level3 MONEY, Level101 MONEY, Level102 MONEY)

INSERT INTO #ProductSetting (ProductID,BetTypeID,GroupID,GroupName,Level1,Level2,Level3,Level101,Level102)
SELECT 21,2402,8,'Allbet Casino VIP',200000,500000,800000,-200000,-500000
UNION SELECT 21,2401,9,'Allbet Casino',100000,300000,500000,-100000,-300000
UNION SELECT 6,2101,3,'RNG Casino',10000,30000,100000,-10000,-30000
UNION SELECT 12,1701,5,'Gold Deluxe',100000,300000,500000,-100000,-300000
UNION SELECT 13,2001,6,'Microgaming - Live Casino',100000,300000,500000,-100000,-300000
UNION SELECT 8,1501,4,'Keno',100000,300000,500000,-100000,-300000
UNION SELECT 5,1201,2,'Virtual Sports',100000,300000,500000,-100000,-300000
UNION SELECT 3,81,1,'Number Game',100000,300000,500000,-100000,-300000
UNION SELECT 27,2701,12,'Virtual Sports 2',100000,300000,500000,-100000,-300000
UNION SELECT 28,1021,13,'Lottery',100000,300000,500000,-100000,-300000
UNION SELECT 30,1004,15,'Bullfighting',30000,50000,100000,-30000,-50000
UNION SELECT 24,1011,11,'Fishing World',10000,30000,100000,-10000,-30000
UNION SELECT 22,4001,10,'Macau Games',10000,30000,100000,-10000,-30000
UNION SELECT 17,2008,7,'Microgaming - RNG Casino',10000,30000,100000,-10000,-30000
UNION SELECT 26,1600,14,'Lucky 3',360,60000,0,0,0
UNION SELECT 30,1004,15,'Bullfighting',30000,50000,100000,-30000,-50000


INSERT INTO WinLimit_ProductSettingDetail (ProductID, GroupID, ExchangeID, SiteID, LevelID,  IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT DISTINCT T.ProductID, GroupID, ExchangeID, s.SiteID, 1, 0, 0,t.Level1 MaxWinLimit_RM
FROM #ProductSetting t
	CROSS JOIN EXCHANGE E (NOLOCK) 
	CROSS JOIN (SELECT siteid FROM Site WITH (NOLOCK) WHERE isActive = 1 AND isLicensee = 0 ) AS S	
WHERE E.exchangeid IN (71,73)
	
UNION ALL

SELECT DISTINCT ProductID, GroupID, ExchangeID, s.SiteID, 2, 0, 0,t.Level2 MaxWinLimit_RM
FROM #ProductSetting t
	CROSS JOIN EXCHANGE E (NOLOCK) 
	CROSS JOIN (SELECT siteid FROM Site WITH (NOLOCK) WHERE isActive = 1 AND isLicensee = 0 ) AS S	
WHERE E.exchangeid IN (71,73)
	
UNION ALL

SELECT DISTINCT T.ProductID, GroupID, ExchangeID, s.SiteID, 3, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,t.Level3 MaxWinLimit_RM
FROM #ProductSetting t
	CROSS JOIN EXCHANGE E (NOLOCK) 
	CROSS JOIN (SELECT siteid FROM Site WITH (NOLOCK) WHERE isActive = 1 AND isLicensee = 0 ) AS S	
WHERE E.exchangeid IN (71,73)
	
UNION ALL

SELECT DISTINCT T.ProductID, GroupID, ExchangeID, s.SiteID, 101, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,t.Level101 MaxWinLimit_RM
FROM #ProductSetting t
	CROSS JOIN EXCHANGE E (NOLOCK) 
	CROSS JOIN (SELECT siteid FROM Site WITH (NOLOCK) WHERE isActive = 1 AND isLicensee = 0 ) AS S	
WHERE E.exchangeid IN (71,73)
	
UNION ALL

SELECT DISTINCT T.ProductID, GroupID, ExchangeID, s.SiteID, 102, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,t.Level102 MaxWinLimit_RM
FROM #ProductSetting t
	CROSS JOIN EXCHANGE E (NOLOCK) 
	CROSS JOIN (SELECT siteid FROM Site WITH (NOLOCK) WHERE isActive = 1 AND isLicensee = 0 ) AS S	
WHERE E.exchangeid IN (71,73)

--update exchange rate
UPDATE PSD
	SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM dbo.WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK) 	
	INNER JOIN dbo.Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 
	AND e.exchangeid IN (71,73)