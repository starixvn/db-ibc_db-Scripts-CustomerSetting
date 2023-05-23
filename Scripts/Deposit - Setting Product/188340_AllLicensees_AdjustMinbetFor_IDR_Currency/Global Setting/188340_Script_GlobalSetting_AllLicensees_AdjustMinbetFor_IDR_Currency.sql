/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/05/19
  Task: Alpha - Adjust bet limit of Indo customers [redmine : #188340]
  DB: DBCUST/CustDB

    Revisions: Modified Script Upd BetSetting

	Param's Explanation:  
	
*/
--DEPLOY THIS @DBCUST.CustDB -------- 

	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';   

	SET NOCOUNT ON
	DECLARE @MinBet_new			MONEY = 10


	--Currency apply setting
	CREATE TABLE #Exchange (ExchangeId INT PRIMARY KEY  )

	INSERT INTO #Exchange
	SELECT ExchangeId 
	FROM exchange WITH (NOLOCK)
	WHERE currency IN ('IN','IN2')															-- currency apply setting

	CREATE TABLE #SportType_BetType_ApplyChanged(
		ProductID		INT ,
		SportType		INT ,
		BetType			INT ,
		PRIMARY KEY CLUSTERED (ProductID , SportType , BetType)
	)

	-- Collect SportType BetType of 3rdProduct:
	--Virtual Sports: 5 ; Virtual Sports2: 27												--> Virtual Sport 1 & 2: No change, min bet = 10 already
	--RNG Keno: 8  ; Lottery: 28  ; Table Game: 40  ; Sports Lottery: 63					--> Change min bet from 5 to 10
	--bitcoin : 69																			--> Bitcoin: Change min from 25 to 10
	INSERT INTO #SportType_BetType_ApplyChanged
	SELECT DISTINCT ProductID ,  SportType	,  Bettype
	FROM Dep_ProductSetting ps WITH(NOLOCK)   
	INNER JOIN Dep_ProductSettingDetail d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID    
	WHERE (ProductID IN (8,28,40,63,69) AND SettingType=2 )
	OR	(ProductID = 1 AND SettingType IN (10,12) )

	-- Update Minbet BetSetting Global
	UPDATE bs 
		SET bs.MinBet = @MinBet_new
	FROM Dep_ProductBetSetting bs WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Exchange e 
			ON bs.Currency = e.ExchangeId
	INNER JOIN #SportType_BetType_ApplyChanged sb 
			ON bs.Sporttype = sb.SportType AND bs.Bettype = sb.BetType
	WHERE (sb.ProductID = 69 AND bs.MinBet = 25
	   OR  sb.ProductID IN (8,28,40,63) AND bs.MinBet = 5
	   OR  sb.ProductID = 1
	)

	DROP TABLE #Exchange
	DROP TABLE #SportType_BetType_ApplyChanged
