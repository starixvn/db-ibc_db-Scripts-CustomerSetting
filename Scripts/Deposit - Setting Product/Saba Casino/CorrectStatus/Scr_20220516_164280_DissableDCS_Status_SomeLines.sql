/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Disable Casino DCS for some lines whose supers is disableCasino = 1 [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @target VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)

	DECLARE @BitOrder INT
	DECLARE @BatchSize SMALLINT = 5000
	DECLARE @SportType SMALLINT = 208, @BetType SMALLINT = 2101

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype AND Bettype = @BetType

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend
	AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #tmpCust(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)


	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)		
	
	--------------------------------------------Disable Status--------------------------------------------------
	--> SMA
	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsDisabled,@BitOrder)) isDisabled
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsHidden,@BitOrder)) isHidden
	WHERE NOT(isDisabled.value = 1 AND isHidden.value = 0)

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
		,c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #Dep_CustProductStatus tmp ON c.CustID = tmp.CustID

	TRUNCATE TABLE #Dep_CustProductStatus

	--> Member
	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsDisabled,@BitOrder)) isDisabled
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsHidden,@BitOrder)) isHidden
	WHERE NOT(isDisabled.value = 1 AND isHidden.value = 0)

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 
		WHERE a.isfinished = 0
		
		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
END
GO
-- BEGIN STEP 2: Run this SP at replicated DB: DB06, DBTP, DBCUST-----
SET NOCOUNT ON
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
CREATE TABLE #supers (custid int, isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM Dep_CustProductStatus cps WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = cps.CustID
    CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (cps.bitmapIsDisabled,31)) isDisabled
    CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (cps.bitmapIsHidden,31)) isHidden
WHERE isDisabled.value = 1 
	AND isHidden.value =0
    AND ci.roleid = 4

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg_batch nvarchar(200) = 'SuperID: %d, MinCustID: %d, MaxCustID: %d.'

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

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@target = @target

	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF