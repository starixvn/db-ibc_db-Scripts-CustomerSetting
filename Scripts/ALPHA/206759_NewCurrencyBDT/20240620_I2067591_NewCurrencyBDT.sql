/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240620@Helios
	Task: Add setting for new currency BDT (Sportsbook, Keno, Lottery, Table Game, Sports Lottery) 
	DB: DBCUST/CustDB
*/

----------------------------------------------------------Declare & Collect Data--------------------------------------------------------------
DECLARE 
	@currency_BDT		INT,
	@FollowedCurrency		INT	  = 2,
	@ActualRate			FLOAT   = 0.0407

CREATE TABLE #Tmp_SportBetType (DymmyProductID INT , RealProductID INT , RealProductName VARCHAR(20) ,  SportType INT , BetType SMALLINT )
INSERT INTO #Tmp_SportBetType 
	(
		DymmyProductID
	    , RealProductID
	    , SportType
	    , BetType
	)
SELECT DISTINCT psp.ProductID AS DummyProductID, psp.RealProductId AS RealProductID ,  psp.SportType , psp.BetType
FROM ProductSettingProfile psp WITH (NOLOCK) WHERE psp.GroupID = 1 AND psp.SettingType = 26
UNION ALL
SELECT DISTINCT psp.ProductID AS DummyProductID, psp.RealProductId AS RealProductID ,  psp.SportType , psp.BetType
FROM ProductSettingProfile psp WITH (NOLOCK) WHERE psp.ProductID = 44 AND psp.SettingType = 23 AND psp.RealProductId <> 3

UPDATE temp
	SET temp.RealProductName = CASE
						WHEN RealProductID = 1 THEN 'SportsBook'
						WHEN RealProductID = 8 THEN 'RNG Keno'
						WHEN RealProductID = 28 THEN 'Lottery'
						WHEN RealProductID = 40 THEN 'Table Game'
						WHEN RealProductID = 63 THEN 'Sports Lottery'
					   END 
FROM #Tmp_SportBetType temp


SELECT @currency_BDT = ExchangeId
FROM exchange WITH(NOLOCK)
WHERE currency = 'BDT'

----------------------------------------------------------Start Init Data--------------------------------------------------------------

---- NO 5: Init ProductStatusSiteCurrency
IF NOT EXISTS (	SELECT TOP 1 1
			FROM ProductStatusSiteCurrency pssc WITH (NOLOCK)
			INNER JOIN Site s WITH (NOLOCK) ON pssc.SiteID = s.siteid
			INNER JOIN #Tmp_SportBetType tsbt1 ON pssc.SportType = tsbt1.SportType
			WHERE pssc.Currency = @currency_BDT
			AND s.isLicensee = 0
		)

BEGIN
	INSERT INTO ProductStatusSiteCurrency 
		(
			SportType
		    , BetType
		    , Currency
		    , SiteID
		    , IsHidden
		    , IsDisabled
		    , HasSynced
		)
	SELECT 
			pssc.SportType
		    , pssc.BetType
		    , @currency_BDT		AS  Currency
		    , pssc.SiteID
		    , IsHidden
		    , IsDisabled
		    , HasSynced
	FROM ProductStatusSiteCurrency pssc WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK) ON pssc.SiteID = s.siteid
	INNER JOIN #Tmp_SportBetType tsbt1 ON pssc.SportType = tsbt1.SportType
	WHERE pssc.Currency = @FollowedCurrency
	AND s.isLicensee = 0
END

-- No 7: Init ProductBetSetting
IF NOT EXISTS (	SELECT TOP 1 1
			FROM ProductBetSetting pbs WITH(NOLOCK)
			INNER JOIN #Tmp_SportBetType tsbt ON pbs.Sporttype = tsbt.SportType
			WHERE pbs.Currency = @currency_BDT
		)
BEGIN
	INSERT INTO ProductBetSetting 
		(
			Sporttype
		    , Bettype
		    , Currency
		    , MinBet
		    , IsDep
		    , MaxBet
		    , MaxPerMatch
		    , DefaultMinBet
		    , DefaultMaxBet
		    , DefaultMaxPerMatch
		)
	SELECT 
			pbs.Sporttype
		    , pbs.Bettype
		    , @currency_BDT AS Currency
		    , MinBet
		    , IsDep
		    , MaxBet
		    , MaxPerMatch
		    , DefaultMinBet
		    , DefaultMaxBet
		    , DefaultMaxPerMatch
	FROM ProductBetSetting pbs WITH(NOLOCK)
	INNER JOIN #Tmp_SportBetType tsbt ON pbs.Sporttype = tsbt.SportType
	WHERE pbs.Currency = @FollowedCurrency
