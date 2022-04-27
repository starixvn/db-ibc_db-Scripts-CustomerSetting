/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220425
	Task: Delete existing data for Leap Gaming Virtual Sports 3 - Deposit API Licensees [Redmine: 171868]
	DB: DBCUST/CustDB
	
	P/s : Step 1 Delete existing data for Leap Gaming Virtual Sports 3  API Licensees
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT,@betType SMALLINT
	SET @sportType = 231 
	SET @betType = 5301
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','11bet','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','Saba789','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688')  
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
	
	
	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE s.SportType =@sportType AND s.BetType = @betType

	INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE s.SportType =@sportType AND s.BetType = @betType

	INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE s.SportType =@sportType AND s.BetType = @betType

	INSERT INTO #Dep_CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE s.SportType =@sportType AND s.BetType = @betType

	INSERT INTO #Dep_CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType  AND s.BetType = @betType

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 49

	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
	END  
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTGroupSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
				ON cg.AgentID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
			
		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
	END 		
			
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustBetSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustBetSetting_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustBetSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustBetSetting_MemberTemp
			
	END	
	
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
	
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member
	DROP TABLE #Dep_LicenseeProductSetting
END	
GO
-- END STEP 1.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 1.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 1.3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
