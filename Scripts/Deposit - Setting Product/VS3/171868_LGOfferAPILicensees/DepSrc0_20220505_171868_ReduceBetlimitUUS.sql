/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220505
	Task: Update Min - Max bet for Leap Gaming Virtual Sports 3 - Deposit All Api Licensees [Redmine: 171868]
	DB: DBCUST/CustDB
	
	P/s : Step 0 Reduce min bet for Leap Gaming Virtual Sports 3 - Deposit All Api Licensees 
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
	   )
		RETURN
	
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	DECLARE @batch SMALLINT = 5000
		
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID INTO #tmpSMATemp(CustID,RoleID)
		FROM #tmpSMA c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE 15 END,
			 cs.MaxBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet  ELSE 150 END
		FROM Dep_CustBetSetting_Agent cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #tmpSMATemp t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
		
		TRUNCATE TABLE #tmpSMATemp
	END
		
	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE 15 END,
			 cs.MaxBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet  ELSE 150 END
		FROM Dep_CustBetSetting_Member cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustTemp t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
					
		TRUNCATE TABLE #tmpCustTemp
	END 	

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
END
GO
-- END STEP 2.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1
	AND cs.site IN ('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688')  
	AND ci.currency in (20)  -- UUS	  
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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----