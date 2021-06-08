/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210607
	Task: Disable status for Licensee Deposit Sports Lottery RedmineID:#156574
	DB: DBCUST/CustDB
	
	P/s : Step 1 Disable status sport book for Licensee Deposit Sports Lottery
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@BitOrder INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT val
	FROM dbo.strSplit(@CustIDs,',')
	
	DECLARE @batch SMALLINT = 2500
	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (169, 3611)
	
	
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #CustList temp ON temp.CustID = c.custid

	WHILE (1 = 1) 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,1)) AS bitmapIsDisabled
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0))  AS bitmapIsHidden
	FROM #CustList A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY,isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT , @Role SMALLINT = 0 ,@BitOrder INT , @SportType SMALLINT = 169
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN ('24AVIASL','24TECH','568WinSW','9w','9wickets','9Wsports','afb99','AMG','Aplus','Apollo','Asian88','Athena000','awc','awc2','Axiawin','bdtt2','BetDeal','Bodog','BoinGroup','BOSSB','Brown888','BSSB168','Dachen','Dade','Datang','ENT22','ENTAPLAY','FLC','G2Win','Gameroom','GGBOOKES','Happy8','HCVIP','HeleThai','Hengcai88','HJTK','HONBET','Hong88','HongChow','HOT88','IBG','ig128','ig128s','IgameTech','ISC888','J9YAYOU','Jarvis','JIB88','JIDU','Jinyazhou','Jumbo88','Junbet','K8VN','khmer','khmerA2','KhmerG','Kraton','KUTECH','Lagadewa','liv66SW','livv88sw','LS88','Luckywin88','Man1878','mansion88','MayFair','Mbet','MFgame','Monstergol','MRCATSB','NBCbet','Newhonbet','NextBet','NukeGaming','Opal88','PanguGame','Pay4d','PKKing','Ratugg','SAGAME88','Saibo','Salon365','sbt88','Siamgame','SSSGaming','Starnet','Storm88','Sun988','SunGame','Sunrise','Swin','Taipanbet','tcycyl','TGame','THECLUB','TitanCraft','TitanOne','ug396','UwinY','VWIN66','Wanfang','webet88','Weiwei','Win68Club','Win88','Winn69','WUYICP','X2Dynamic','XinYo','XTD3','YAYOU','YBTech','ZFRT080','ZFRT115','ZFRT128','ZhiFeng037','Zzun88','12B','368CashSW','369588vip','7Konline','7Kplatfrom','88Goals','998bet','9wtest','Apollo369','ARYA','Asia999','BananaTech','BB3','BBIN4','Bigwiner','BoAPI09','BoAPI10','BoAPI11','Cali','CENTRAL168','d3sports','Dabet','dabo88','directapi','DTGW','EasywinSW','FHLMSABA','GOATbet','GoToWin','GPgaming88','GSCSW','Heji888','Hongtubet','HY6','IGSW','iuplay1','iuplay2','IvoryBet','JGQP8','Kbet','KingBet','Lefu','LegendWin','LLGAME','LLgaming','M88ASIA','Mancity2','MSbet','NEWBALL','Newbet','Nova88','OBline','OkadaSW','Omni88','Opadmin','QASite','RICbet','Sabademo','SampleSite','SampleTest','SBObet','skykey','SM88','starsoccer','Sunbet138','Tesla','THEDEN','TIC88','TXG','UG2','UN168','UNOGAMING','VEGA77','Vwin88','WB101','WBG88','WGAMING','Winsplay','WKIBPH','XINSHNEG','XO88','Yabo3','ZFRT069','ZFRT124','ZFRT125MGT','ZFRT127','ZFRT129','ZFRT143','ZFRT144','ZFRT155','ZFRT156','ZFRT80GPGT','ZhiFeng030','ZhiFeng046','ZhiFeng051','ZhiFeng076','ZhiFeng106')
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

SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType=@Sporttype

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
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
		
	END
	ELSE
	BEGIN
		-- WAITFOR DELAY 5000 member 1 turn
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

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role,@BitOrder = @BitOrder,@srecommend = @srecommend,@target = 'REPLICATED' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -----
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE NONCLUSTERED INDEX ix_tmpCust ON #tmpCust(srecommend,isfinished )
CREATE NONCLUSTERED INDEX ix_tmpSMA ON #tmpSMA(srecommend,RoleID,isfinished )

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT , @Role SMALLINT = 0,@BitOrder INT , @SportType SMALLINT = 169
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN ('24AVIASL','24TECH','568WinSW','9w','9wickets','9Wsports','afb99','AMG','Aplus','Apollo','Asian88','Athena000','awc','awc2','Axiawin','bdtt2','BetDeal','Bodog','BoinGroup','BOSSB','Brown888','BSSB168','Dachen','Dade','Datang','ENT22','ENTAPLAY','FLC','G2Win','Gameroom','GGBOOKES','Happy8','HCVIP','HeleThai','Hengcai88','HJTK','HONBET','Hong88','HongChow','HOT88','IBG','ig128','ig128s','IgameTech','ISC888','J9YAYOU','Jarvis','JIB88','JIDU','Jinyazhou','Jumbo88','Junbet','K8VN','khmer','khmerA2','KhmerG','Kraton','KUTECH','Lagadewa','liv66SW','livv88sw','LS88','Luckywin88','Man1878','mansion88','MayFair','Mbet','MFgame','Monstergol','MRCATSB','NBCbet','Newhonbet','NextBet','NukeGaming','Opal88','PanguGame','Pay4d','PKKing','Ratugg','SAGAME88','Saibo','Salon365','sbt88','Siamgame','SSSGaming','Starnet','Storm88','Sun988','SunGame','Sunrise','Swin','Taipanbet','tcycyl','TGame','THECLUB','TitanCraft','TitanOne','ug396','UwinY','VWIN66','Wanfang','webet88','Weiwei','Win68Club','Win88','Winn69','WUYICP','X2Dynamic','XinYo','XTD3','YAYOU','YBTech','ZFRT080','ZFRT115','ZFRT128','ZhiFeng037','Zzun88','12B','368CashSW','369588vip','7Konline','7Kplatfrom','88Goals','998bet','9wtest','Apollo369','ARYA','Asia999','BananaTech','BB3','BBIN4','Bigwiner','BoAPI09','BoAPI10','BoAPI11','Cali','CENTRAL168','d3sports','Dabet','dabo88','directapi','DTGW','EasywinSW','FHLMSABA','GOATbet','GoToWin','GPgaming88','GSCSW','Heji888','Hongtubet','HY6','IGSW','iuplay1','iuplay2','IvoryBet','JGQP8','Kbet','KingBet','Lefu','LegendWin','LLGAME','LLgaming','M88ASIA','Mancity2','MSbet','NEWBALL','Newbet','Nova88','OBline','OkadaSW','Omni88','Opadmin','QASite','RICbet','Sabademo','SampleSite','SampleTest','SBObet','skykey','SM88','starsoccer','Sunbet138','Tesla','THEDEN','TIC88','TXG','UG2','UN168','UNOGAMING','VEGA77','Vwin88','WB101','WBG88','WGAMING','Winsplay','WKIBPH','XINSHNEG','XO88','Yabo3','ZFRT069','ZFRT124','ZFRT125MGT','ZFRT127','ZFRT129','ZFRT143','ZFRT144','ZFRT155','ZFRT156','ZFRT80GPGT','ZhiFeng030','ZhiFeng046','ZhiFeng051','ZhiFeng076','ZhiFeng106')
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

SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType=@Sporttype

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
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

	END
	ELSE
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

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role,@BitOrder = @BitOrder,@srecommend = @srecommend,@target = 'DBCUST' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
