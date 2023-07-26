/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230712
	Task: Delete existing data of Virtual Sports 3 Deposit - Real currencies [Redmine: #190952]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP AT DBCUST --------
------------------------------------------------------
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
	IF dbo.f_CheckRepTable('Dep_ProductBetSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
		INNER JOIN Dep_CustPTSetting_Agent a WITH (NOLOCK) ON ci.custid = a.CustID
		CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, 33) f		--VS3(Old) Status
		CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled	= 1
		AND cs.site IN ('12Bet','18Luck','24AVIA','365online','383sport','3ge888','3star88','633esports','7kplatform','88Macao','9bet','9Club','9w','A1game','ab6688','Abcasino','ACsports','Ae88','AEUG','AKYL99','Aladdin99','allwincity','alog','Alphalota','AnvoFH','Aoncash','B24VN','Baji','Barcelo9','BBIN2','BBIN3','bdtt','BE7','beplay','BigGaming','Bigwiner','bmwbet','Bobo88','Bolanation','Bonanza88','BPLE','C7YOUXI','C88bet','Callmeboss','CCLive','CGame','Dade','dafd','Dawoo','Dawooxin','DBP','DCSDemo','DDwin','DEWA','DFGame','Diamond','DingTai','DMsports','DTGJZ','e8casino','ECBet88','ECLBET','erhaozhan','FB88','FHLMSABA','G4ALL','GAMEBee','GamingSoft','Gampag','Gaobet','GESAB','haifa','HBPT','HC6YAYOU','Heaven','Hecbet','HFYX','HIDZ','hjccasino','HL8','HOT99','HuangMa','HY6','iBET','IBO','ig128','infini88','INSERTGAME','IONclub','ITCbet','JDJDAPI','JIBET','Jiuyou','JJBGAME','JUYOU','kbosports','KingBet','KUTECH','LegendWin','Leng4D','LIGAWLHKB','LLgaming','loc','Lode88','LUCKYBET','M8bola','M8Credit','Macaubet','ManCity','Mancity2','Mayayule','Mayibet','mbxusdt','MICL','Monaco','Mopgaming','MTech','MYGAME','N88','N8B','N8BK','N8G','NewFuture','OBGM','OBsystem','OCMS','OESports','OPEBET','Ot88','OYO','PLAYES','pmwint','Q8bola','Raisetech','Rio66','Saba789','SampleSite','ScaleDemo1','ScaleDemo2','SDY','sea168','SGM88','SKY1688','skykey','Soon88','starsoccer','STEBBCBI','Sunriseb2b','Sunwin','SWSite','TangChao','TaoCai','TCbet','Tesla','TGAA0813','Titanbet','TopGame','Towin','Tripleone','TSLA','TT128','TXJT','txwl002','TYgaming','TYM2','US8YAYOU','Uwoniwin','VCBA','VEGA77','VKGAME','vnggame','VWIN66','WABET','Wanbo','Wanfang','WBG88','Wcasino','Wcasino88','webet88','win365','Winbox','WINCLUB88','WINHX1','WKCUR','WKPHIL','WLSTAR','wmcasino','WRServices','Xiaojin','Xinbo','XTSB','Yibo','Yintai','YongBao','YSYBO688','Yunji','YYHbet','ZF026','ZF055PMW','ZF133FIN2','ZF138THB','ZF138USD','ZF138VND','ZF215aTR','ZFRT090','ZFRT126','ZFRT132','ZFRT144','ZFRT155new','ZFRT156','ZFRT159','ZFRT161','ZFRT165','ZFRT166','ZFRT179','ZFRT195','ZFRT213','ZFRT218','ZFRT219','ZFRT263','ZFRT264','ZFRT276','ZFRT282','ZFRT80GPGT','ZhiFeng009','ZhiFeng012','ZhiFeng013','ZhiFeng021','ZhiFeng030','ZhiFeng032','ZhiFeng035','ZhiFeng036','ZhiFeng040','ZhiFeng041','ZhiFeng051','ZhiFeng138','ZhiFeng147','ZhiFeng183','ZhiFeng221','ZhiFeng222','ZhiFeng228','ZhiFeng253','ZhiFeng267','ZhiFeng271','ZhiFeng303','Zowin','zt828','ZTech')
		AND a.Sporttype = 190 AND a.Bettype = 2701									--VS2 PT		
		AND ps.Sporttype = 178 AND ps.Bettype = 5302 AND ps.Currency = ci.currency
		AND f.value = 0

	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT, ProductSettingID INT, PRIMARY KEY(CustID, ProductSettingID))

	INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid, s.SportType, s.BetType, s.IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID, s.Sporttype, s.Bettype, s.IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.AgentID, s.SportType, s.BetType, s.IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT s.CustID, s.SportType, s.BetType 
	FROM Dep_CustBetSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT s.CustID, s.SportType, s.BetType 
	FROM Dep_CustBetSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_LicenseeProductSetting(CustID, ProductSettingID)
	SELECT s.CustID, s.ProductSettingID
	FROM Dep_LicenseeProductSetting s WITH(NOLOCK)
		INNER JOIN #supers sp WITH (NOLOCK) ON s.CustID = sp.custid
		INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON s.ProductSettingID = p.ProductSettingID
	WHERE p.ProductID = 77

	IF EXISTS(SELECT 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg WITH(ROWLOCK,UPDLOCK) 	
			INNER JOIN #Dep_CustPTSetting_Agent t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END	
	
	IF EXISTS(SELECT 1 FROM #Dep_CustPTSetting_Member)
	BEGIN					
		DELETE cg
		FROM Dep_CustPTSetting_Member cg WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_CustPTSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)		
	END  
	
	IF EXISTS(SELECT 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK,UPDLOCK) 
			INNER JOIN #Dep_CustPTGroupSetting_Member t 
				ON cg.AgentID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END 		
			
	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
		DELETE cg
		FROM Dep_CustBetSetting_Agent cg WITH(ROWLOCK,UPDLOCK)
			INNER  JOIN #Dep_CustBetSetting_Agent t
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 		
	END 

	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE cg
		FROM Dep_CustBetSetting_Member cg WITH(ROWLOCK,UPDLOCK)	
			INNER JOIN #Dep_CustBetSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 	
		OPTION(MAXDOP 1)		
	END	

	IF EXISTS(SELECT 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE a
		FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID
	END

	DROP TABLE #Dep_CustBetSetting_Agent,
				#Dep_CustBetSetting_Member,
				#Dep_CustPTGroupSetting_Member,
				#Dep_CustPTSetting_Agent,
				#Dep_CustPTSetting_Member,
				#Dep_LicenseeProductSetting,
				#supers
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST & ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

DECLARE @target NVARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

EXEC Acc_Dep_DynamicCustSetting_09 @target = @target

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
-- END STEP 2: RUN THIS SCRIPT AT DBCUST & ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
