/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220425
	Task: Adjust Setting betlimit for [Leap Gaming Virtual Sports 3] - deposit API Licensees RedmineID:#171868
	DB: DBCUST/CustDB
	
	P/s : Step 4 Adjust Setting betlimit for
*/
-- BEGIN STEP 4.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
	   )
		RETURN
	
	DECLARE	  @fSportType SMALLINT	= 180
			, @fBetType SMALLINT	= 1201
			, @tSportType SMALLINT	= 231
			, @tBetType SMALLINT	= 5301
	CREATE TABLE #Super_adjust (custid INT PRIMARY KEY)
	INSERT INTO #Super_adjust(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','11bet','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','Saba789','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688','SampleSite')  
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
	----------------------------------------Bet Setting-------------------------------------------------	
	SELECT f.CustID, (CASE 
					WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
					WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) AS MinBet, 
					( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
					) AS MaxBet
	INTO #CustBetSetting_Agent
	FROM dbo.Dep_CustBetSetting_Agent f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_ProductBetSetting d WITH(NOLOCK) ON c.Currency = d.Currency AND d.Sporttype = @tSportType AND d.Bettype = @tBetType
		INNER JOIN Dep_CustBetSetting_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   t.MinBet		<> (CASE 
							WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
							WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)			
		OR t.MaxBet		<> ( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							)		
		)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)
	
	SELECT f.CustID, (CASE 
					WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
					WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) AS MinBet, 
					( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							) AS MaxBet
	INTO #CustBetSetting_Member
	FROM dbo.Dep_CustBetSetting_Member f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_ProductBetSetting d WITH(NOLOCK) ON c.Currency = d.Currency AND d.Sporttype = @tSportType AND d.Bettype = @tBetType
		INNER JOIN Dep_CustBetSetting_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   t.MinBet		<> (CASE 
							WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
							WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)			
		OR t.MaxBet		<> ( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							)		
		)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member
END
GO
-- END STEP 4.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 4.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

-- BEGIN STEP 4.3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'