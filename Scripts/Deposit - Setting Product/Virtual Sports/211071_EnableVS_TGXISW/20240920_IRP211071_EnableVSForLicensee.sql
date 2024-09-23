/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240920@Johnson
	Task: [TGXISW] - Enable Virtual Sports [Redmine: #211071]
	DB: DBCust/CustDB and all replicated servers
*/
--deploy this sp on DBCUST

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@Target VARCHAR(20)
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF(dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0			
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0	
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0	
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0	
		OR dbo.f_CheckRepTable('Customer') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0
	   )
		RETURN
		
	DECLARE @SuperID INT =108357647, --TGXISWSuperPE
		@AgentID INT=108357649, --TGXISWPE01
		@mrecommend INT
		
    ---------------------------------------------------------------			
	--PT
	DECLARE @PT VARCHAR(MAX)='<ROOT><PT SportType = "9908" BetType = "1201" PT = "91.00" IsLive = "0" /></ROOT>',
		@ProductID INT =5,
		@SportType INT=9908,
		@BetType INT=1201
		
	CREATE TABLE #tmpPT (SportType INT,Bettype INT,IsLive BIT, PT SMALLMONEY)
	
	SELECT @mrecommend=mrecommend FROM Customer WITH(NOLOCK) WHERE custid=@AgentID
	INSERT INTO #tmpPT (SportType, BetType, Islive, PT)
	SELECT @SportType,@BetType,0,91
	
	IF EXISTS (	SELECT 1 
					FROM #tmpPT ft 
						INNER JOIN dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) ON ft.SportType = bl.sporttype AND ft.BetType = bl.bettype AND ft.IsLive = bl.IsLive
					WHERE CustID=@SuperID)
		UPDATE a
		 SET
			   SuperPT  = t.PT
			  ,MasterPT = t.PT
			  ,AgentPT  = t.PT
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpPT t ON a.CustID=@SuperID AND a.SportType=t.SportType AND a.BetType=t.BetType AND t.IsLive = a.IsLive
	 ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @SuperID,SportType,BetType,IsLive,PT,PT,PT
		FROM #tmpPT t

	IF EXISTS (SELECT 1 
				FROM #tmpPT ft 
					INNER JOIN dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) ON ft.SportType = bl.sporttype AND ft.BetType = bl.bettype AND ft.IsLive = bl.IsLive
				WHERE CustID=@mrecommend)
		UPDATE a
			SET
				 SuperPT  = 0
				,MasterPT = PT
				,AgentPT  = 0
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpPT t ON a.CustID=@mrecommend AND a.SportType=t.SportType AND a.BetType=t.BetType AND t.IsLive = a.IsLive
	 ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @mrecommend,SportType,BetType,IsLive,0,PT,0
		FROM #tmpPT t

	IF NOT EXISTS (SELECT 1 
					FROM Dep_LicenseeProductSetting d WITH(NOLOCK)
						INNER JOIN Dep_ProductSetting ps WITH(NOLOCK) ON d.ProductSettingID = ps.ProductSettingID
					WHERE ProductID=@ProductID AND SettingType = 1
						AND CustID=@SuperID)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @SuperID,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType = 1
	END	

	IF EXISTS (	SELECT  1 
				FROM #tmpPT ft 
					INNER JOIN dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) ON ft.SportType = bl.sporttype AND ft.BetType = bl.bettype AND ft.IsLive = bl.IsLive
				WHERE CustID=@AgentID)
		UPDATE a
		SET SuperPT   = 0
			,MasterPT = 0
			,AgentPT  = PT
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpPT t ON a.CustID=@AgentID AND a.SportType=t.SportType AND a.BetType=t.BetType AND t.IsLive = a.IsLive
	ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @AgentID,SportType,BetType,IsLive,0,0,PT
		FROM #tmpPT t
	
	--all customers have groupedPT = 1
	EXEC Acc_Dep_DynamicCustSetting_01	
		@CustID=@AgentID,
		@PT=@PT,					
		@ProductID=@ProductID	
	
	-----------------------------------------------------------
	--Bet setting 
	DECLARE @BetLimit VARCHAR(MAX)='<ROOT><BetLimit SportType="9908" BetType="1201" MinBet="50" MaxBet="22500" MaxPerMatch="75000"/></ROOT>'
	DECLARE @MinBet MONEY = 50,
			@MaxBet MONEY = 22500,
			@MaxPerMatch MONEY = 75000
			
	CREATE TABLE #tempSMA (CustID INT)
	
	INSERT INTO #tempSMA(CustID)
	SELECT @SuperID
	UNION SELECT @mrecommend
	UNION SELECT @AgentID
	
	UPDATE main
	SET main.minbet			= @MinBet
		, main.maxbet		= @maxbet
		, main.maxpermatch	= @maxpermatch
	FROM dbo.Dep_CustBetSetting_Agent main WITH(ROWLOCK)		
	WHERE custid IN (SELECT custid FROM #tempSMA)
		AND SportType = @SportType
		AND BetType = @BetType
	
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT t.CustID,@SportType,@BetType,@MinBet,@MaxBet,@MaxPerMatch
	FROM #tempSMA t
		LEFT JOIN Dep_CustBetSetting_Agent cs WITH(NOLOCK) ON t.custid = cs.custid 
															AND cs.SportType = @SportType
															AND cs.BetType = @BetType
	WHERE cs.custid IS NULL
	
	IF NOT EXISTS (SELECT 1 FROM Dep_ProductSetting ps 
						INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID 
					WHERE CustID=@SuperID
						AND ProductID=@ProductID 
						AND SettingType=2
					)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @SuperID,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType=2
	END			
	
	EXEC Acc_Dep_DynamicCustSetting_02				
		@CustID=@AgentID,
		@BetLimit=@BetLimit
	
	-----------------------------------------------------------
	--Status
	DECLARE @IsDisabled BIT=0,
			@IsDisabledDownLine BIT=0,
			@bitmapOrder TINYINT=42
			
	IF NOT EXISTS (SELECT 1 FROM dbo.Dep_CustProductStatus T WITH(NOLOCK) WHERE t.custid=@AgentID)
	BEGIN
		INSERT INTO dbo.Dep_CustProductStatus
			(CustID
			,bitmapIsDisabled
			,bitmapIsHidden )
		SELECT	@AgentID
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,@IsDisabled) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden						
	END
	ELSE
	UPDATE d
		SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
			d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
		FROM Dep_CustProductStatus d WITH(ROWLOCK) 
		WHERE d.custid=@AgentID	

	EXEC Acc_Dep_DynamicCustSetting_03
		@ActionID=2,
		@CustID=@AgentID,
		@bitmapOrder=@bitmapOrder,					
		@IsDisabled=@IsDisabled,
		@IsDisabledDownline=@IsDisabledDownLine
			
	-------------Setting Comm-------------
	IF EXISTS (SELECT 1 FROM Dep_ProductSettingDetail p 
				INNER JOIN Dep_ProductSetting d on p.ProductSettingID = d.ProductSettingID
			WHERE d.ProductID = @ProductID
				AND SettingType = 9)
		AND @IsDisabled = 0 
	BEGIN
		EXEC Acc_Dep_DynamicCustSetting_06
			@CustID			= @AgentID
			,@RoleId		= 2
			,@srecommend	= @SuperID
			,@mrecommend	= @mrecommend
			,@ProductID		= @ProductID 
			,@SportType		= @SportType
			,@BetType		= @BetType
			,@Mode			= 'UpdateComm'
	END
	
	DROP TABLE #tempSMA
	DROP TABLE #tmpPT
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
	
EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
		@target = @target	