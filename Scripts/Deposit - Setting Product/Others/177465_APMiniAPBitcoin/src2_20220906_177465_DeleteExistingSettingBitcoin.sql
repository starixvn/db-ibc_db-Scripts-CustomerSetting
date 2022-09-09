/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220907
	Task:  Delete existing data for Bitcoin - deposit RedmineID:#177465
	DB: DBCUST/CustDB
	
	P/s : Step 2 Delete existing data all Licensee Deposit for Bitcoin
*/
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
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT	 = 175 , @BetType SMALLINT = 7901

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('ZhiFeng255','JIB88','GESAB','Mayayule','CGame4','ZhiFeng201','GoldenFCV','DawooCV','FLCSW','iBET','vnggame','Million','erhaozhan','vssports','ug396','VCBA','OCMS','YYHbet','442ball','zt828','CloudRock','W88','n88clubSW','BBIN2','9wtest','yuanbaoCV','Ot88','ZhiFeng242','ZFRT129','QASite','PLAYES','NukeGaming','TGXICV','3Star88','bdtt','TSEnter','SGM88','ZhiFeng176','368Cash','wmcasinoS','365online','9wickets','PKbet','allwinCV','IDNSPORT','ZF055PMW','ABEMT','liv66SW','XmenSW','ZhiFeng221','ZhiFeng035','MTech','Lucklotter','INSERTGAME','SL88SW','0sServices','FKsport','WSlots','ZFRT242','633esports','Royal','ISC888','ALog','UG2','Soon88','88Macao','5ATech','Kingfun','Haifa','AEUG','HFYX','Winsplay','JJBGAME','ZhiFeng050','Tesla','GPIgame','DBP','Okada','Yibo','ZFRT080','NextBet','Happistar','ZhiFeng204','TGAA0813','Xiaojin','MICL','ECLBET','MYGAMECV','OBGM','Gampag','PINT','DTGJZ','Huangma','USSBET','Wcasino','GoldenF2CV','ROYAL88','ZFRT144CV','ZFRT219','TangChao','Tripleone','ZhiFeng262','IBO','WKPHIL','M88ASIA','lionsclub','livv88sw','ABcasino','TSLA','X2Dynamic','BigGaming','CandyA18','TCbet','DEWA','ZFRT165','LSM99','WINHX1','ID88','ZFRT175','DFGame','OYO','Xinli3CV','383sport','YSYBO688CV','ZhiFeng133','Happy8','HIDZ','ZF215CNY','VCBACV','BSSB168CV','Mybet88','Omni88','kbosportCV','WRSeamless','Uwoniwin','awc2','ZFRT259','e8casinoCV','NewFuture','WKCUR','VN88','B24VN','EclipseSW','Xtu168','CGame','ZFRT179','G4ALL','ZFRT155new','FHLMSABAS','ZhiFeng107','ZhiFeng032','Xinli2CV','ZFRT218','GoldenF2','VKGAMECV','GamingSoft','LIGAWLHKB','US8YAYOU','N8BK','IONclub','UGaming','Diamond','Xinbo','YakaGaming','XLMEDIA','dj888','FB88CV','368CashSW','BOG22','OPEBET','e8casino','DingTai','W88CV','BPLE','ZhiFeng012','Apollo369','TLC','Dawooxin','SDYSW','12bet','ZhiFeng009','OESports','Sunwin','AsiaBet88','SEAGaming','Riverich','Mayibet','ZhiFeng021','ig128','3ge888','Soon88CV','shengboyun','Bonanza88','loc','SampleSite','F88IN1SW','ZFRT126CV','bigbet','CENTRAL168','ZFRT132','VEGA77','bdtt2','Baji','ZhiFeng013','ZhiFeng183','Lode88','M8Credit','N8G','HY6','HBPT','SBObet','Bobo88','GmasterS','MARS','DongYing','beplay','ig128s','Leng4D','TYgaming','24AVIASL','JDJDAPI','9Club','WBS','ZF138VND','d3sports','ZhiFeng051','ZhiFeng222','OLE777CV','DCSDemo','ZhiFeng019','ZhiFeng055','OSUSDT','golden8','Zhifeng215','Wanfang','568WinSW','ZFRT240','Asiasigma','ZhiFeng142','DDwin','ZhiFeng030','wmcasino','TYM2','ZFRT126','998bet','Dawoo','win365','JDYGaming','Aladdin99','Ole777','ZFRT167','luckybuy','Twowin','GBET','ZF138THB','Heaven','ZhiFeng266','hjccasino','khmerA2','ZFRT156','LLgaming','Mopgaming','GMASTER','N8B','skykey','infini88','Weiwei','Wcasino88','HC6YAYOU','STEBBCBI','7kplatform','Datang001','ZhiFeng040','Webet88','ZhiFeng116','ZFRT090','Kzing2','Sunriseb2b','Sky88','Peakk','MayibetCV','OXPLAY','GMDFD','Monaco','aws03','AJJCV','Betway','XTSB','MAX88','SENBKK','A1game','UNOGAMING','ANGbet','ZhiFeng147','Towin','Yintai','SunriseCV','ALPHA88','ZFRT159','YongBao','OGWLS','GoldenF','LEIHUO','Callmeboss','ZFRT186','Hejiyongle','ZhiFeng138','ZFRT158CV','txwl002','KUTECH','Vwin88','OneSports','XinliCV','TXJT','ZFRT152','mbxusdt','ZhiFeng208','568Win','SWDemo','JBO','Pay4d','Heji888','SEAL888','Rio66','mtegames','LUCKYBET','Happy1668','JUYOU','allwincity','AE88','WGAMING','Niu8gaming','ZhiFeng228','Xiaoxiang','ZhiFeng132','KZSW','PKKing','VWIN66','beplayCV','ZFRT213','OXbet','HonorW','pmwint','YiboCV','FB88','JUNBOVN','ARYA','Raisetech','AG','AKYL99','golden88','Winbox','baowang188','SAGAME88','Gaobet','X33Asia','ZFRT80GPGT','IGSW','Test0112','DF88','KSTECH2','Bigwiner','Zowin','C88bet','Hecbet','18Luck','AOGcasino','JIBET','MultiSL88','ZhiFeng122','XTDGT','KSTECH','Yunji','SM88','ABCGAME','dfbetCV','V9betSW','GAMEBee','directapi','MANBETX','TT128','Test1607','ZFRT263','ZFRT195','awc','TGXI','ZFRT166','MTechCV','NLDSports','Boma365','Wanbo','ZF133FIN2','Dade','ZhiFeng094','VKGAME','ACsports','ZhiFeng084','ZhiFeng248','AEUGSW','OkadaSW','Letian','Rakyat4DSW','NFBI','H1royal','AnvoFH','starsoccer','ZhiFeng036','De365','kgsports','oddstest','FLC','BSSB168','ZhiFeng253','ZTech','MYGAME','WINCLUB88','dghash','dghashCV','HL8','Barcelo9','Alphalota','GSCFTWCV','ZFRT115','GoToWin','ZhiFeng168','OCMSS','Mancity2','V03','24aviaCV','YSYBO688','GSCSW','Saba789','ZF215aTR','SWSite','ZFRT166SW','BWGaming','TWWIN','ZFRT144','Nexus','GB888CV','TSXJCV','SKY1688','N88','4300','SDY','JJBGAMECV','C7YOUXI','CMBSW','ZhiFeng223','ZF026','kbosports','ManCity','GLive','ZFRT155','WBG88','WLSTAR','Jiuyou','bmwbet','TaoCai','LegendWin','ECBet88','9w','HOT99','KingBet','24AVIA','BBIN3','KzingP88','DMsports','khmer','FHLMSABA','IGPTech','C7YOUXICV','ab6688','BGCV','yuanbao','TopGame','HOroyal','WABET','ZhiFeng200','Bet88CV','Titanbet','ZFRT161','RBCV','TH3','Sin88','WRServices')

	CREATE TABLE #CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))
	
	CREATE TABLE #CustBetSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustBetSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	INSERT INTO #CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType  AND BetType = @BetType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType  AND BetType = @BetType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 69

	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting_Agent)
	BEGIN	
	
		DELETE TOP (@batch) #CustBetSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #CustBetSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #CustBetSetting_AgentTemp
				
	END  
			
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #CustBetSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #CustBetSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #CustBetSetting_MemberTemp
				
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

	DROP TABLE #CustBetSetting_AgentTemp
	DROP TABLE #CustBetSetting_MemberTemp
	DROP TABLE #Dep_LicenseeProductSetting 
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
