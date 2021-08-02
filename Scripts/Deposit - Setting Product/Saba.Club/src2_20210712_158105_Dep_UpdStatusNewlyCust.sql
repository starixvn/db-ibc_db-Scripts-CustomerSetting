/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210712
	Task: Disable status for newly created customer Licensee Deposit saba.Club  RedmineID:#158105
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
	INSERT INTO @SportBetType(SportType, BetType) VALUES (200, 1611)
		
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
		AND cs.site IN ('11bet','12Bet','24AVIA','365online','368Cash','396Club','88Macao','9Club','9wickets','A1game','ab6688','Abcasino','Ae88','AEUG','alog','ALPHA88','asiabet88','Athena000','B24VN','Barcelo9','BBIN2','BBIN3','bdtt','BigGaming','Bobo88','BOG22','Boma365','Comebet','Datang','Dawoo','DBP','Debet','DEWA','ECLBET','erhaozhan','Fabet','FB88','Five88','GamingSoft','GGBOOK','GGBOOKES','GMASTER','GPIGAME','haifa','Hecbet','HL8','iBET','IBO','ig128','IGPTech','INSERTGAME','IONclub','ISC888','Junbet','KeenOcean','KOKVN','loc','Lode88','Lucky88','mansion88','MARS','Monaco','MTech','N88','N8B','N8G','Nbet','NextBet','OCMS','One88','Onegaming','OXbet','Red88','Saba789','Sin88','Sky88','spondemo','Sunwin','SV88','Tripleone','V03','VN88','W88','win365','WKCUR','WKPHIL','wmcasino','XTDGT','Xtu168','YongBao','Zbet','Zowin','zt828','Aonslot','BananaTech','Bigwiner','iuplay1','Jiuyou','K8VN','LegendWin','LLgaming','MSbet','OBGM','OBline','RICbet','TH3','Towin','XO88')
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
