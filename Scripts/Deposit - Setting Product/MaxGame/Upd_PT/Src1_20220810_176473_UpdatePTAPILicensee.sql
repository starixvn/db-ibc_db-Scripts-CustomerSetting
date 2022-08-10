/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220810
	Task: Update PT MaxGame for Licensee Deposit real currency RedmineID:#176473
	DB: DBCUST/CustDB
	
	P/s : Step 1 Update PT MaxGame for Licensee Deposit  real currency
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@PT SMALLMONEY
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT value
	FROM STRING_SPLIT(@CustIDs,',')
	WHERE value <> ''
	
	DECLARE @batch SMALLINT = 2500
	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (237, 5401)
	
	-- SMA LEVEL
	IF @RoleID <>1
	BEGIN
		WHILE(1 =1)
		BEGIN
			--1 turn run 2500 member safe (large line) .
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
						
			UPDATE a 
			SET a.SuperPT = CASE WHEN @RoleID = 0 AND a.CustID = @srecommend THEN @PT ELSE 0 END
				,a.MasterPT = CASE WHEN @RoleID = 0 THEN @PT ELSE 0 END
				,a.AgentPT= CASE WHEN @RoleID = 2 OR a.CustID = @srecommend  THEN @PT ELSE 0 END
			FROM dbo.Dep_CustPTSetting_Agent a WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.CustID = c.CustID
			INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
				
			--Agent Level
			IF @RoleID = 2
			BEGIN				
				UPDATE a 
				SET a.AgentPT= @PT
				FROM dbo.Dep_CustPTGroupSetting_Member a WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.AgentID = c.CustID
				INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
			END 
			
			TRUNCATE TABLE #CustListTemp
		END
	END	
	
	IF @RoleID  = 1
	BEGIN
		WHILE(1 = 1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
			--Member Level
			UPDATE a 
			SET a.AgentPT= @PT
			FROM dbo.Dep_CustPTSetting_Member a WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp c WITH(NOLOCK) ON a.CustID = c.CustID
			INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
		
			TRUNCATE TABLE #CustListTemp
		END 	
	END
	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT,isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT smallmoney = 93.00 , @Role SMALLINT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND (cs.site IN('4300', '0sServices', '12bet', '365online', '368Cash', '383sport', '3ge888', '3Star88', '5ATech', '633esports', '88Macao', '9Club', '9wtest', 'A1game', 'ab6688', 'ABcasino', 'AE88', 'AEUG', 'AG', 'Aladdin99', 'ALog', 'ALPHA88', 'Alphalota', 'ANGbet', 'AnvoFH', 'AOGcasino', 'AsiaBet88', 'B24VN', 'Barcelo9', 'beplay', 'Betway', 'BigGaming', 'Bigwiner', 'bmwbet', 'Bobo88', 'Boma365', 'Bonanza88', 'BPLE', 'BWGaming', 'CGame', 'CGame4', 'Dabet', 'Datang001', 'Dawoo', 'Dawooxin', 'DEWA', 'dj888', 'DongYing', 'e8casino', 'ECBet88', 'ECLBET', 'erhaozhan', 'F88IN1SW', 'FB88', 'GAMEBee', 'Gaobet', 'GESAB', 'GMASTER', 'GMDFD', 'GoldenF', 'GoldenF2', 'GPIgame', 'Happy1668', 'HBPT', 'Hecbet', 'Hejiyongle', 'HFYX', 'HIDZ', 'HL8', 'HonorW', 'HY6', 'iBET', 'IBO', 'ID88', 'IGPTech', 'infini88', 'INSERTGAME' , 'JBO', 'JIBET', 'Jiuyou', 'JJBGAME', 'JUNBOVN', 'JUYOU', 'Kbet', 'kgsports', 'KingBet', 'Kingfun', 'KSTECH', 'KSTECH2', 'Kzing2', 'KZSW', 'LegendWin', 'LEIHUO', 'Leng4D', 'Liga', 'LIGAWLHKB', 'LLgaming', 'loc', 'Lode88', 'MANBETX', 'ManCity', 'Mancity2', 'MAX88', 'Mayayule', 'mbxusdt', 'MICL', 'Million', 'MTech', 'Mybet88', 'MYGAME', 'n88clubSW', 'N8BK', 'Nexus', 'Niu8gaming', 'OBGM', 'OCMSS', 'Okada', 'Ole777', 'Opadmin', 'OXbet', 'PINT', 'PKbet', 'PLAYES', 'QASite', 'Rakyat4DSW', 'RICbet', 'Rio66', 'Riverich', 'ROYAL88' , 'SDYSW', 'SEAGaming', 'Senibet', 'Sin88', 'Sky88', 'SL88SW', 'SM88', 'Soon88', 'starsoccer', 'STEBBCBI', 'Sunwin', 'SWDemo', 'SWSite', 'TangChao', 'TaoCai', 'TCbet', 'TH3', 'TIC88', 'Titanbet', 'TLC', 'Towin', 'Tripleone', 'TSEnter', 'TSLA', 'Twowin', 'txwl002', 'UG2', 'ug396', 'UGaming', 'UNOGAMING', 'Uwoniwin', 'V03', 'VCBA', 'VEGA77', 'VKGAME', 'VN88', 'W88', 'WBG88', 'WBS', 'Wcasino', 'Wcasino88', 'Webet88', 'weicai', 'win365', 'WINCLUB88', 'WINHX1', 'Winsplay', 'WKCUR', 'WKPHIL', 'wmcasino', 'wmcasinoS', 'WRSeamless', 'WRServices', 'WSlots', 'X33Asia', 'Xiaojin', 'Xiaoxiang', 'Xinbo', 'XLMEDIA', 'XmenSW', 'XO88', 'XTDGT', 'YakaGaming', 'Yibo', 'Yintai', 'YongBao', 'YSYBO688', 'YYHbet', 'ZhiFeng132', 'Zowin', 'zt828', 'ZTech')
		AND ci.currency IN (2,3,4,6,12,13,15,20,45,46,51,56,61,70,72,94,96)) --RM,US$,TB,EURO,GBP,RMB,IN,UUS,Won,BND,INH,PLN,INR,MKK,MK,USDT
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		
	    UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @PT = @PT,@srecommend = @srecommend,@target = @target	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.100'
		
	END
	ELSE
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0		
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SET @PT = 93.00	
		
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend, ProductSettingID 
		FROM Dep_ProductSetting dp WITH(NOLOCK) 
		WHERE dp.ProductID = 60
			AND dp.SettingType IN (1) -- Product Status, PT, StakeLevel
			AND NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting WITH (NOLOCK) WHERE CustID = @srecommend AND ProductSettingID = dp.ProductSettingID)
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
