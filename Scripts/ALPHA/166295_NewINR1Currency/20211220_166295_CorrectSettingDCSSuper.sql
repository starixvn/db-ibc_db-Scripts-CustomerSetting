/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211220
	Task:		Correct Data for super currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

	DECLARE @Currency INT = 10 , @SiteID INT  = 1
	CREATE TABLE #Supers (custid INT)

	CREATE TABLE #ProductSettingDetail(  
	   [SettingType] [smallint] NOT NULL,  
	   [SportType] [smallint] NOT NULL,  
	   [BetType] [smallint] NOT NULL,  
	   [IsLive] [bit] NOT NULL  
	  ) 
	 CREATE TABLE #OfferedProductList(  
	   [ProductID] [tinyint] NOT NULL,  
	   [SportType] [smallint] NOT NULL,  
	   [BetType] [smallint] NOT NULL,  
	   [IsHidden] [BIT] NOT NULL  
	  )   
	CREATE TABLE #CustWinLossLimit_Agent(CustID INT,Sporttype INT,Bettype INT,MaxWinLimit SMALLMONEY,MaxLossLimit MONEY,IsAutoReset	BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustStakeLevel_Agent(CustID INT,Sporttype INT,Bettype INT,StakeLevelList VARCHAR(200), PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT,Sporttype INT,Bettype INT,MinBet MONEY,MaxBet MONEY,MaxPerMatch MONEY, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	
	INSERT INTO #OfferedProductList (ProductID, SportType, BetType, IsHidden)  
	SELECT RealProductId, SportType, BetType, IsHidden  
	FROM dbo.ProductSettingDetail WITH (NOLOCK)  
	WHERE SettingType IN (4,11,13)  

	UPDATE op  
	SET op.IsHidden = stt.IsHidden  
	FROM #OfferedProductList op  
	INNER JOIN dbo.ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype  
	WHERE stt.Currency = @Currency AND (stt.SiteID = @SiteID OR stt.SiteID = 0)  
	 
	UPDATE op  
	SET op.IsHidden = stt.IsHidden  
	FROM #OfferedProductList op  
	INNER JOIN dbo.ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype  
	WHERE (stt.Currency = @Currency OR stt.Currency = 0 ) AND stt.SiteID = @SiteID  

	UPDATE op  
	SET op.IsHidden = 1
	FROM #OfferedProductList op  
	WHERE ProductID = 20  

	INSERT #ProductSettingDetail(SettingType,SportType,BetType,IsLive)  
	SELECT SettingType  
	  ,ps.SportType  
	  ,ps.BetType  
	  ,IsLive  
	FROM [dbo].[ProductSettingDetail] ps WITH(NOLOCK)  
	INNER JOIN (SELECT DISTINCT ProductID, IsHidden FROM #OfferedProductList WITH (NOLOCK)) op ON ps.RealProductId = op.ProductID  
	WHERE op.IsHidden = 0 AND ps.SettingType NOT IN (4,11,13)  

	INSERT INTO #Supers(custid)				
	SELECT 58952555	AS custid UNION ALL SELECT 58956510	AS custid --'SRHB','HR'

	-- update
	-----------SMA WinLimit
	SELECT * INTO #SportBettypeFilter6  
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,6,0)  
	INSERT INTO #SportBettypeFilter6  
	SELECT *   
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,12,0)  
	
	INSERT INTO #CustWinLossLimit_Agent
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MaxWinLimit]  
		,[MaxLossLimit]  
		,[IsAutoReset])  
	SELECT  
		su.custid  
		,ft.SportType  
		,ft.BetType  
		,0  
		,gs.DefaultLossLimit  
		,1  
	FROM #SportBettypeFilter6 ft   
	INNER JOIN #ProductSettingDetail fil ON ft.SettingType = fil.SettingType AND ft.SportType = fil.SportType AND ft.BetType = fil.BetType   
	INNER JOIN LossLimit_GlobalSetting gs ON gs.ProductId = ft.ProductID   AND gs.ExchangeId = @Currency
	CROSS APPLY #Supers su 

	-----------Stake Level
	SELECT * INTO #SportBettypeFilter7  
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,7,0)  
	INSERT INTO #SportBettypeFilter7  
	SELECT *   
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,17,0)  
	UNION ALL  
	SELECT *   
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,8,0)  

	DELETE sb    
	FROM #SportBettypeFilter7 sb  
	INNER JOIN dbo.SportNonOfferedSiteCurrency ssc WITH(NOLOCK) ON sb.SportType = ssc.SportType AND sb.Bettype = ssc.Bettype  
	WHERE ssc.Currency = @Currency AND (ssc.SiteID = @SiteID OR ssc.SiteID = 0)  
	 
	DELETE sb    
	FROM #SportBettypeFilter7 sb  
	INNER JOIN dbo.SportNonOfferedSiteCurrency ssc WITH(NOLOCK) ON sb.SportType = ssc.SportType AND sb.Bettype = ssc.Bettype  
	WHERE (ssc.Currency = @Currency OR ssc.Currency = 0 ) AND ssc.SiteID = @SiteID    

	INSERT INTO #CustStakeLevel_Agent  ( CustID , SportType    , BetType , StakeLevelList)  
	SELECT Su.custid, sbf.SportType, sbf.Bettype, LEFT(sl.list, LEN(sl.list) - 1)  
	FROM #SportBettypeFilter7 AS sbf  
	 INNER JOIN #ProductSettingDetail ps ON ps.BetType = sbf.Bettype AND ps.SportType = sbf.SportType AND ps.SettingType = sbf.SettingType  
	 CROSS APPLY (  
	  SELECT CAST(sl.StakeLevelID AS VARCHAR) + ','  
	  FROM  dbo.StakeLevel AS sl WITH(NOLOCK) 
	  WHERE sl.ExchangeId = @Currency  
	   AND sl.GameTypeID = sbf.Bettype  
	  FOR XML PATH ('')  
	 ) sl(list) 
	 CROSS APPLY #Supers su  
	WHERE sl.list IS NOT NULL 	

	-----------Bet Game Limit

	SELECT t.* INTO #SportBettypeFilter9  
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,9,0) t  

	INSERT INTO #SportBettypeFilter9  
	SELECT *   
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,16,0)  
     
	INSERT INTO #CustBetSetting3rd_Agent
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet]  
		,[MaxPerMatch])  
	SELECT  
		su.custid  
		,s.SportType  
		,s.BetType  
		,ps.DefaultMinBet  
		,ps.DefaultMaxBet  
		,ps.DefaultMaxPerMatch  
	FROM #SportBettypeFilter9 s  
	INNER JOIN #ProductSettingDetail fil ON s.SettingType = fil.SettingType AND s.SportType = fil.SportType AND s.BetType = fil.BetType AND s.IsLive = fil.IsLive  
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON s.SportType = ps.Sporttype AND s.Bettype = ps.Bettype AND ps.IsDep = 0 AND ps.Currency = @Currency 
	CROSS APPLY #Supers su 

	CREATE TABLE #SportBettypeFilter20(  
		SportType   SMALLINT,   
		BetType     SMALLINT,   
		IsLive      BIT,   
		SettingType SMALLINT  
	)  

	INSERT INTO #SportBettypeFilter20(SportType,BetType,IsLive,SettingType)  
	SELECT SportType,BetType,IsLive,SettingType  
	FROM dbo.f_CustSetting_SportBetTypeSettingSelect(NULL,20,0) t  

	INSERT INTO #CustBetSetting3rd_Agent  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet]  
	)  
	SELECT  
		su.custid  
		,s.SportType  
		,s.BetType  
		,ps.DefaultMinBet  
		,ps.DefaultMaxBet  
	FROM #SportBettypeFilter20 s  
	INNER JOIN #ProductSettingDetail fil ON s.SettingType = fil.SettingType AND s.SportType = fil.SportType AND s.BetType = fil.BetType AND s.IsLive = fil.IsLive  
	INNER JOIN dbo.ProductBetSetting ps WITH (NOLOCK) ON s.SportType = ps.Sporttype AND s.Bettype = ps.Bettype AND ps.IsDep = 0 AND ps.Currency = @Currency 
	CROSS APPLY #Supers su  
	
	-----------MaxPayout
	
	UPDATE mpa
	SET mpa.SingleMatchParlay = cs.SingleMatchParlay,
		mpa.Combo2 = cs.Combo2,
		mpa.Combo35 = cs.Combo35,
		mpa.ComboOver6 = cs.ComboOver6
	FROM CustMaxPayoutSetting_Agent mpa  WITH(ROWLOCK, UPDLOCK) 
	INNER JOIN #Supers su ON Su.custid = mpa.CustID
	INNER JOIN MaxPayoutGlobalSetting cs WITH(NOLOCK)  ON cs.Currency = @Currency AND cs.SportType = mpa.SportType  AND cs.BetType = mpa.BetType
	
	
	INSERT INTO dbo.CustWinLossLimit_Agent  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MaxWinLimit]  
		,[MaxLossLimit]  
		,[IsAutoReset] 
	) 
	SELECT [CustID]  
		,[SportType]  
		,[BetType]  
		,[MaxWinLimit]  
		,[MaxLossLimit]  
		,[IsAutoReset] 
	FROM #CustWinLossLimit_Agent a
	WHERE NOT EXISTS (SELECT TOP 1 1 
					  FROM dbo.CustWinLossLimit_Agent WITH (NOLOCK) 
					  WHERE CustID = a.CustID AND SportType = a.Sporttype AND bettype = a.Bettype )
	
	INSERT INTO dbo.CustStakeLevel_Agent  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[StakeLevelList]  
	) 
	SELECT [CustID]  
		,[SportType]  
		,[BetType]  
		,[StakeLevelList]  
	FROM #CustStakeLevel_Agent a
	WHERE NOT EXISTS (SELECT TOP 1 1 
					  FROM dbo.CustStakeLevel_Agent WITH (NOLOCK) 
					  WHERE CustID = a.CustID AND SportType = a.Sporttype AND bettype = a.Bettype )					
	INSERT INTO dbo.CustBetSetting3rd_Agent  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet]  
		,[MaxPerMatch] 
	) 
	SELECT [CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet]  
		,[MaxPerMatch] 
	FROM #CustBetSetting3rd_Agent a
	WHERE NOT EXISTS (SELECT TOP 1 1 
					  FROM dbo.CustBetSetting3rd_Agent WITH (NOLOCK) 
					  WHERE CustID = a.CustID AND SportType = a.Sporttype AND bettype = a.Bettype )  	
	
DROP TABLE #SUPERS
DROP TABLE #ProductSettingDetail
DROP TABLE #OfferedProductList
DROP TABLE #SportBettypeFilter6
DROP TABLE #SportBettypeFilter7
DROP TABLE #SportBettypeFilter9
DROP TABLE #SportBettypeFilter20
DROP TABLE #CustWinLossLimit_Agent
DROP TABLE #CustStakeLevel_Agent
DROP TABLE #CustBetSetting3rd_Agent
