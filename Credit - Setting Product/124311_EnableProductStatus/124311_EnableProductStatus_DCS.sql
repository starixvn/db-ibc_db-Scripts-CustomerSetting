/*
	Created: Tiara	
	Task: Enable Product Status for all disabled customers under 789y Headline- DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191219
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT,
	@BitmapOrder TINYINT,
	@maxcustid INT,
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   AND dbo.f_CheckRepTable ('customer') = 1
	   )
		RETURN
/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	
	SELECT custid, ci.roleid
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend  = @Custid AND ci.custid <= @maxcustid
				
	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled =  (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 						
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @Custid INT, @max_custid INT, @BitmapOrder TINYINT

SELECT @max_custid = xxx

CREATE TABLE #ProductID
(
	Productid INT
)

INSERT INTO #ProductID(Productid) 
	SELECT 5 UNION ALL
    SELECT 21 UNION ALL
	SELECT 22 UNION ALL
	SELECT 24 UNION ALL
	SELECT 28 UNION ALL
	SELECT 23
	
CREATE TABLE #SportBettypeFilterStatus
(
	Productid INT,
	SportType INT,
	Bettype INT
)

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,13) AS F

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,11) AS F

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20	
			
CREATE TABLE #DisableLine
(
	CustID INT,
	BitmapOrder TINYINT,
	isfinished bit default(0)
)

INSERT INTO #DisableLine (CustID, BitmapOrder)
SELECT DISTINCT C.srecommend, P.bitmapOrder
FROM custInfo C WITH (NOLOCK) 
	INNER JOIN #supers S ON C.srecommend = S.custid
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE  isDisabled.value = 1 --ProductStatus is disabled
	AND C.Enabled = 1 
	

-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, Disabled Customer: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Disabled Customers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #DisableLine )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT


--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #DisableLine
	SET isfinished = 1
		,@Custid = custid
		,@BitmapOrder = bitmapOrder	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @Custid, @BitmapOrder = @BitmapOrder, @maxcustid = @max_custid
			,@target = 'REPLICATED'			
	waitfor delay '00:00:0.280'
END
--Drop all temp tables
DROP TABLE #ProductID
DROP TABLE #SportBettypeFilterStatus
DROP TABLE #supers
DROP TABLE #DisableLine

GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @Custid INT, @max_custid INT, @BitmapOrder TINYINT

SELECT @max_custid = xxx

CREATE TABLE #ProductID
(
	Productid INT
)

INSERT INTO #ProductID(Productid) 
	SELECT 5 UNION ALL
    SELECT 21 UNION ALL
	SELECT 22 UNION ALL
	SELECT 24 UNION ALL
	SELECT 28 UNION ALL
	SELECT 23
	
CREATE TABLE #SportBettypeFilterStatus
(
	Productid INT,
	SportType INT,
	Bettype INT
)

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,13) AS F

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,11) AS F


CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20

CREATE TABLE #DisableLine
(
	CustID INT,
	BitmapOrder TINYINT,
	isfinished bit default(0)
)
--Get list of supers who have disabled status or disabled downlines
INSERT INTO #DisableLine (CustID, BitmapOrder)
SELECT DISTINCT C.srecommend, P.bitmapOrder
FROM custInfo C WITH (NOLOCK) 
	INNER JOIN #supers S ON C.srecommend = S.custid
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE  isDisabled.value = 1 --ProductStatus is disabled
	AND C.Enabled = 1 

-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, Super: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Disabled Customers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #DisableLine )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT


--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #DisableLine
	SET isfinished = 1
		,@Custid = custid
		,@BitmapOrder = bitmapOrder	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @Custid, @BitmapOrder = @BitmapOrder, @maxcustid = @max_custid
			,@target = 'REPLICATED'			
	waitfor delay '00:00:0.280'
END

--Drop all temp tables
DROP TABLE #ProductID
DROP TABLE #SportBettypeFilterStatus
DROP TABLE #supers
DROP TABLE #DisableLine

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
GO