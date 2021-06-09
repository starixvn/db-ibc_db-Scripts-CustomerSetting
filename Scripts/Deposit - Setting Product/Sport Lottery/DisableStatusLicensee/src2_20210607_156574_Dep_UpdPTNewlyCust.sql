/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210607
	Task: Disable status for newly created customer Licensee Deposit Sports Lottery  RedmineID:#156574
	DB: DBCUST/CustDB
	
	P/s : Step 2 Delete redundant and add new setting newly created customer
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN

	DECLARE @batch int = 3000,@BitOrder INT

	CREATE TABLE #supers (custid INT PRIMARY KEY)
	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (169, 3611)
		
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN ('24AVIASL','24TECH','568WinSW','9w','9wickets','9Wsports','afb99','AMG','Aplus','Apollo','Asian88','Athena000','awc','awc2','Axiawin','bdtt2','BetDeal','Bodog','BoinGroup','BOSSB','Brown888','BSSB168','Dachen','Dade','Datang','ENT22','ENTAPLAY','FLC','G2Win','Gameroom','GGBOOKES','Happy8','HCVIP','HeleThai','Hengcai88','HJTK','HONBET','Hong88','HongChow','HOT88','IBG','ig128','ig128s','IgameTech','ISC888','J9YAYOU','Jarvis','JIB88','JIDU','Jinyazhou','Jumbo88','Junbet','K8VN','khmer','khmerA2','KhmerG','Kraton','KUTECH','Lagadewa','liv66SW','livv88sw','LS88','Luckywin88','Man1878','mansion88','MayFair','Mbet','MFgame','Monstergol','MRCATSB','NBCbet','Newhonbet','NextBet','NukeGaming','Opal88','PanguGame','Pay4d','PKKing','Ratugg','SAGAME88','Saibo','Salon365','sbt88','Siamgame','SSSGaming','Starnet','Storm88','Sun988','SunGame','Sunrise','Swin','Taipanbet','tcycyl','TGame','THECLUB','TitanCraft','TitanOne','ug396','UwinY','VWIN66','Wanfang','webet88','Weiwei','Win68Club','Win88','Winn69','WUYICP','X2Dynamic','XinYo','XTD3','YAYOU','YBTech','ZFRT080','ZFRT115','ZFRT128','ZhiFeng037','Zzun88','12B','368CashSW','369588vip','7Konline','7Kplatfrom','88Goals','998bet','9wtest','Apollo369','ARYA','Asia999','BananaTech','BB3','BBIN4','Bigwiner','BoAPI09','BoAPI10','BoAPI11','Cali','CENTRAL168','d3sports','Dabet','dabo88','directapi','DTGW','EasywinSW','GOATbet','GoToWin','GPgaming88','GSCSW','Heji888','Hongtubet','HY6','IGSW','iuplay1','iuplay2','IvoryBet','JGQP8','Kbet','KingBet','Lefu','LegendWin','LLGAME','LLgaming','M88ASIA','Mancity2','MSbet','NEWBALL','Newbet','Nova88','OBline','OkadaSW','Omni88','Opadmin','QASite','RICbet','Sabademo','SampleSite','SampleTest','SBObet','skykey','SM88','starsoccer','Sunbet138','Tesla','THEDEN','TIC88','TXG','UG2','UN168','UNOGAMING','VEGA77','Vwin88','WB101','WBG88','WGAMING','Winsplay','WKIBPH','XINSHNEG','XO88','Yabo3','ZFRT129','ZFRT144','ZhiFeng076')
	ORDER BY ci.custid 	
		
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	SELECT @BitOrder= a.bitmapOrder 
	FROM Dep_ProductStatusProfile a WITH(NOLOCK) 
	INNER JOIN @SportBetType b ON a.Sporttype = b.SportType AND a.Bettype = b.BetType

	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend)
	SELECT a.custid, a.roleid,a.mrecommend
	FROM Custinfo a WITH (NOLOCK)
	INNER JOIN #supers b ON a.srecommend = b.custid
	WHERE a.roleid IN (2,3,4) AND a.Enabled = 1 AND a.custid > @maxcustID 
	AND a.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend)
	SELECT a.custid, a.mrecommend
	FROM Custinfo a WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND a.roleid = 1  AND a.Enabled = 1 AND a.custid > @maxcustID	
	AND a.mrecommend NOT IN (SELECT custid FROM #Dummy)
	------------------------------------Status Setting-------------------------------------------------	
	
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsDisabled binary(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid
	
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
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	
END		
GO
-- END STEP 2.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2.2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
