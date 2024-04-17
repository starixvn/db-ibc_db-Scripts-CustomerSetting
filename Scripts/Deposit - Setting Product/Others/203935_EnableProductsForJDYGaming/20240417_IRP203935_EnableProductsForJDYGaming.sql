/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240327@Johnson
	Task: Enable NG,VS,Sport Lottery for JDYGaming [redmine: #203935]
	DB: DBCUST/CUSTDB	
*/ 
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
( 	 
 	@custid INT 
	,@target VARCHAR(20)
)	
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF(dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0			
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0			
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0			
		OR dbo.f_CheckRepTable('Customer') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0			
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0			
	   )
	RETURN
	
	DECLARE @ProductID INT,
		@IsDisabled BIT=0,
		@IsDisabledDownLine BIT =0,
		@SportType INT,
		@BetType INT,
		@bitmapOrder TINYINT,
		@ProductSettingID	INT,
		@srecommend	INT,
		@mrecommend	INT,
		@RoleID TINYINT,
		@PT VARCHAR(MAX),
		@BetLimit VARCHAR(MAX)
		
	SELECT @srecommend=srecommend,@mrecommend=mrecommend,@RoleID = RoleID 
	FROM Customer WITH(NOLOCK) WHERE custid=@CustID
	
	-----------------------------------------------------------------------------
	--Number Game
	SELECT @PT='<ROOT><PT SportType = "161" BetType = "81" PT = "88.00" IsLive = "0" /></ROOT>'
	SELECT @BetLimit='<ROOT><BetLimit SportType="161" BetType="81" MinBet="5" MaxBet="10000" MaxPerMatch="90000" MaxPerNumber="30000"/></ROOT>'
	SELECT @SportType=161,@BetType=81,@bitmapOrder=12, @ProductID=3
	
	--Status
	SELECT @ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID AND SettingType=4	
		
	IF NOT EXISTS(SELECT 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID )
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)
			 
	UPDATE d
	SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
		d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
	FROM Dep_CustProductStatus d WITH(ROWLOCK) 
	WHERE d.custid IN (@srecommend,@mrecommend,@custid)
	
	EXEC Acc_Dep_DynamicCustSetting_03
			@ActionID=2,
			@CustID=@CustID,
			@bitmapOrder=@bitmapOrder,					
			@IsDisabled=@IsDisabled,
			@IsDisabledDownline=@IsDisabledDownLine
			
	--Comm
	EXEC Acc_Dep_DynamicCustSetting_06
			@CustID			= @CustID
			,@RoleId		= @RoleID
			,@srecommend	= @srecommend
			,@mrecommend	= @mrecommend
			,@ProductID		= @ProductID 
			,@SportType		= @SportType
			,@BetType		= @BetType
			,@Mode			= 'UpdateComm'
			
	--PT
	EXEC Acc_Dep_DynamicCustSetting_01	
		@CustID=@custid,
		@PT=@PT,					
		@ProductID=@ProductID	
		
	--Bet Limit
	UPDATE Dep_CustBetSettingGame_Agent WITH(ROWLOCK)
	SET MinBet = 5,
		MaxBet = 10000,
		MaxPerMatch = 90000,
		MaxPerNumber = 30000
	WHERE custid IN (@srecommend,@mrecommend,@custid)
		AND SportType = @SportType
		AND BetType = @BetType
	
	UPDATE Dep_CustBetSettingGameGroup_Member WITH(ROWLOCK)
	SET MinBet = 5,
		MaxBet = 10000,
		MaxPerMatch = 90000,
		MaxPerNumber = 30000
	WHERE AgentID = @custid
		AND SportType = @SportType
		AND BetType = @BetType
		
	EXEC Acc_Dep_DynamicCustSetting_02				
		@CustID=@custid,
		@BetLimit=@BetLimit,
		@Mode = 'GameBetLimit'
		
	-----------------------------------------------------------------------------
	--sport lottery	
	SELECT @BetLimit='<ROOT><BetLimit SportType="169" BetType="3611" MinBet="5" MaxBet="10000" MaxPerMatch="50000"/></ROOT>'
	SELECT @SportType=169,@BetType=3611,@bitmapOrder=25, @ProductID=63
	
	--Status
	SELECT @ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID AND SettingType=4	
		
	IF NOT EXISTS(SELECT 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID )
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)
		
	UPDATE d
	SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
		d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
	FROM Dep_CustProductStatus d WITH(ROWLOCK) 
	WHERE d.custid IN (@srecommend,@mrecommend,@custid)
	
	EXEC Acc_Dep_DynamicCustSetting_03
			@ActionID=2,
			@CustID=@CustID,
			@bitmapOrder=@bitmapOrder,					
			@IsDisabled=@IsDisabled,
			@IsDisabledDownline=@IsDisabledDownLine
	
	--Bet Limit
	UPDATE Dep_CustBetSetting_Agent WITH(ROWLOCK)
	SET MinBet = 5,
		MaxBet = 10000,
		MaxPerMatch = 50000
	WHERE custid IN (@srecommend,@mrecommend,@custid)
		AND SportType = @SportType
		AND BetType = @BetType
	
	;WITH T AS (SELECT @CustID as CustID
		UNION SELECT @srecommend 
		UNION SELECT @mrecommend 
	)
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT t.CustID,@SportType,@BetType,5 MinBet,10000 MaxBet, 50000 MaxPerMatch
	FROM T
		LEFT JOIN Dep_CustBetSetting_Agent cs WITH(NOLOCK) ON T.custid = cs.custid
															AND cs.SportType = @SportType
															AND cs.BetType = @BetType
	WHERE cs.custid IS NULL
	
	IF NOT EXISTS (SELECT 1 
					FROM Dep_ProductSetting ps WITH(NOLOCK) 
						INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) 
							ON ps.ProductSettingID=d.ProductSettingID 
					WHERE ProductID=@ProductID AND SettingType =2 AND CustID=@srecommend)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType=2
	END		
		
	EXEC Acc_Dep_DynamicCustSetting_02				
		@CustID=@custid,
		@BetLimit=@BetLimit,
		@Mode = 'BetLimit'	
	
	-----------------------------------------------------------------------------
	--VS
	SELECT @PT='<ROOT><PT SportType = "9908" BetType = "1201" PT = "88.00" IsLive = "0" /></ROOT>'
	SELECT @SportType=9908,@BetType=1201,@bitmapOrder=42,@ProductID=5
	SELECT @BetLimit='<ROOT><BetLimit SportType="9908" BetType="1201" MinBet="5" MaxBet="3000" MaxPerMatch="10000"/></ROOT>'
	
	DECLARE @vPT smallmoney = 88
	
	--Status
	SELECT @ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID AND SettingType=4	
		
	IF NOT EXISTS(SELECT 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID )
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)
		
	UPDATE d
	SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
		d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
	FROM Dep_CustProductStatus d WITH(ROWLOCK) 
	WHERE d.custid IN (@srecommend,@mrecommend,@custid)
	
	EXEC Acc_Dep_DynamicCustSetting_03
			@ActionID=2,
			@CustID=@CustID,
			@bitmapOrder=@bitmapOrder,					
			@IsDisabled=@IsDisabled,
			@IsDisabledDownline=@IsDisabledDownLine
	
	--Comm
	EXEC Acc_Dep_DynamicCustSetting_06
			@CustID			= @CustID
			,@RoleId		= @RoleID
			,@srecommend	= @srecommend
			,@mrecommend	= @mrecommend
			,@ProductID		= @ProductID 
			,@SportType		= @SportType
			,@BetType		= @BetType
			,@Mode			= 'UpdateComm'
	
	--PT
	IF NOT EXISTS (SELECT 1 FROM Dep_ProductSetting ps WITH(NOLOCK) 
									INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID 
								WHERE ProductID=@ProductID AND SettingType = 1 AND CustID=@srecommend)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType = 1
	END
		
	IF EXISTS (SELECT 1 FROM Dep_CustPTSetting_Agent (NOLOCK) WHERE custid = @srecommend AND sporttype = @SportType AND bettype = @bettype)
	BEGIN
		UPDATE Dep_CustPTSetting_Agent WITH(ROWLOCK) 
		SET  SuperPT  = @vPT
		  ,MasterPT = @vPT
		  ,AgentPT  = @vPT
		WHERE custid = @srecommend 
			AND sporttype = @SportType 
			AND bettype = @bettype
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @srecommend,@SportType,@BetType,0 IsLive,@vPT,@vPT,@vPT
	END 
	
	IF EXISTS (SELECT 1 FROM Dep_CustPTSetting_Agent (NOLOCK) WHERE custid = @mrecommend AND sporttype = @SportType AND bettype = @bettype)
	BEGIN
		UPDATE Dep_CustPTSetting_Agent WITH(ROWLOCK) 
		SET  SuperPT  = 0
		  ,MasterPT = @vPT
		  ,AgentPT  = 0
		WHERE custid = @mrecommend 
			AND sporttype = @SportType 
			AND bettype = @bettype
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @mrecommend,@SportType,@BetType,0 IsLive,0,@vPT,0
	END 
	
	IF EXISTS (SELECT 1 FROM Dep_CustPTSetting_Agent (NOLOCK) WHERE custid = @custid AND sporttype = @SportType AND bettype = @bettype)
	BEGIN
		UPDATE Dep_CustPTSetting_Agent WITH(ROWLOCK) 
		SET  SuperPT  = 0
		  ,MasterPT = 0
		  ,AgentPT  = @vPT
		WHERE custid = @custid 
			AND sporttype = @SportType 
			AND bettype = @bettype
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @custid,@SportType,@BetType,0 IsLive,0,0,@vPT
	END 
		
	EXEC Acc_Dep_DynamicCustSetting_01	
		@CustID=@custid,
		@PT=@PT,					
		@ProductID=@ProductID	
		
	--Bet Limit
	UPDATE Dep_CustBetSetting_Agent WITH(ROWLOCK)
	SET MinBet = 5,
		MaxBet = 3000,
		MaxPerMatch = 10000
	WHERE custid IN (@srecommend,@mrecommend,@custid)
		AND SportType = @SportType
		AND BetType = @BetType
	
	;WITH T AS (SELECT @CustID as CustID
		UNION SELECT @srecommend 
		UNION SELECT @mrecommend 
	)
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT t.CustID,@SportType,@BetType,5 MinBet,3000 MaxBet, 10000 MaxPerMatch
	FROM T
		LEFT JOIN Dep_CustBetSetting_Agent cs WITH(NOLOCK) ON T.custid = cs.custid
															AND cs.SportType = @SportType
															AND cs.BetType = @BetType
	WHERE cs.custid IS NULL
	
	IF NOT EXISTS (SELECT 1 
					FROM Dep_ProductSetting ps WITH(NOLOCK) 
						INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) 
							ON ps.ProductSettingID=d.ProductSettingID 
					WHERE ProductID=@ProductID AND SettingType =2 AND CustID=@srecommend)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType=2
	END		
		
	EXEC Acc_Dep_DynamicCustSetting_02				
		@CustID=@custid,
		@BetLimit=@BetLimit,
		@Mode = 'BetLimit'	
		
END
GO

-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST & replicated DB -----
--------------------------------------------------------------------------------------
DECLARE @tmpCust TABLE (custid INT, IsFinished BIT DEFAULT 0)

DECLARE @CustID INT,
	@Target VARCHAR(30)
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 
	SELECT @Target = 'REPLICATED'	

INSERT INTO @tmpCust(custid)
SELECT custid
FROM customer (NOLOCK)
WHERE srecommend = 55141461 --JDYGamingSuperRMB
	AND roleid = 2
	AND username NOT LIKE '%ACC%'			
			
-- For deployer info
DECLARE @cnt INT, @index INT = 0

SET @cnt = (SELECT COUNT(*) FROM @tmpCust )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) @tmpCust
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@custid = @custid, 						
			@target = @target
				
	WAITFOR DELAY '00:00:00.1'			
END			
GO			