END

-- No 9: Init LossLimit_GlobalSetting
IF NOT EXISTS (	SELECT TOP 1 1
			FROM LossLimit_GlobalSetting llgs WITH (NOLOCK)
			WHERE llgs.ExchangeId = @currency_BDT
			AND llgs.ProductId = 44
	)
BEGIN
	INSERT INTO LossLimit_GlobalSetting 
		(
			ProductId
		    , ExchangeId
		    , MinLossLimit
		    , DefaultLossLimit
		)
	SELECT
			ProductId
		    , @currency_BDT						AS  ExchangeId
		    , ROUND(MinLossLimit / @ActualRate , 3)		AS	MinLossLimit
		    , ROUND(DefaultLossLimit / @ActualRate , 3)		AS DefaultLossLimit
	FROM LossLimit_GlobalSetting llgs WITH (NOLOCK)
	WHERE llgs.ExchangeId = @FollowedCurrency
	AND llgs.ProductId = 44
END

---- No 13: Init WinLimit_ProductSettingDetail
--IF NOT EXISTS (	SELECT TOP 1 1
--			FROM WinLimit_ProductSettingDetail wlpsd WITH (NOLOCK)
--			INNER JOIN Site s WITH (NOLOCK) ON wlpsd.SiteID = s.siteID
--			INNER JOIN #Tmp_SportBetType tsbt ON wlpsd.ProductID = tsbt.RealProductID 
--			WHERE s.isLicensee = 0
--			AND wlpsd.ExchangeID = @currency_BDT
--			AND tsbt.RealProductID NOT IN (1,40))
--BEGIN
--	INSERT INTO WinLimit_ProductSettingDetail 
--		(
--			ProductID
--		    , GroupID
--		    , ExchangeID
--		    , SiteID
--		    , LevelID
--		    , MaxWinLimit
--		    , IsBlockedPlaceBet
--		    , IsBlockedTransfer
--		    , MaxWinLimit_RM
--		    , IsSuspendedAccount
--		)
--	SELECT	
--			ProductID
--		    , GroupID
--		    , @currency_BDT			AS ExchangeID
--		    , wlpsd.SiteID
--		    , LevelID
--		    , MaxWinLimit
--		    , IsBlockedPlaceBet
--		    , IsBlockedTransfer
--		    , MaxWinLimit_RM
--		    , IsSuspendedAccount
--	FROM WinLimit_ProductSettingDetail wlpsd WITH (NOLOCK)
--	INNER JOIN Site s WITH (NOLOCK) ON wlpsd.SiteID = s.siteID
--	INNER JOIN #Tmp_SportBetType tsbt ON wlpsd.ProductID = tsbt.RealProductID 
--	WHERE s.isLicensee = 0
--	AND wlpsd.ExchangeID = @FollowedCurrency
--	AND tsbt.RealProductID NOT IN (1,40))

--END

-- No 14: Init MaxPayoutGlobalSetting
IF NOT EXISTS (	SELECT TOP 1 1
			FROM MaxPayoutGlobalSetting m  WITH (NOLOCK)
			INNER JOIN #Tmp_SportBetType tsbt ON m.SportType = tsbt.SportType AND m.BetType = tsbt.BetType
			WHERE tsbt.DymmyProductID = 1 
			AND tsbt.SportType IN (1,99) 
			AND tsbt.BetType = 9
			AND m.Currency = @currency_BDT
		)
BEGIN
	INSERT INTO MaxPayoutGlobalSetting 
		(
			SportType
		    , BetType
		    , Currency
		    , SingleMatchParlay
		    , Combo2
		    , Combo35
		    , ComboOver6
		    , SettingStatus
		)
	SELECT
		  m.SportType
		, m.BetType
		, @currency_BDT						AS Currency
		, ROUND(SingleMatchParlay / @ActualRate , 3)	AS SingleMatchParlay
		, ROUND(Combo2 / @ActualRate , 3)			AS Combo2
		, ROUND(Combo35 / @ActualRate , 3)			AS Combo35
		, ROUND(ComboOver6 / @ActualRate , 3)		AS ComboOver6
		, 0								AS SettingStatus
	FROM MaxPayoutGlobalSetting m  WITH (NOLOCK)
	INNER JOIN #Tmp_SportBetType tsbt ON m.SportType = tsbt.SportType AND m.BetType = tsbt.BetType
	WHERE tsbt.DymmyProductID = 1 
	AND tsbt.SportType IN (1,99) 
	AND tsbt.BetType = 9
	AND m.Currency = @FollowedCurrency
END
-- No 19: Init ProductProfileSiteCurrency : No Data 


-- No 20: Init 


DROP TABLE #Tmp_SportBetType