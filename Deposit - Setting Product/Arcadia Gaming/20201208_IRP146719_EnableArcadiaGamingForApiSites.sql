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
DECLARE @site TABLE (site VARCHAR(20),currency VARCHAR(100))

INSERT INTO @site (site,currency)
SELECT 'KeenOcean'	,	'66,51,20'
UNION ALL SELECT 	'Champion'	,	'13,61,20'
UNION ALL SELECT 	'GESAB'	,	'13,20'
UNION ALL SELECT 	'Mayayule'	,	'13,4,51,20'
UNION ALL SELECT 	'CGame4'	,	'13,20'
UNION ALL SELECT 	'ID88'	,	'15,20'
UNION ALL SELECT 	'ANGbet'	,	'13,20'
UNION ALL SELECT 	'ALPHA88'	,	'4,2,15,51,3,70,20'
UNION ALL SELECT 	'SSSGaming'	,	'13,20'
UNION ALL SELECT 	'MANBETX'	,	'13,20'
UNION ALL SELECT 	'JIBET'	,	'13,20'
UNION ALL SELECT 	'afb99'	,	'2,3,4,13,15,45,51,70,20'
UNION ALL SELECT 	'awc'	,	'4,97,2,20'
UNION ALL SELECT 	'WABET'	,	'13,2,20'
UNION ALL SELECT 	'Siamgame'	,	'4,20'
UNION ALL SELECT 	'gbkj'	,	'13,20'
UNION ALL SELECT 	'BPLE'	,	'45,20'
UNION ALL SELECT 	'TLC'	,	'15,13,20'
UNION ALL SELECT 	'BWGaming'	,	'13,20'
UNION ALL SELECT 	'Lucky88'	,	'51,20'
UNION ALL SELECT 	'PKbet'	,	'13,3,4,51,20'
UNION ALL SELECT 	'Webet88'	,	'13,4,15,51,45,2,32,6,20'
UNION ALL SELECT 	'Kzing2'	,	'13,15,51,4,61,20'
UNION ALL SELECT 	'Huangma'	,	'13,20'
UNION ALL SELECT 	'TaoCai'	,	'13,20'
UNION ALL SELECT 	'818Bet'	,	'13,20'
UNION ALL SELECT 	'erhaozhan'	,	'13,51,20'
UNION ALL SELECT 	'Happy1668'	,	'13,20'
UNION ALL SELECT 	'allwincity'	,	'13,20'
UNION ALL SELECT 	'BetDeal'	,	'13,15,20'
UNION ALL SELECT 	'12bet'	,	'2,51,3,61,4,70,6,71,9,12,13,15,32,41,45,20'
UNION ALL SELECT 	'Bobbet'	,	'13,20'
UNION ALL SELECT 	'Dabet'	,	'51,20'
UNION ALL SELECT 	'Datang'	,	'51,20'
UNION ALL SELECT 	'Saba789'	,	'51,20'
UNION ALL SELECT 	'Haifa'	,	'4,13,32,45,51,20'
UNION ALL SELECT 	'AEUG'	,	'13,51,2,4,61,15,20'
UNION ALL SELECT 	'Zowin'	,	'51,20'
UNION ALL SELECT 	'Hecbet'	,	'13,20'
UNION ALL SELECT 	'18Luck'	,	'13,20'
UNION ALL SELECT 	'Uwoniwin'	,	'2,15,20'
UNION ALL SELECT 	'awc2'	,	'4,2,20'
UNION ALL SELECT 	'Saibo'	,	'13,20'
UNION ALL SELECT 	'WKCUR'	,	'4,13,51,20'
UNION ALL SELECT 	'NewHonbet'	,	'13,45,20'
UNION ALL SELECT 	'Lode88'	,	'51,20'
UNION ALL SELECT 	'396Club'	,	'2,15,13,51,4,20'
UNION ALL SELECT 	'Callmeboss'	,	'13,20'
UNION ALL SELECT 	'Hejiyongle'	,	'96,20'
UNION ALL SELECT 	'DEWA'	,	'4,13,15,51,2,20'
UNION ALL SELECT 	'368Cash'	,	'13,15,2,3,51,4,45,20'
UNION ALL SELECT 	'365online'	,	'13,61,4,51,2,15,71,32,70,3,20'
UNION ALL SELECT 	'GamingSoft'	,	'2,4,6,13,15,32,45,51,61,70,71,46,3,20'
UNION ALL SELECT 	'N8BK'	,	'51,20'
UNION ALL SELECT 	'hjccasino'	,	'13,20'
UNION ALL SELECT 	'GMASTER'	,	'2,13,51,20'
UNION ALL SELECT 	'ALog'	,	'2,3,4,6,12,13,15,32,45,51,55,56,58,61,49,82,83,84,85,86,87,88,89,80,79,71,93,94,20'
UNION ALL SELECT 	'Soon88'	,	'13,20'
UNION ALL SELECT 	'Boma365'	,	'3,4,6,13,32,51,20'
UNION ALL SELECT 	'Onegaming'	,	'13,51,4,20'
UNION ALL SELECT 	'Dade'	,	'13,46,20'
UNION ALL SELECT 	'BOSSB'	,	'13,20'
UNION ALL SELECT 	'IBO'	,	'13,4,51,15,20'
UNION ALL SELECT 	'WKPHIL'	,	'4,13,51,20'
UNION ALL SELECT 	'Happy8'	,	'13,3,20'
UNION ALL SELECT 	'Opadmin'	,	'13,20'
UNION ALL SELECT 	'MAX88'	,	'45,20'
UNION ALL SELECT 	'A1game'	,	'13,4,20'
UNION ALL SELECT 	'VCBA'	,	'13,20'
UNION ALL SELECT 	'9Wsports'	,	'13,61,20'
UNION ALL SELECT 	'HonorW'	,	'13,20'
UNION ALL SELECT 	'VN88'	,	'51,20'
UNION ALL SELECT 	'TitanCraft'	,	'13,61,20'
UNION ALL SELECT 	'PanguGame'	,	'13,20'
UNION ALL SELECT 	'B24VN'	,	'51,55,20'
UNION ALL SELECT 	'Xtu168'	,	'13,45,51,4,15,2,70,61,20'
UNION ALL SELECT 	'Bodog'	,	'2,3,4,6,9,12,13,45,51,32,15,20'
UNION ALL SELECT 	'MTech'	,	'13,2,4,15,32,45,20'
UNION ALL SELECT 	'INSERTGAME'	,	'13,51,2,4,15,20'
UNION ALL SELECT 	'Mybet88'	,	'2,4,46,20'
UNION ALL SELECT 	'Nbbet'	,	'13,20'
UNION ALL SELECT 	'BETSUN'	,	'13,20'
UNION ALL SELECT 	'VWIN66'	,	'4,51,13,20'
UNION ALL SELECT 	'KhmerG'	,	'13,2,4,51,15,45,69,61,3,20'
UNION ALL SELECT 	'shengboyun'	,	'13,20'
UNION ALL SELECT 	'Bonanza88'	,	'15,20'
UNION ALL SELECT 	'Bsdbet'	,	'13,20'
UNION ALL SELECT 	'Boying'	,	'13,3,20'
UNION ALL SELECT 	'ECLBET'	,	'2,51,20'
UNION ALL SELECT 	'Gampag'	,	'13,20'
UNION ALL SELECT 	'Mayibet'	,	'13,20'
UNION ALL SELECT 	'Monaco'	,	'2,4,13,15,45,46,51,20'
UNION ALL SELECT 	'OCMS'	,	'4,70,61,51,2,49,97,20'
UNION ALL SELECT 	'Mansion88'	,	'2,51,3,61,4,9,6,12,13,15,32,45,46,20'
UNION ALL SELECT 	'txwl002'	,	'13,20'
UNION ALL SELECT 	'KUTECH'	,	'13,51,4,20'
UNION ALL SELECT 	'BOG22'	,	'13,51,20'
UNION ALL SELECT 	'OPEBET'	,	'13,20'
UNION ALL SELECT 	'e8casino'	,	'13,20'
UNION ALL SELECT 	'DingTai'	,	'13,20'
UNION ALL SELECT 	'Lefu'	,	'13,20'
UNION ALL SELECT 	'HBO999'	,	'13,20'
UNION ALL SELECT 	'Okada'	,	'45,20'
UNION ALL SELECT 	'Yibo'	,	'13,20'
UNION ALL SELECT 	'wmcasino'	,	'13,20'
UNION ALL SELECT 	'Senibet'	,	'15,13,2,20'
UNION ALL SELECT 	'SBObet'	,	'13,20'
UNION ALL SELECT 	'MARS'	,	'13,4,51,45,32,6,15,2,20'
UNION ALL SELECT 	'88Macao'	,	'2,13,15,51,4,20'
UNION ALL SELECT 	'AE88'	,	'3,2,15,4,45,51,13,61,20'
UNION ALL SELECT 	'Sunwin'	,	'51,20'
UNION ALL SELECT 	'UwinY'	,	'13,4,20'
UNION ALL SELECT 	'AsiaBet88'	,	'2,3,4,6,12,13,15,45,51,20'
UNION ALL SELECT 	'88Goals'	,	'13,15,2,4,32,3,6,45,9,12,41,52,53,54,20'
UNION ALL SELECT 	'XTDGT'	,	'15,51,32,70,4,61,2,13,3,20'
UNION ALL SELECT 	'Yunji'	,	'13,2,4,51,15,61,20'
UNION ALL SELECT 	'zt828'	,	'2,4,15,51,20'
UNION ALL SELECT 	'W88'	,	'2,61,70,3,4,6,9,12,13,15,32,51,45,71,20'
UNION ALL SELECT 	'BBIN2'	,	'4,6,13,32,45,51,20'
UNION ALL SELECT 	'Junbet'	,	'13,51,20'
UNION ALL SELECT 	'JZFortune'	,	'92,13,20'
UNION ALL SELECT 	'Pay4d'	,	'15,20'
UNION ALL SELECT 	'ABcasino'	,	'13,51,71,4,20'
UNION ALL SELECT 	'WBG88'	,	'13,20'
UNION ALL SELECT 	'YongBao'	,	'13,51,2,4,15,61,45,20'
UNION ALL SELECT 	'YTX'	,	'13,20'
UNION ALL SELECT 	'CGame'	,	'13,20'
UNION ALL SELECT 	'Vwin88'	,	'13,51,4,20'
UNION ALL SELECT 	'K8VN'	,	'51,20'
UNION ALL SELECT 	'WKIBPH'	,	'51,13,4,20'
UNION ALL SELECT 	'AnvoFH'	,	'13,20'
UNION ALL SELECT 	'starsoccer'	,	'4,20'
UNION ALL SELECT 	'iBET'	,	'2,4,13,15,51,20'
UNION ALL SELECT 	'IONclub'	,	'15,4,13,61,45,51,2,70,3,20'
UNION ALL SELECT 	'9dianyule'	,	'13,20'
UNION ALL SELECT 	'Xinbo'	,	'13,20'
UNION ALL SELECT 	'weicai'	,	'13,20'
UNION ALL SELECT 	'Leng4D'	,	'4,20'
UNION ALL SELECT 	'9Club'	,	'2,4,51,13,15,46,61,20'
UNION ALL SELECT 	'WBS'	,	'13,20'
UNION ALL SELECT 	'NextBet'	,	'2,3,4,6,12,13,15,45,51,55,56,61,73,94,93,71,20'
UNION ALL SELECT 	'Dawoo'	,	'13,4,32,51,20'
UNION ALL SELECT 	'3Star88'	,	'2,4,13,15,20'
UNION ALL SELECT 	'Gaobet'	,	'13,4,20'
UNION ALL SELECT 	'Tianbo'	,	'13,20'
UNION ALL SELECT 	'IGPTech'	,	'2,3,4,13,15,32,45,51,61,20'
UNION ALL SELECT 	'BigGaming'	,	'13,4,15,51,61,2,3,20'
UNION ALL SELECT 	'TCbet'	,	'13,20'
UNION ALL SELECT 	'WINCLUB88'	,	'2,4,13,15,20'
UNION ALL SELECT 	'HL8'	,	'13,15,4,51,20'
UNION ALL SELECT 	'Wanfang'	,	'13,51,4,20'
UNION ALL SELECT 	'KingBet'	,	'13,20'
UNION ALL SELECT 	'24AVIA'	,	'13,4,15,51,61,45,20'
UNION ALL SELECT 	'BBIN3'	,	'13,2,4,15,51,61,20'
UNION ALL SELECT 	'Honbet'	,	'13,45,20'
UNION ALL SELECT 	'GPIgame'	,	'13,4,15,51,45,2,32,20'
UNION ALL SELECT 	'DBP'	,	'13,51,45,4,20'
UNION ALL SELECT 	'liv66'	,	'13,3,96,20'
UNION ALL SELECT 	'Ole777'	,	'13,4,15,45,20'
UNION ALL SELECT 	'TangChao'	,	'13,20'
UNION ALL SELECT 	'Tripleone'	,	'2,15,13,51,4,20'
UNION ALL SELECT 	'Weiwei'	,	'15,20'
UNION ALL SELECT 	'HC6YAYOU'	,	'13,20'
UNION ALL SELECT 	'Datang001'	,	'13,20'
UNION ALL SELECT 	'QASite'	,	'13,15,51,2,4,20'
UNION ALL SELECT 	'NukeGaming'	,	'15,20'
UNION ALL SELECT 	'AG'	,	'13,6,2,45,20'
UNION ALL SELECT 	'Spark'	,	'13,20'
UNION ALL SELECT 	'ENT22'	,	'15,13,4,51,20'
UNION ALL SELECT 	'TGO'	,	'13,20'
UNION ALL SELECT 	'DF88'	,	'4,13,20'
UNION ALL SELECT 	'7kplatform'	,	'13,20'

