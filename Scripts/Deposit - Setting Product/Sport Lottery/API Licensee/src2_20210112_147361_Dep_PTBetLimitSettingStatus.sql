/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Insert PT and Betlimit for Sports Lottery - API Licensee - Deposit  [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Insert PT and Betlimit API Licensee Deposit
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN
	
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

	DECLARE @SportType SMALLINT = 169
	DECLARE @BitOrder INT 
	DECLARE @batch SMALLINT = 5000

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype) VALUES (169, 3611, 220, 1021)
	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID INTO #tmpSMATemp(CustID,RoleID)
		FROM #tmpSMA c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------PT Setting-----------------------------------------------
		--Agent Level
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
			   ,cs.IsLive
			   ,cs.SuperPT
			   ,cs.MasterPT
			   ,cs.AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
			INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = a.CustID
			INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType

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
			   ,cs.IsLive
			   ,cs.SuperPT
			   ,cs.MasterPT
			   ,cs.AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
			INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = a.CustID
			INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
		WHERE a.RoleID=2
		
		-------------------------------------Betlimit Setting----------------------------------------------
		INSERT INTO Dep_CustBetSetting_Agent(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
		FROM #tmpSMATemp t WITH(NOLOCK)
			INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
			INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

		TRUNCATE TABLE #tmpSMATemp
	END
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------PT Setting-----------------------------------------------
		--Member Level
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
			   ,cs.IsLive
			   ,cs.SuperPT
			   ,cs.MasterPT
			   ,cs.AgentPT
		FROM #tmpCustTemp a WITH(NOLOCK)
			INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
			INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = a.CustID
			INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
		WHERE m.IsGroupedPT=0

		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #tmpCustTemp t WITH(NOLOCK) 
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
		FROM #tmpCustTemp t WITH(NOLOCK)
			INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
			INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType
		
		TRUNCATE TABLE #tmpCustTemp
	END 	
	---------------------------------Check Licensee-----------------------------------------------------
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=86)
		BEGIN
			INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT @srecommend,86
		END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=87)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,87
	END

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

	WHILE (1 = 1) 
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
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=85)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,85
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 2.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('mansion88','W88','368Cash','alog','12Bet','asiabet88','Lucky88','GamingSoft','Newhonbet','365online','Dawoo','11bet','HONBET',
					  'Wanbo','KeenOcean','IBO','Bobbet','Bodog','SunGame','PKbet','Yibo','Mayfair','BOSSB','AG','HuangMa','Liga','iBET','Happy1668',
					  'KUTECH','TLC','Tianbo','KhmerG','BigGaming','IONclub','Mayayule','Fabet','Mopgaming','Abcasino','MANBETX','zt828','HonorW',
					  'Mybet88','Gampag','CGame','Royal','AEUG','IGPTech','YAYOU','Ae88','Zbet','Boying','BETSUN','WKCUR','396Club','OLE777','Sunwin',
					  'Five88','BSSB168','Wanfang','Bobo88','webet88','FLC','Callmeboss','Red88','Aplus','633esports','MTech','One88','A1game','Sun988',
					  'GMASTER','9Club','HL8','txwl002','Yunji','Sky88','VN88','TGO','24TECH','WKPHIL','3star88','Senibet','Nbbet','MRCATSB','DEWA','FB88',
					  'gbkj','GPIGAME','Nbet','ALPHA88','YTX','Heaven','Boma365','Hecbet','Debet','DingTai','ECLBET','Salon365','Tripleone','Kraton','UwinY',
					  'WINCLUB88','Soon88','ENTAPLAY','B24VN','OPEBET','88Macao','JIBET','N8G','N8B','liv66','OCMS','GGBOOK','e8casino','WBS','weicai','TopGame',
					  'PanguGame','SV88','OXbet','N88','Leng4D','YongBao','TSEnter','TangChao','TCbet','VCBA','Raisetech','ANGbet','AnvoFH','818Bet','Taipanbet',
					  'MYGAME','win365','Onegaming','Champion','XinYo','NukeGaming','US8YAYOU','Zowin','MAX88','hjccasino','Okada','HC6YAYOU','TitanCraft','Gameroom',
					  'Xinbo','MICL','allwincity','erhaozhan','CGame4','HCVIP','Swin','ID88','MFgame','N8BK','Jarvis','BPLE','Kzing2','ManCity','GESAB','Hengcai88',
					  'Lode88','Gaobet','INSERTGAME','HeleThai','Mayibet','7kplatform','Starnet','afb99','BetDeal','ENT22','GAMEBee','Hong88','TitanOne','SSSGaming',
					  '568Win','Bsdbet','Siamgame','BoinGroup','Hejiyongle','TaoCai','Dade','Datang001','NewFuture','bdtt','SDY','JIDU','Jinyazhou','Win88','Sin88',
					  'Uwoniwin','DF88','Brown888','AMG','IBG','Pinbo','BoAPI09','BWGaming','OBline','Asian88','XTDGT','wmcasino','sbt88','HOT99','JZFortune','FHLMSABA',
					  'G2Win','Datang','Bonanza88','Saba789','Man1878','starsoccer','Diamond','WGAMING','QASite','HJTK','WUYICP','Alphalota','iuplay1','TYCgame','pmwint',
					  'GOATbet','BananaTech','BB3','88Goals','DTGW','Newbet','9wickets','Mbet','WKIBPH','Apollo','Bigwiner','Win68Club','Dachen','MSbet','GPgaming88',
					  'Lefu','Weiwei','369588vip','3ge888','7Kplatfrom','Easywin22','XINSHNEG','WBG88','WB101','9wtest','M88ASIA','9w','HOT88','TXG','Sunbet138','UN168',
					  'UNOGAMING','Vwin88','KingBet','LS88','skykey','Comebet','Yabo3','AOGcasino','Pay4d','7Konline','ECBet88','HY6','Opadmin','RICbet','Dabet','Kbet',
					  'TIC88','XO88','Cali','SampleSite')
	AND ci.custid NOT IN (3287311,1574102,13682916,1574008) -- large member

ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('mansion88','W88','368Cash','alog','12Bet','asiabet88','Lucky88','GamingSoft','Newhonbet','365online','Dawoo','11bet','HONBET',
					  'Wanbo','KeenOcean','IBO','Bobbet','Bodog','SunGame','PKbet','Yibo','Mayfair','BOSSB','AG','HuangMa','Liga','iBET','Happy1668',
					  'KUTECH','TLC','Tianbo','KhmerG','BigGaming','IONclub','Mayayule','Fabet','Mopgaming','Abcasino','MANBETX','zt828','HonorW',
					  'Mybet88','Gampag','CGame','Royal','AEUG','IGPTech','YAYOU','Ae88','Zbet','Boying','BETSUN','WKCUR','396Club','OLE777','Sunwin',
					  'Five88','BSSB168','Wanfang','Bobo88','webet88','FLC','Callmeboss','Red88','Aplus','633esports','MTech','One88','A1game','Sun988',
					  'GMASTER','9Club','HL8','txwl002','Yunji','Sky88','VN88','TGO','24TECH','WKPHIL','3star88','Senibet','Nbbet','MRCATSB','DEWA','FB88',
					  'gbkj','GPIGAME','Nbet','ALPHA88','YTX','Heaven','Boma365','Hecbet','Debet','DingTai','ECLBET','Salon365','Tripleone','Kraton','UwinY',
					  'WINCLUB88','Soon88','ENTAPLAY','B24VN','OPEBET','88Macao','JIBET','N8G','N8B','liv66','OCMS','GGBOOK','e8casino','WBS','weicai','TopGame',
					  'PanguGame','SV88','OXbet','N88','Leng4D','YongBao','TSEnter','TangChao','TCbet','VCBA','Raisetech','ANGbet','AnvoFH','818Bet','Taipanbet',
					  'MYGAME','win365','Onegaming','Champion','XinYo','NukeGaming','US8YAYOU','Zowin','MAX88','hjccasino','Okada','HC6YAYOU','TitanCraft','Gameroom',
					  'Xinbo','MICL','allwincity','erhaozhan','CGame4','HCVIP','Swin','ID88','MFgame','N8BK','Jarvis','BPLE','Kzing2','ManCity','GESAB','Hengcai88',
					  'Lode88','Gaobet','INSERTGAME','HeleThai','Mayibet','7kplatform','Starnet','afb99','BetDeal','ENT22','GAMEBee','Hong88','TitanOne','SSSGaming',
					  '568Win','Bsdbet','Siamgame','BoinGroup','Hejiyongle','TaoCai','Dade','Datang001','NewFuture','bdtt','SDY','JIDU','Jinyazhou','Win88','Sin88',
					  'Uwoniwin','DF88','Brown888','AMG','IBG','Pinbo','BoAPI09','BWGaming','OBline','Asian88','XTDGT','wmcasino','sbt88','HOT99','JZFortune','FHLMSABA',
					  'G2Win','Datang','Bonanza88','Saba789','Man1878','starsoccer','Diamond','WGAMING','QASite','HJTK','WUYICP','Alphalota','iuplay1','TYCgame','pmwint',
					  'GOATbet','BananaTech','BB3','88Goals','DTGW','Newbet','9wickets','Mbet','WKIBPH','Apollo','Bigwiner','Win68Club','Dachen','MSbet','GPgaming88',
					  'Lefu','Weiwei','369588vip','3ge888','7Kplatfrom','Easywin22','XINSHNEG','WBG88','WB101','9wtest','M88ASIA','9w','HOT88','TXG','Sunbet138','UN168',
					  'UNOGAMING','Vwin88','KingBet','LS88','skykey','Comebet','Yabo3','AOGcasino','Pay4d','7Konline','ECBet88','HY6','Opadmin','RICbet','Dabet','Kbet',
					  'TIC88','XO88','Cali','SampleSite')
	AND ci.custid NOT IN (3287311,1574102,13682916,1574008) -- large member					  
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
		
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		

-- END STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
