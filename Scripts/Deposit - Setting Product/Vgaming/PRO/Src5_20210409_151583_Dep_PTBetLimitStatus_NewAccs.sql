/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210409
	Task: Delete redundant and copy new setting newly created customer [saba.Club] - deposit RedmineID:#151583
	DB: DBCUST/CustDB
	
	P/s : Step 5 Delete redundant and copy new setting newly created customer saba.Club Deposit
*/
-- BEGIN STEP 4.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN

	DECLARE @batch int = 3000
	DECLARE @BitOrder INT 

	CREATE TABLE #supers (custid int)
	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (171, 3801)
	
	SELECT @BitOrder= st.bitmapOrder 
	FROM Dep_ProductStatusProfile st WITH(NOLOCK) 
	INNER JOIN @SportBetType sb ON st.Sporttype = sb.SportType AND st.Bettype = sb.BetType

	
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT)
	
	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(AgentID INT,Sporttype INT,Bettype INT, PRIMARY KEY(AgentID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustStakeLevel_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustStakeLevel_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))	

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND (cs.site IN('3Star88','88Macao','AE88','AG','9Club','iBET','IBO','Liga','Abcasino','Hecbet','Dewa','TGO','365online','IONclub','Mayayule','Gampag','HuangMa','BigGaming','Boying','PKbet','IGPTech','Dawoo','CGame','Uwoniwin','ECLBET','818Bet','Heaven','Lucky88','396Club','Mybet88','e8casino','TangChao','Tripleone','11bet','GMaster','WBS','FB88','zt828','BETSUN','JIBET','WINCLUB88','Fabet','ANGbet','One88','Hong88','Bobbet','AEUG','Sin88','Debet','Zbet','Sunwin','VCBA','Gaobet','GGBook','Five88','Champion','AnvoFH','Leng4D','BBIN3','Onegaming','B24VN','allwincity','BWGaming','KingBet','Datang','YTX','erhaozhan','Datang001','CGame4','starsoccer','Lode88','XTDGT','yunji','Tianbo','TCBet','TaoCai','Soon88','Bsdbet','998bet','M8Credit','MANBETX','WMCASINO','Winbox','TIC88','Nbet','Sky88','Kbet','Dabet','AOGcasino','XO88','OXbet','RICbet','WABET','Kzing2','ManCity','Alphalota','GAMEBee','bdtt','HOT99','X2Dynamic','ug396','7Kplatform','WGaming','IGSW','TYCgame','BananaTech','UNOgaming','Pinbo','XINSHNEG','Comebet','Easywin22','Win365','BB3','ECBet88','FHLMSABA','UG2','ab6688','Mancity2','VEGA77','dj888','Barcelo9','Aoncash','Macaubet','ITCbet','9bet','M8bola','BE7','Q8bola','Bolanation','UNObet','18Luck','24AVIA','368CASH','Alpha88','BOG22','Callmeboss','DF88','GAMINGSOFT','GPIgame','Happy8','HC6YAYOU','Happy1668','Hejiyongle','HONORW','ID88','liv66','KeenOcean','mansion88','MAX88','Nbbet','OPEbet','SENIBET','TT128','US8YAYOU','VN88','W88','Xtu168','12BET','HL8','Saba789')
	AND ci.currency IN (2,3,4,5,6,9,12,13,15,20,32,41,45,46,49,50,52,53,54,55,56,57,58,61,66,70,71,73,79,80,82,83,85,86,92,93,94,96,97,121) )

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend,Currency)
	SELECT custid, roleid,mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
	END  
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.AgentID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTGroupSetting_MemberTemp(AgentID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
				ON cg.AgentID=t.AgentID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
			
		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
	END 	
	-------------------------------------------------BetSetting----------------------------------------------------------------

	SELECT a.CustID,a.SportType,a.BetType 
	INTO #Dep_CustStakeLevel_Agent
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK) 
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Member 
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK) 
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustStakeLevel_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustStakeLevel_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustStakeLevel_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustStakeLevel_MemberTemp
			
	END	
	-------------------------------------------------Licensee----------------------------------------------------------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #SMATemp s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 66 AND s.RoleID = 4
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN	
		DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID,DELETED.ProductSettingID INTO #Dep_LicenseeProductSettingTemp(CustID,ProductSettingID)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_LicenseeProductSetting cg WITH(ROWLOCK)		
		INNER JOIN #Dep_LicenseeProductSettingTemp  t 
			ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID	
	
		TRUNCATE TABLE #Dep_LicenseeProductSettingTemp			
	END
	
	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID,DELETED.Currency INTO #SMABatch(CustID,RoleID,Currency)
		FROM #SMATemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------------------Add new PT Setting----------------------------------------------------------------
		INSERT INTO dbo.Dep_CustPTSetting_Agent
				(	[CustID]
				   ,[SportType]
				   ,[BetType]
				   ,[IsLive]
				   ,[SuperPT]
				   ,[MasterPT]
				   ,[AgentPT]
				 )
			SELECT 
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,CASE WHEN a.RoleID = 4 THEN 93.00 ELSE 0 END AS SuperPT
				   ,CASE WHEN a.RoleID IN (4,3) THEN 93.00 ELSE 0 END AS MasterPT
				   ,CASE WHEN a.RoleID IN (4,2) THEN 93.00 ELSE 0 END AS AgentPT
			FROM #SMABatch a WITH(NOLOCK)
				CROSS APPLY @SportBetType t

		INSERT INTO dbo.Dep_CustPTGroupSetting_Member
				(	AgentID
				   ,[SportType]
				   ,[BetType]
				   ,[IsLive]
				   ,[SuperPT]
				   ,[MasterPT]
				   ,[AgentPT]
				 )
			SELECT 
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,0 AS SuperPT
				   ,0 AS MasterPT
				   ,93.00 AS AgentPT
			FROM #SMABatch a WITH(NOLOCK)
					CROSS APPLY @SportBetType t	
			WHERE a.RoleID=2
		-------------------------------------Betlimit Setting----------------------------------------------
		INSERT INTO [dbo].[Dep_CustStakeLevel_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
		SELECT custID, sp.sporttype, sp.BetType, d.StakeLevelID
		FROM #SMABatch t WITH(NOLOCK)
			CROSS APPLY @SportBetType sp
			INNER JOIN dbo.Dep_StakeLevel d WITH(NOLOCK) ON d.ExchangeID = t.Currency AND d.GameTypeID = sp.BetType					
		TRUNCATE TABLE #SMABatch
	END			
	
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Currency INTO #MemberBatch(CustID,Currency)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------------------Add new PT Setting----------------------------------------------------------------
		INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
		SELECT 
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0 AS IsLive
			   ,0 AS SuperPT
			   ,0 AS MasterPT
			   ,93.00 AS AgentPT
		FROM #MemberBatch a WITH(NOLOCK)
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				CROSS APPLY @SportBetType t
			WHERE m.IsGroupedPT=0

		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #MemberBatch t WITH(NOLOCK) 
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		-------------------------------------Betlimit Setting----------------------------------------------
		-----
		INSERT INTO [dbo].[Dep_CustStakeLevel_Member]
			   ([CustID]
			   ,[SportType]
			   ,[BetType]
			   ,[StakeLevelList]
			   ,[LastUpdated])
		SELECT CustID, sp.sporttype, sp.BetType, d.StakeLevelID, GetDate()
		FROM #MemberBatch t WITH(NOLOCK)
			CROSS APPLY @SportBetType sp
	INNER JOIN dbo.Dep_StakeLevel d WITH(NOLOCK) ON d.ExchangeID = t.Currency AND d.GameTypeID = sp.BetType
					
		TRUNCATE TABLE #MemberBatch
	END 
	
	-------------------------------------Licensee Setting----------------------------------------------
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 66
							AND dp.SettingType IN (4,1,8) -- Product Status, PT, StakeLevel
						) st
	WHERE temp.RoleID = 4

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled)
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden)
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)
	
END		
GO
-- END STEP 4.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 4.2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
