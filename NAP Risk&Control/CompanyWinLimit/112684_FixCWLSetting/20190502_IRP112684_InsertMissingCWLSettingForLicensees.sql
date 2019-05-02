/*
	Created: Elodie
	Date: 2019-05-02
	Task: fix missing cwl settings for new licensees
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #Currency_Deposit (siteid INT, exchangeid INT, PRIMARY KEY (siteid,exchangeid))

INSERT INTO #Currency_Deposit
SELECT DISTINCT  s.siteid,ex.exchangeid AS Id
FROM bodb_licensee.dbo.LicenseeCust lc WITH (NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeID = lc.LicenseeID
	INNER JOIN dbo.exchange ex WITH (NOLOCK) ON lc.Currency = ex.exchangeid
	INNER JOIN dbo.site s WITH (NOLOCK) ON s.site = l.LicenseeName  AND S.isActive = 1
WHERE ex.currency NOT IN('H', 'C') AND s.siteid > 352

SELECT c.siteid, c.exchangeid, t.productid, t.groupID
INTO #site_currency
FROM dbo.WinLimit_ProductGlobalSetting t WITH(NOLOCK)
	CROSS APPLY #Currency_Deposit c 
	LEFT JOIN WinLimit_ProductSettingDetail pd WITH(NOLOCK) ON t.productid = pd.productid
																AND t.GroupID = pd.GroupID
																AND c.siteid = pd.siteid
																AND c.exchangeid = pd.exchangeid
WHERE pd.siteid IS NULL																


INSERT INTO WinLimit_ProductSettingDetail (ProductID, GroupID, ExchangeID, SiteID, LevelID,  IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 1 LevelID, 0 IsBlockedPlaceBet, 0 IsBlockedTransfer,p.Level1 MaxWinLimit_RM
FROM dbo.WinLimit_ProductGlobalSetting p WITH(NOLOCK)
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID															
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 2, 0, 0,p.Level2 MaxWinLimit_RM
FROM dbo.WinLimit_ProductGlobalSetting p WITH(NOLOCK)
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 3, 0 IsBlockedPlaceBet
		, p.blockedTransferLvl3 IsBlockedTransfer
		,p.Level3 MaxWinLimit_RM
FROM dbo.WinLimit_ProductGlobalSetting p WITH(NOLOCK) 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 101, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,p.Level101 MaxWinLimit_RM
FROM dbo.WinLimit_ProductGlobalSetting p WITH(NOLOCK) 
	INNER JOIN #site_currency s ON p.productid = s.productid 
									AND p.groupID = s.groupID									
UNION ALL

SELECT DISTINCT p.ProductID, p.GroupID, s.ExchangeID, s.SiteID, 102, 0 IsBlockedPlaceBet
		, 0 IsBlockedTransfer
		,p.Level102 MaxWinLimit_RM
FROM dbo.WinLimit_ProductGlobalSetting p WITH(NOLOCK) 
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
		
DROP TABLE #Currency_Deposit
DROP TABLE #site_currency