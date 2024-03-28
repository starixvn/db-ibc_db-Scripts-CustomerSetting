/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240327@Johnson
	Task: Enable Lottery for 568winsw [redmine: #202915]
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
	   )
	RETURN
	
	DECLARE @ProductID INT=28,
		@IsDisabled BIT=0,
		@IsDisabledDownLine BIT =0,
		@SportType INT= 220,
		@BetType INT= 1021,
		@bitmapOrder TINYINT=6,
		@ProductSettingID	INT,
		@srecommend	INT,
		@mrecommend	INT,
		@RoleID TINYINT,
		@PT VARCHAR(MAX),
		@BetLimit VARCHAR(MAX)
		
	SELECT @srecommend=srecommend,@mrecommend=mrecommend,@RoleID = RoleID 
	FROM Customer WITH(NOLOCK) WHERE custid=@CustID
	
	SELECT  @ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID AND SettingType=4	
	
	UPDATE d
	SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
		d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
	FROM Dep_CustProductStatus d WITH(ROWLOCK) 
	WHERE d.custid IN (@srecommend,@mrecommend,@custid)
	
	IF NOT EXISTS(SELECT 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
				WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID 
				)
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)	
	
	--Update status
	EXEC Acc_Dep_DynamicCustSetting_03
			@ActionID=2,
			@CustID=@CustID,
			@bitmapOrder=@bitmapOrder,					
			@IsDisabled=@IsDisabled,
			@IsDisabledDownline=@IsDisabledDownLine
	
	-----------Setting Comm-------------
	EXEC Acc_Dep_DynamicCustSetting_06
			@CustID			= @CustID
			,@RoleId		= @RoleID
			,@srecommend	= @srecommend
			,@mrecommend	= @mrecommend
			,@ProductID		= @ProductID 
			,@SportType		= @SportType
			,@BetType		= @BetType
			,@Mode			= 'UpdateComm'	

	--update PT
	SELECT @PT='<ROOT><PT SportType = "220" BetType = "1021" PT = "94.00" IsLive = "0" /></ROOT>'	
	
	--Missing PT setting for 568WinSWINR01
	IF NOT EXISTS (	SELECT  1 
				FROM dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) 				
				WHERE CustID=@CustID
					AND SportType = @sporttype 
					AND BetType = @bettype
				)
	INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
	SELECT @CustID,@SportType,@BetType,0,0,0,94
		
	EXEC Acc_Dep_DynamicCustSetting_01	
		@CustID=@custid,
		@PT=@PT,					
		@ProductID=@ProductID
	
	--Update BetLimit	
	SELECT @BetLimit='<ROOT><BetLimit SportType="220" BetType="1021" MinBet="10" MaxBet="100000" MaxPerMatch="500000"/></ROOT>'
	
	UPDATE Dep_CustBetSetting_Agent WITH(UPDLOCK,ROWLOCK)
	SET	MinBet = 10,
		MaxBet = 100000,
		MaxPerMatch = 500000
	WHERE custid IN (@srecommend,@mrecommend,@custid)
		AND SportType = @SportType
		AND BetType = @BetType
	
	;WITH T AS (SELECT @CustID as CustID
		UNION SELECT @srecommend 
		UNION SELECT @mrecommend 
	)
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch)
	SELECT t.CustID,@SportType,@BetType,10 MinBet,100000 MaxBet, 500000 MaxPerMatch
	FROM T
		LEFT JOIN Dep_CustBetSetting_Agent cs WITH(NOLOCK) ON T.custid = cs.custid
															AND cs.SportType = @SportType
															AND cs.BetType = @BetType
	WHERE cs.custid IS NULL
	
	IF NOT EXISTS (SELECT 1 
					FROM Dep_ProductSetting ps WITH(NOLOCK) 
						INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID
					WHERE ProductID=@ProductID AND SettingType =2 AND CustID=@srecommend)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,ProductSettingID
		FROM Dep_ProductSetting WITH(NOLOCK)
		WHERE ProductID=@ProductID AND SettingType=2
	END			
	
	EXEC Acc_Dep_DynamicCustSetting_02				
				@CustID=@CustID,
				@BetLimit=@BetLimit

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
WHERE srecommend = 54577775 --568winswINR
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