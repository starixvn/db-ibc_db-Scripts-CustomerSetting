/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220808
	Task: Delete redundant and copy new setting newly created customer [12Bet BDT] RedmineID:#176234
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete redundant and copy new setting newly created customer [12Bet BDT] 
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running

	USE CustDB
	GO

	DECLARE @MaxCustID INT = xxx	

	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT)
	CREATE TABLE #Dep_CustDiscountSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))

	DECLARE @batch INT = 3000
	DECLARE @BitOrder INT 
	DECLARE @SportType SMALLINT = 221
	DECLARE @betType SMALLINT = 8001

	SELECT @BitOrder= st.bitmapOrder 
	FROM Dep_ProductStatusProfile st WITH(NOLOCK) 
	WHERE SportType=@Sporttype AND Bettype = @betType

	CREATE TABLE #supers (custid INT)
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND (cs.site IN('12Bet') AND ci.currency IN (97)) --BDT

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend,Currency)
	SELECT custid, roleid,mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	--DELETE existing data
	------------------------------------Comm Setting-------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustDiscountSetting_Agent
	FROM Dep_CustDiscountSetting_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE SportType =@sportType AND BetType = @BetType

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustDiscountSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustDiscountSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustDiscountSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustDiscountSetting_AgentTemp
	END
	--Update existing data
	------------------------------------Comm Setting-------------------------------------------------
	--SMA Level
	INSERT INTO dbo.Dep_CustDiscountSetting_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[Discount]
			)
	SELECT 
			a.CustID
			,@SportType
			,@BetType
			,0.03 AS Discount
	FROM #SMATemp a WITH(NOLOCK)
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustDiscountSetting_Agent D WITH(NOLOCK) 
				WHERE CustID=a.CustID AND SportType = @SportType AND BetType = @betType)
	
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	WHILE 1 = 1 
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
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled)
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden)
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	DROP TABLE #MemberTemp 
	DROP TABLE #SMATemp    
	DROP TABLE #MemberBatch
	DROP TABLE #SMABatch   
	DROP TABLE #Dep_CustDiscountSetting_AgentTemp   
	DROP TABLE #AllUsers 
	DROP TABLE #Dep_CustProductStatus 
	DROP TABLE #TempProductStatus 