INSERT INTO #tblSuper(custid)
SELECT custid
FROM Dep_CustSuper s WITH(NOLOCK)
WHERE EXISTS (SELECT 1
			FROM @site t
				CROSS APPLY (SELECT * FROM dbo.strSplit(t.currency,',')) t2
			WHERE t.site = s.site	
				AND t2.val = s.currency
			)
		
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
DECLARE @site TABLE (site VARCHAR(20),currency VARCHAR(100))

INSERT INTO @site (site,currency)
SELECT 'KeenOcean'	,	'66,51,20'
UNION ALL SELECT 	'Champion'	,	'13,61,20'
UNION ALL SELECT 	'GESAB'	,	'13,20'
UNION ALL SELECT 	'Mayayule'	,	'13,4,51,20'
UNION ALL SELECT 	'CGame4'	,	'13,20'
UNION ALL SELECT 	'ID88'	,	'15,20'
UNION ALL SELECT 	'ANGbet'	,	'13,20'
UNION ALL SELECT 	'ALPHA88'	,	'4,2,15,51,3,70,20'
UNION ALL SELECT 	'SSSGaming'	,	'13,20'
UNION ALL SELECT 	'MANBETX'	,	'13,20'
UNION ALL SELECT 	'JIBET'	,	'13,20'
UNION ALL SELECT 	'afb99'	,	'2,3,4,13,15,45,51,70,20'
UNION ALL SELECT 	'awc'	,	'4,97,2,20'
UNION ALL SELECT 	'WABET'	,	'13,2,20'
UNION ALL SELECT 	'Siamgame'	,	'4,20'
UNION ALL SELECT 	'gbkj'	,	'13,20'
UNION ALL SELECT 	'BPLE'	,	'45,20'
UNION ALL SELECT 	'TLC'	,	'15,13,20'
UNION ALL SELECT 	'BWGaming'	,	'13,20'
UNION ALL SELECT 	'Lucky88'	,	'51,20'
UNION ALL SELECT 	'PKbet'	,	'13,3,4,51,20'
UNION ALL SELECT 	'Webet88'	,	'13,4,15,51,45,2,32,6,20'
UNION ALL SELECT 	'Kzing2'	,	'13,15,51,4,61,20'
UNION ALL SELECT 	'Huangma'	,	'13,20'
UNION ALL SELECT 	'TaoCai'	,	'13,20'
UNION ALL SELECT 	'818Bet'	,	'13,20'
UNION ALL SELECT 	'erhaozhan'	,	'13,51,20'
UNION ALL SELECT 	'Happy1668'	,	'13,20'
UNION ALL SELECT 	'allwincity'	,	'13,20'
UNION ALL SELECT 	'BetDeal'	,	'13,15,20'
UNION ALL SELECT 	'12bet'	,	'2,51,3,61,4,70,6,71,9,12,13,15,32,41,45,20'
UNION ALL SELECT 	'Bobbet'	,	'13,20'
UNION ALL SELECT 	'Dabet'	,	'51,20'
UNION ALL SELECT 	'Datang'	,	'51,20'
UNION ALL SELECT 	'Saba789'	,	'51,20'
UNION ALL SELECT 	'Haifa'	,	'4,13,32,45,51,20'
UNION ALL SELECT 	'AEUG'	,	'13,51,2,4,61,15,20'
UNION ALL SELECT 	'Zowin'	,	'51,20'
UNION ALL SELECT 	'Hecbet'	,	'13,20'
UNION ALL SELECT 	'18Luck'	,	'13,20'
UNION ALL SELECT 	'Uwoniwin'	,	'2,15,20'
UNION ALL SELECT 	'awc2'	,	'4,2,20'
UNION ALL SELECT 	'Saibo'	,	'13,20'
UNION ALL SELECT 	'WKCUR'	,	'4,13,51,20'
UNION ALL SELECT 	'NewHonbet'	,	'13,45,20'
UNION ALL SELECT 	'Lode88'	,	'51,20'
UNION ALL SELECT 	'396Club'	,	'2,15,13,51,4,20'
UNION ALL SELECT 	'Callmeboss'	,	'13,20'
UNION ALL SELECT 	'Hejiyongle'	,	'96,20'
UNION ALL SELECT 	'DEWA'	,	'4,13,15,51,2,20'
UNION ALL SELECT 	'368Cash'	,	'13,15,2,3,51,4,45,20'
UNION ALL SELECT 	'365online'	,	'13,61,4,51,2,15,71,32,70,3,20'
UNION ALL SELECT 	'GamingSoft'	,	'2,4,6,13,15,32,45,51,61,70,71,46,3,20'
UNION ALL SELECT 	'N8BK'	,	'51,20'
UNION ALL SELECT 	'hjccasino'	,	'13,20'
UNION ALL SELECT 	'GMASTER'	,	'2,13,51,20'
UNION ALL SELECT 	'ALog'	,	'2,3,4,6,12,13,15,32,45,51,55,56,58,61,49,82,83,84,85,86,87,88,89,80,79,71,93,94,20'
UNION ALL SELECT 	'Soon88'	,	'13,20'
UNION ALL SELECT 	'Boma365'	,	'3,4,6,13,32,51,20'
UNION ALL SELECT 	'Onegaming'	,	'13,51,4,20'
UNION ALL SELECT 	'Dade'	,	'13,46,20'
UNION ALL SELECT 	'BOSSB'	,	'13,20'
UNION ALL SELECT 	'IBO'	,	'13,4,51,15,20'
UNION ALL SELECT 	'WKPHIL'	,	'4,13,51,20'
UNION ALL SELECT 	'Happy8'	,	'13,3,20'
UNION ALL SELECT 	'Opadmin'	,	'13,20'
UNION ALL SELECT 	'MAX88'	,	'45,20'
UNION ALL SELECT 	'A1game'	,	'13,4,20'
UNION ALL SELECT 	'VCBA'	,	'13,20'
UNION ALL SELECT 	'9Wsports'	,	'13,61,20'
UNION ALL SELECT 	'HonorW'	,	'13,20'
UNION ALL SELECT 	'VN88'	,	'51,20'
UNION ALL SELECT 	'TitanCraft'	,	'13,61,20'
UNION ALL SELECT 	'PanguGame'	,	'13,20'
UNION ALL SELECT 	'B24VN'	,	'51,55,20'
UNION ALL SELECT 	'Xtu168'	,	'13,45,51,4,15,2,70,61,20'
UNION ALL SELECT 	'Bodog'	,	'2,3,4,6,9,12,13,45,51,32,15,20'
UNION ALL SELECT 	'MTech'	,	'13,2,4,15,32,45,20'
UNION ALL SELECT 	'INSERTGAME'	,	'13,51,2,4,15,20'
UNION ALL SELECT 	'Mybet88'	,	'2,4,46,20'
UNION ALL SELECT 	'Nbbet'	,	'13,20'
UNION ALL SELECT 	'BETSUN'	,	'13,20'
UNION ALL SELECT 	'VWIN66'	,	'4,51,13,20'
UNION ALL SELECT 	'KhmerG'	,	'13,2,4,51,15,45,69,61,3,20'
UNION ALL SELECT 	'shengboyun'	,	'13,20'
UNION ALL SELECT 	'Bonanza88'	,	'15,20'
UNION ALL SELECT 	'Bsdbet'	,	'13,20'
UNION ALL SELECT 	'Boying'	,	'13,3,20'
UNION ALL SELECT 	'ECLBET'	,	'2,51,20'
UNION ALL SELECT 	'Gampag'	,	'13,20'
UNION ALL SELECT 	'Mayibet'	,	'13,20'
UNION ALL SELECT 	'Monaco'	,	'2,4,13,15,45,46,51,20'
UNION ALL SELECT 	'OCMS'	,	'4,70,61,51,2,49,97,20'
UNION ALL SELECT 	'Mansion88'	,	'2,51,3,61,4,9,6,12,13,15,32,45,46,20'
UNION ALL SELECT 	'txwl002'	,	'13,20'
UNION ALL SELECT 	'KUTECH'	,	'13,51,4,20'
UNION ALL SELECT 	'BOG22'	,	'13,51,20'
UNION ALL SELECT 	'OPEBET'	,	'13,20'
UNION ALL SELECT 	'e8casino'	,	'13,20'
UNION ALL SELECT 	'DingTai'	,	'13,20'
UNION ALL SELECT 	'Lefu'	,	'13,20'
UNION ALL SELECT 	'HBO999'	,	'13,20'
UNION ALL SELECT 	'Okada'	,	'45,20'
UNION ALL SELECT 	'Yibo'	,	'13,20'
UNION ALL SELECT 	'wmcasino'	,	'13,20'
UNION ALL SELECT 	'Senibet'	,	'15,13,2,20'
UNION ALL SELECT 	'SBObet'	,	'13,20'
UNION ALL SELECT 	'MARS'	,	'13,4,51,45,32,6,15,2,20'
UNION ALL SELECT 	'88Macao'	,	'2,13,15,51,4,20'
UNION ALL SELECT 	'AE88'	,	'3,2,15,4,45,51,13,61,20'
UNION ALL SELECT 	'Sunwin'	,	'51,20'
UNION ALL SELECT 	'UwinY'	,	'13,4,20'
UNION ALL SELECT 	'AsiaBet88'	,	'2,3,4,6,12,13,15,45,51,20'
UNION ALL SELECT 	'88Goals'	,	'13,15,2,4,32,3,6,45,9,12,41,52,53,54,20'
UNION ALL SELECT 	'XTDGT'	,	'15,51,32,70,4,61,2,13,3,20'
UNION ALL SELECT 	'Yunji'	,	'13,2,4,51,15,61,20'
UNION ALL SELECT 	'zt828'	,	'2,4,15,51,20'
UNION ALL SELECT 	'W88'	,	'2,61,70,3,4,6,9,12,13,15,32,51,45,71,20'
UNION ALL SELECT 	'BBIN2'	,	'4,6,13,32,45,51,20'
UNION ALL SELECT 	'Junbet'	,	'13,51,20'
UNION ALL SELECT 	'JZFortune'	,	'92,13,20'
UNION ALL SELECT 	'Pay4d'	,	'15,20'
UNION ALL SELECT 	'ABcasino'	,	'13,51,71,4,20'
UNION ALL SELECT 	'WBG88'	,	'13,20'
UNION ALL SELECT 	'YongBao'	,	'13,51,2,4,15,61,45,20'
UNION ALL SELECT 	'YTX'	,	'13,20'
UNION ALL SELECT 	'CGame'	,	'13,20'
UNION ALL SELECT 	'Vwin88'	,	'13,51,4,20'
UNION ALL SELECT 	'K8VN'	,	'51,20'
UNION ALL SELECT 	'WKIBPH'	,	'51,13,4,20'
UNION ALL SELECT 	'AnvoFH'	,	'13,20'
UNION ALL SELECT 	'starsoccer'	,	'4,20'
UNION ALL SELECT 	'iBET'	,	'2,4,13,15,51,20'
UNION ALL SELECT 	'IONclub'	,	'15,4,13,61,45,51,2,70,3,20'
UNION ALL SELECT 	'9dianyule'	,	'13,20'
UNION ALL SELECT 	'Xinbo'	,	'13,20'
UNION ALL SELECT 	'weicai'	,	'13,20'
UNION ALL SELECT 	'Leng4D'	,	'4,20'
UNION ALL SELECT 	'9Club'	,	'2,4,51,13,15,46,61,20'
UNION ALL SELECT 	'WBS'	,	'13,20'
UNION ALL SELECT 	'NextBet'	,	'2,3,4,6,12,13,15,45,51,55,56,61,73,94,93,71,20'
UNION ALL SELECT 	'Dawoo'	,	'13,4,32,51,20'
UNION ALL SELECT 	'3Star88'	,	'2,4,13,15,20'
UNION ALL SELECT 	'Gaobet'	,	'13,4,20'
UNION ALL SELECT 	'Tianbo'	,	'13,20'
UNION ALL SELECT 	'IGPTech'	,	'2,3,4,13,15,32,45,51,61,20'
UNION ALL SELECT 	'BigGaming'	,	'13,4,15,51,61,2,3,20'
UNION ALL SELECT 	'TCbet'	,	'13,20'
UNION ALL SELECT 	'WINCLUB88'	,	'2,4,13,15,20'
UNION ALL SELECT 	'HL8'	,	'13,15,4,51,20'
UNION ALL SELECT 	'Wanfang'	,	'13,51,4,20'
UNION ALL SELECT 	'KingBet'	,	'13,20'
UNION ALL SELECT 	'24AVIA'	,	'13,4,15,51,61,45,20'
UNION ALL SELECT 	'BBIN3'	,	'13,2,4,15,51,61,20'
UNION ALL SELECT 	'Honbet'	,	'13,45,20'
UNION ALL SELECT 	'GPIgame'	,	'13,4,15,51,45,2,32,20'
UNION ALL SELECT 	'DBP'	,	'13,51,45,4,20'
UNION ALL SELECT 	'liv66'	,	'13,3,96,20'
UNION ALL SELECT 	'Ole777'	,	'13,4,15,45,20'
UNION ALL SELECT 	'TangChao'	,	'13,20'
UNION ALL SELECT 	'Tripleone'	,	'2,15,13,51,4,20'
UNION ALL SELECT 	'Weiwei'	,	'15,20'
UNION ALL SELECT 	'HC6YAYOU'	,	'13,20'
UNION ALL SELECT 	'Datang001'	,	'13,20'
UNION ALL SELECT 	'QASite'	,	'13,15,51,2,4,20'
UNION ALL SELECT 	'NukeGaming'	,	'15,20'
UNION ALL SELECT 	'AG'	,	'13,6,2,45,20'
UNION ALL SELECT 	'Spark'	,	'13,20'
UNION ALL SELECT 	'ENT22'	,	'15,13,4,51,20'
UNION ALL SELECT 	'TGO'	,	'13,20'
UNION ALL SELECT 	'DF88'	,	'4,13,20'
UNION ALL SELECT 	'7kplatform'	,	'13,20'

INSERT INTO #tblSuper(custid)
SELECT custid
FROM Dep_CustSuper s WITH(NOLOCK)
WHERE EXISTS (SELECT 1
			FROM @site t
				CROSS APPLY (SELECT * FROM dbo.strSplit(t.currency,',')) t2
			WHERE t.site = s.site	
				AND t2.val = s.currency
			)
			
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
 