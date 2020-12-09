/*
	Created: 20201208@Johnson
	Task: Enable currencies for API sites for Arcadia Gaming
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT
	 ,@mrecommend INT
	 ,@custid INT	 
	 ,@StakeLevelList 	VARCHAR(200)
	 ,@target VARCHAR(20) 
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF (dbo.f_CheckRepTable('custinfo') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0		
	   )
		RETURN
	
	DECLARE	@SettingLevel	TINYINT
		,@ProductSettingID	INT		
		,@ActionID			TINYINT=1
		,@ProductID			INT = 34
	
	--Stakelevel
	CREATE TABLE #CustStakeLevelDownlines (
					ID						INT IDENTITY (1,1)
				,	CustID					INT 			
				,	RoleID					TINYINT		
				,	SportType				SMALLINT
				,	BetType					SMALLINT
				,	StakeLevelList			VARCHAR(200)
				,	MemberStakeLevel		VARCHAR(200)
				,	PRIMARY KEY CLUSTERED (ID)
				);
				
	SELECT  @SettingLevel=SettingLevel,
		@ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID 
		AND SettingType IN(7,8)
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID )
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)
		
		SELECT @ActionID=0
	END
	
	INSERT INTO #CustStakeLevelDownlines(CustID,RoleID,SportType,BetType,StakeLevelList,MemberStakeLevel)
	SELECT @srecommend,4,165 as SportType,1901 as BetType,@StakeLevelList,@StakeLevelList
	UNION ALL		
	SELECT @mrecommend,3,165 as SportType,1901 as BetType,@StakeLevelList,@StakeLevelList
		
	INSERT INTO #CustStakeLevelDownlines(CustID,RoleID,SportType,BetType,StakeLevelList,MemberStakeLevel)
	SELECT CustID,RoleID,165 as SportType,1901 as BetType,@StakeLevelList,@StakeLevelList
	FROM CustInfo WITH(NOLOCK)		
	WHERE recommend=@CustID	
	
	DECLARE @StartRow INT = 1, 
		@MaxRow INT,
		@Threshold INT = 3000, 
		@StopRow INT,
		@StakeLevel VARCHAR(MAX)
			
	SET @MaxRow = (SELECT MAX(ID) FROM #CustStakeLevelDownlines);
	
	IF @MaxRow IS NULL
		RETURN
			
	IF	@Threshold >= @MaxRow
		SET	@Threshold = @MaxRow;
			
	SET @StopRow = @Threshold;
			
	IF EXISTS(SELECT TOP(1) 1 FROM #CustStakeLevelDownlines)
	BEGIN
		WHILE (0 = 0)
		BEGIN		
			SET	@StakeLevel =	(
											SELECT	custid				AS CustID
												,	RoleID				AS RoleID
												,	SportType			AS SportType	
												,	BetType				AS BetType		
												,	StakeLevelList		AS StakeLevelList	
												,	MemberStakeLevel	AS MemberStakeLevel
											FROM	#CustStakeLevelDownlines
											WHERE	ID >= @StartRow 
												AND	ID <= @StopRow
											FOR XML RAW ('StakeLevel'), ROOT ('ROOT') 
										);
					
			-- Correct downlines via ExecRep
			EXECUTE	Acc_Dep_DynamicCustSetting_05
						@StakeLevel	= @StakeLevel
					,	@ActionID	= @ActionID
			IF	@StopRow = @MaxRow 
				BREAK;
					
			SET	@StartRow = @StopRow + 1;
					
			SET	@StopRow = 1 + @StopRow + @Threshold;
					
			IF	@StopRow >= @MaxRow
				SET	@StopRow = @MaxRow;
		END;
	END;	
	--end stakelevel
	
	--begin status
	DECLARE @bitmapOrder TINYINT = 9,
		@IsDisabled BIT = 0
	
	SELECT  @SettingLevel=SettingLevel,
		@ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID 
		AND SettingType=4	
	
	IF NOT EXISTS (SELECT 1 FROM dbo.Dep_CustProductStatus T WITH(NOLOCK) WHERE t.custid=@srecommend)
	BEGIN
		INSERT INTO dbo.Dep_CustProductStatus
			(CustID
			,bitmapIsDisabled
			,bitmapIsHidden )
		SELECT	@srecommend
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,@IsDisabled) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden						
	END
	ELSE
	BEGIN
	UPDATE d
		SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
			d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
		FROM Dep_CustProductStatus d WITH(ROWLOCK) 
		WHERE d.custid=@srecommend 
	END

	IF NOT EXISTS (SELECT 1 FROM dbo.Dep_CustProductStatus T WITH(NOLOCK) WHERE t.custid=@mrecommend)
	BEGIN
		INSERT INTO dbo.Dep_CustProductStatus
			(CustID
			,bitmapIsDisabled
			,bitmapIsHidden )
		SELECT	@mrecommend
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,@IsDisabled) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden						
	END
	ELSE
	UPDATE d
		SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
			d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
		FROM Dep_CustProductStatus d WITH(ROWLOCK) 
		WHERE d.custid=@mrecommend	
	
	IF NOT EXISTS (SELECT 1 FROM dbo.Dep_CustProductStatus T WITH(NOLOCK) WHERE t.custid=@CustID)
	BEGIN
		INSERT INTO dbo.Dep_CustProductStatus
			(CustID
			,bitmapIsDisabled
			,bitmapIsHidden )
		SELECT	@CustID
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,@IsDisabled) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden						
	END
	ELSE
	UPDATE d
		SET d.bitmapIsDisabled=dbo.f_GenerateProductStatus (d.bitmapIsDisabled, @bitmapOrder,@IsDisabled) ,
			d.bitmapIsHidden=dbo.f_GenerateProductStatus (d.bitmapIsHidden, @bitmapOrder,0) 
		FROM Dep_CustProductStatus d WITH(ROWLOCK) 
		WHERE d.custid=@CustID	
		
	EXEC Acc_Dep_DynamicCustSetting_08
				@ActionID=2,
				@CustID=@CustID,
				@bitmapOrder=@bitmapOrder,					
				@IsDisabled=@IsDisabled,
				@IsDisabledDownline=0

	IF NOT EXISTS(SELECT 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID )
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		VALUES( @srecommend,@ProductSettingID)	
	--End status	
	
	--PT
	DECLARE @PT VARCHAR(MAX),
		@valPT smallmoney = 93
		
	SET @PT='<ROOT><PT SportType = "165" BetType = "1901" PT = "93.00" IsLive = "0" /></ROOT>'
	
	SELECT  @SettingLevel=SettingLevel, 
		@ProductSettingID=ProductSettingID 
	FROM Dep_ProductSetting WITH(NOLOCK) 
	WHERE ProductID=@ProductID 
		AND SettingType=1
		
	IF EXISTS (	SELECT 1 
				FROM dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) 
				WHERE CustID=@srecommend
					AND sportType = 165
					AND bettype = 1901
			)
		UPDATE a
		 SET
			   SuperPT  = @valPT
			  ,MasterPT = @valPT
			  ,AgentPT  = @valPT
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		WHERE a.CustID=@srecommend
			AND sportType = 165
			AND bettype = 1901
	ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @srecommend,165 as SportType,1901 as BetType,0 as IsLive,@valPT,@valPT,@valPT
			
	IF EXISTS (SELECT 1 
				FROM dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK) 
				WHERE CustID=@mrecommend
					AND sportType = 165
					AND bettype = 1901
			)
		UPDATE a
			SET
				 SuperPT  = 0
				,MasterPT = @valPT
				,AgentPT  = 0
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		WHERE CustID=@mrecommend 
			AND sportType = 165
			AND bettype = 1901
	ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @mrecommend,165 as SportType,1901 as BetType,0 as IsLive,0,@valPT,0
		

	IF NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting d WITH(NOLOCK)
					WHERE ProductSettingID=@ProductSettingID AND CustID=@srecommend
				)
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	VALUES( @srecommend,@ProductSettingID)	
	
	IF EXISTS (	SELECT  1 
				FROM dbo.Dep_CustPTSetting_Agent bl WITH (NOLOCK)
				WHERE CustID=@custid
					AND sportType = 165
					AND bettype = 1901
				)
		UPDATE a
		SET SuperPT   = 0
			,MasterPT = 0
			,AgentPT  = @valPT
		FROM dbo.Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		WHERE a.CustID=@custid
			AND sportType = 165
			AND bettype = 1901
	ELSE
		INSERT INTO dbo.Dep_CustPTSetting_Agent(CustID,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT)
		SELECT @CustID,165 as SportType,1901 as BetType,0 as IsLive,0,0,@valPT
		
	EXEC Acc_Dep_DynamicCustSetting_01	
		@CustID=@custid,
		@PT=@PT,					
		@ProductID=@ProductID	
	
	DROP TABLE #CustStakeLevelDownlines
END	
GO
	
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------
CREATE TABLE #tblSuper (custid INT PRIMARY KEY)
CREATE TABLE #tblMaster (CustID INT PRIMARY KEY)
CREATE TABLE #AgentList (custid INT PRIMARY KEY, srecommend INT, mrecommend INT, currency int, isfinished bit default(0))

INSERT INTO #tblSuper(custid)
SELECT custid
FROM Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('KeenOcean','Champion','GESAB','Mayayule','CGame4','ID88','ANGbet','ALPHA88','SSSGaming','MANBETX','JIBET','afb99','awc','WABET','Siamgame','gbkj','BPLE','TLC','BWGaming','Lucky88','PKbet','Webet88','Kzing2','Huangma','TaoCai','818Bet','erhaozhan','Happy1668','allwincity','BetDeal','12bet','Bobbet','Dabet','Datang','Saba789','Haifa','AEUG','Zowin','Hecbet','18Luck','Uwoniwin','awc2','Saibo','WKCUR','NewHonbet','Lode88','396Club','Callmeboss','Hejiyongle','DEWA','368Cash','365online','GamingSoft','N8BK','hjccasino','GMASTER','ALog','Soon88','Boma365','Onegaming','Dade','BOSSB','IBO','WKPHIL','Happy8','Opadmin','MAX88','A1game','VCBA','9Wsports','HonorW','VN88','TitanCraft','PanguGame','B24VN','Xtu168','Bodog','MTech','INSERTGAME','Mybet88','Nbbet','BETSUN','VWIN66','KhmerG','shengboyun','Bonanza88','Bsdbet','Boying','ECLBET','Gampag','Mayibet','Monaco','OCMS','Mansion88','txwl002','KUTECH','BOG22','OPEBET','e8casino','DingTai','Lefu','HBO999','Okada','Yibo','wmcasino','Senibet','SBObet','MARS','88Macao','AE88','Sunwin','UwinY','AsiaBet88','88Goals','XTDGT','Yunji','zt828','W88','BBIN2','Junbet','JZFortune','Pay4d','ABcasino','WBG88','YongBao','YTX','CGame','Vwin88','K8VN','WKIBPH','AnvoFH','starsoccer','iBET','IONclub','9dianyule','Xinbo','weicai','Leng4D','9Club','WBS','NextBet','Dawoo','3Star88','Gaobet','Tianbo','IGPTech','BigGaming','TCbet','WINCLUB88','HL8','Wanfang','KingBet','24AVIA','BBIN3','Honbet','GPIgame','DBP','liv66','Ole777','TangChao','Tripleone','Weiwei','HC6YAYOU','Datang001','QASite','NukeGaming','AG','Spark','ENT22','TGO','DF88','7kplatform')
		
INSERT INTO #tblMaster(CustID)
SELECT custid 
FROM custinfo WITH (NOLOCK) 
WHERE roleid=3
	AND username LIKE '%Acc%' 
	AND srecommend IN (SELECT custid FROM #tblSuper)

INSERT INTO #AgentList(custid,srecommend,mrecommend,currency)	
SELECT CustID,srecommend,mrecommend,currency
FROM customer c WITH (NOLOCK)		
WHERE roleid = 2 
	AND Srecommend IN (SELECT custid FROM #tblSuper)
	AND mrecommend NOT IN (SELECT CustID FROM #tblMaster)

						
-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0

SET @agent_cnt = (SELECT COUNT(*) FROM #AgentList )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT


DECLARE @srecommend INT,
		@mrecommend INT,
		@custid INT,
		@currency INT, 		
		@stakelevelList VARCHAR(200)
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #AgentList
	SET isfinished = 1
		,@srecommend = srecommend
		,@mrecommend = mrecommend
		,@custid = custid
		,@currency=currency			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	SELECT @stakelevelList = CAST(StakeLevelID as VARCHAR(10))
	FROM Dep_StakeLevel l WITH(NOLOCK)
		INNER JOIN	Dep_ProductSettingDetail s WITH(NOLOCK) ON l.GameTypeID=s.BetType
		INNER JOIN	Dep_ProductSetting  d WITH(NOLOCK) ON s.ProductSettingID=d.ProductSettingID
	WHERE l.ExchangeID=@Currency 
		AND d.ProductID= 34
		AND d.SettingType=8
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@mrecommend = @mrecommend, 
			@custid = @custid,
			@StakeLevelList = @StakeLevelList,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSuper	
DROP TABLE #tblMaster
DROP TABLE #AgentList
GO		
		

-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------
 

------------------------------------------------------	
-- BEGIN STEP 3: Run this SP at DBCUST/CustDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #tblSuper (custid INT PRIMARY KEY)
CREATE TABLE #tblMaster (CustID INT PRIMARY KEY)
CREATE TABLE #AgentList (custid INT PRIMARY KEY, srecommend INT, mrecommend INT, currency int, isfinished bit default(0))

INSERT INTO #tblSuper(custid)
SELECT custid
FROM Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('KeenOcean','Champion','GESAB','Mayayule','CGame4','ID88','ANGbet','ALPHA88','SSSGaming','MANBETX','JIBET','afb99','awc','WABET','Siamgame','gbkj','BPLE','TLC','BWGaming','Lucky88','PKbet','Webet88','Kzing2','Huangma','TaoCai','818Bet','erhaozhan','Happy1668','allwincity','BetDeal','12bet','Bobbet','Dabet','Datang','Saba789','Haifa','AEUG','Zowin','Hecbet','18Luck','Uwoniwin','awc2','Saibo','WKCUR','NewHonbet','Lode88','396Club','Callmeboss','Hejiyongle','DEWA','368Cash','365online','GamingSoft','N8BK','hjccasino','GMASTER','ALog','Soon88','Boma365','Onegaming','Dade','BOSSB','IBO','WKPHIL','Happy8','Opadmin','MAX88','A1game','VCBA','9Wsports','HonorW','VN88','TitanCraft','PanguGame','B24VN','Xtu168','Bodog','MTech','INSERTGAME','Mybet88','Nbbet','BETSUN','VWIN66','KhmerG','shengboyun','Bonanza88','Bsdbet','Boying','ECLBET','Gampag','Mayibet','Monaco','OCMS','Mansion88','txwl002','KUTECH','BOG22','OPEBET','e8casino','DingTai','Lefu','HBO999','Okada','Yibo','wmcasino','Senibet','SBObet','MARS','88Macao','AE88','Sunwin','UwinY','AsiaBet88','88Goals','XTDGT','Yunji','zt828','W88','BBIN2','Junbet','JZFortune','Pay4d','ABcasino','WBG88','YongBao','YTX','CGame','Vwin88','K8VN','WKIBPH','AnvoFH','starsoccer','iBET','IONclub','9dianyule','Xinbo','weicai','Leng4D','9Club','WBS','NextBet','Dawoo','3Star88','Gaobet','Tianbo','IGPTech','BigGaming','TCbet','WINCLUB88','HL8','Wanfang','KingBet','24AVIA','BBIN3','Honbet','GPIgame','DBP','liv66','Ole777','TangChao','Tripleone','Weiwei','HC6YAYOU','Datang001','QASite','NukeGaming','AG','Spark','ENT22','TGO','DF88','7kplatform')
		
INSERT INTO #tblMaster(CustID)
SELECT custid 
FROM custinfo WITH (NOLOCK) 
WHERE roleid=3
	AND username LIKE '%Acc%' 
	AND srecommend IN (SELECT custid FROM #tblSuper)

INSERT INTO #AgentList(custid,srecommend,mrecommend,currency)	
SELECT CustID,srecommend,mrecommend,currency
FROM customer c WITH (NOLOCK)		
WHERE roleid = 2 
	AND Srecommend IN (SELECT custid FROM #tblSuper)
	AND mrecommend NOT IN (SELECT CustID FROM #tblMaster)

						
-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0

SET @agent_cnt = (SELECT COUNT(*) FROM #AgentList )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT


DECLARE @srecommend INT,
		@mrecommend INT,
		@custid INT,
		@currency INT, 		
		@stakelevelList VARCHAR(200)
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #AgentList
	SET isfinished = 1
		,@srecommend = srecommend
		,@mrecommend = mrecommend
		,@custid = custid
		,@currency=currency			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	SELECT @stakelevelList = CAST(StakeLevelID as VARCHAR(10))
	FROM Dep_StakeLevel l WITH(NOLOCK)
		INNER JOIN	Dep_ProductSettingDetail s WITH(NOLOCK) ON l.GameTypeID=s.BetType
		INNER JOIN	Dep_ProductSetting  d WITH(NOLOCK) ON s.ProductSettingID=d.ProductSettingID
	WHERE l.ExchangeID=@Currency 
		AND d.ProductID= 34
		AND d.SettingType=8
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@mrecommend = @mrecommend, 
			@custid = @custid,
			@StakeLevelList = @StakeLevelList,
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSuper	
DROP TABLE #tblMaster
DROP TABLE #AgentList
GO	

-- END STEP 3: Run this SP at DBCUST/CustDB-----
-----------------------------------------------------------------------------------
 