/*
	Created: Johnson
	Date: 2018-03-07
	Task: fix missing cwl settings for licensees
	DB: DBCUST/CUSTDB
*/

         

CREATE TABLE #ProductSetting (ProductID INT, BetTypeID INT,GroupID INT,GroupName VARCHAR(200),Level1 MONEY, Level2 MONEY,Level3 MONEY, Level101 MONEY, Level102 MONEY, blockedTransferLvl3 BIT)

INSERT INTO #ProductSetting (ProductID,BetTypeID,GroupID,GroupName,Level1,Level2,Level3,Level101,Level102,blockedTransferLvl3)
SELECT 21,2402,8,'Allbet Casino VIP',200000,500000,800000,-200000,-500000,0
UNION SELECT 21,2401,9,'Allbet Casino',100000,300000,500000,-100000,-300000,0
UNION SELECT 6,2101,3,'RNG Casino',10000,30000,100000,-10000,-30000,1
UNION SELECT 12,1701,5,'Gold Deluxe',100000,300000,500000,-100000,-300000,0
UNION SELECT 13,2001,6,'Microgaming - Live Casino',100000,300000,500000,-100000,-300000,0
UNION SELECT 8,1501,4,'Keno',100000,300000,500000,-100000,-300000,0
UNION SELECT 5,1201,2,'Virtual Sports',100000,300000,500000,-100000,-300000,0
UNION SELECT 3,81,1,'Number Game',100000,300000,500000,-100000,-300000,0
UNION SELECT 27,2701,12,'Virtual Sports 2',100000,300000,500000,-100000,-300000,0
UNION SELECT 28,1021,13,'Lottery',100000,300000,500000,-100000,-300000,0
UNION SELECT 30,1004,15,'Bullfighting',30000,50000,100000,-30000,-50000,0
UNION SELECT 24,1011,11,'Fishing World',10000,30000,100000,-10000,-30000,1
UNION SELECT 22,4001,10,'Macau Games',10000,30000,100000,-10000,-30000,1
UNION SELECT 17,2008,7,'Microgaming - RNG Casino',10000,30000,100000,-10000,-30000,1
UNION SELECT 26,1600,14,'Lucky 3',360,60000,0,0,0,0


CREATE TABLE #Currency_Deposit (siteid INT, exchangeid INT, PRIMARY KEY (siteid,exchangeid))

INSERT INTO #Currency_Deposit
SELECT DISTINCT  s.siteid,ex.exchangeid AS Id
FROM DBLIC.bodb_licensee.dbo.LicenseeCust lc WITH (NOLOCK)
  INNER JOIN DBLIC.bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeID = lc.LicenseeID
  INNER JOIN dbo.exchange ex WITH (NOLOCK) ON lc.Currency = ex.exchangeid
  INNER JOIN dbo.site s WITH (NOLOCK) ON s.site = l.LicenseeName  AND S.isActive = 1
WHERE ex.currency NOT IN('H', 'C')

SELECT c.siteid, c.exchangeid, t.productid, t.groupID
INTO #site_currency
FROM #ProductSetting t 
	CROSS APPLY #Currency_Deposit c 
	LEFT JOIN WinLimit_ProductSettingDetail pd WITH(NOLOCK) ON t.productid = pd.productid
																AND c.siteid = pd.siteid
																AND c.exchangeid = pd.exchangeid
WHERE pd.siteid IS NULL																


INSERT INTO WinLimit_ProductSettingDetail (ProductID, GroupID, ExchangeID, SiteID, LevelID,  IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 1 a, 0 b, 0 c,p.Level1 MaxWinLimit_RM
FROM #ProductSetting p 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID															
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 2, 0, 0,p.Level2 MaxWinLimit_RM
FROM #ProductSetting p 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 3, 0 IsBlockedPlaceBet
		, p.blockedTransferLvl3 IsBlockedTransfer
		,p.Level3 MaxWinLimit_RM
FROM #ProductSetting p 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 101, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,p.Level101 MaxWinLimit_RM
FROM #ProductSetting p 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 102, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,p.Level102 MaxWinLimit_RM
FROM #ProductSetting p 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID 

UPDATE PSD
	SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM dbo.WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK) 
	INNER JOIN #site_currency s ON psd.productid = s.productid 
									AND psd.groupID = s.groupID
									AND psd.exchangeid = s.exchangeid
									AND psd.siteID = s.siteID
	INNER JOIN dbo.Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 