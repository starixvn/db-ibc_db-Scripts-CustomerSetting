/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - Existing Customers Status - [redmine: #198008]
	DB: DBCUST/CUSTDB and all replicated servers
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_19]
	@CustList VARCHAR(MAX) --JsonData
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT dbo.f_CheckRepTable('Dep_CustProductStatus') = 1
		RETURN
	
	--parse JsonData
	--SELECT *
	--FROM OPENJSON(@CustList) 
	--WITH (  CustID			INT		'$.CustID',
	--		bitmapIsHidden	BINARY(32)	'$.bitmapIsHidden',
	--		bitmapIsDisabled BINARY(32)	'$.bitmapIsDisabled'
	--	) AS js

	UPDATE cs
	SET	cs.bitmapIsHidden = js.bitmapIsHidden,
		cs.bitmapIsDisabled = js.bitmapIsDisabled
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN OPENJSON(@CustList) 
	WITH (  CustID			INT		'$.CustID',
			bitmapIsHidden	BINARY(32)	'$.bitmapIsHidden',
			bitmapIsDisabled BINARY(32)	'$.bitmapIsDisabled'
		) AS js
	ON cs.CustID = js.CustID
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'REMOVE STATUS: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @max_custid INT
		,@CustList  VARCHAR(MAX)
		,@BatchSize	INT = 3000
		,@SuperID	INT

SELECT @max_custid = xxx

---------------------------------------------------------------------------------------------
--Get supers
CREATE TABLE #Supers (CustID INT PRIMARY KEY)

INSERT INTO #Supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 --offered product
						AND p.ProductID IN (5,27,77,49) 
						AND p.ProductSettingID NOT BETWEEN 182 AND 185 --New VS setting
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE cs.custid <= @max_custid

---------------------------------------------------------------------------------------------
CREATE TABLE #tblDep_CustProductStatus
	(
		CustID	     INT PRIMARY KEY
	   , bitmapIsHidden   BINARY(32)
	   , bitmapIsDisabled BINARY(32)
	)

CREATE TABLE #tblDep_CustProductStatus_batch
	(
		CustID	     INT
	   , bitmapIsHidden   BINARY(32)
	   , bitmapIsDisabled BINARY(32)
	)

---------------------------------------------------------------------------------------------
--Get bitmapOrder
CREATE TABLE #bitmapOrder (bitmap INT)

INSERT INTO #bitmapOrder(bitmap)
SELECT bitmapOrder
FROM Dep_ProductStatusProfile WITH (NOLOCK)
WHERE Sporttype IN (180,190,178,231)	--VS123, VS3 (old)
	
DECLARE @xmlStrHidden XML
	
SET @xmlStrHidden = (
			SELECT DISTINCT
				bitmap AS '@b', 
				1 AS '@s'
			FROM #bitmapOrder vh 
			FOR XML PATH ('r'), ROOT ('root')
			)

---------------------------------------------------------------------------------------------
DECLARE @__messageInfo VARCHAR(200)

--loop delete by batch
WHILE 1 = 1
BEGIN
	-- Pick top 1 Super to run all line
	SELECT @SuperID = NULL

	SELECT @SuperID = (SELECT TOP 1 CustID FROM #Supers)

	IF @SuperID IS NULL
		BREAK;

	DELETE FROM #Supers WHERE CustID = @SuperID

	INSERT INTO #tblDep_CustProductStatus (CustID, bitmapIsHidden, bitmapIsDisabled)
	SELECT cs.CustID,
		bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrHidden))),
		bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrHidden)))
	FROM Dep_CustProductStatus cs WITH (NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid = cs.CustID
	WHERE ci.Enabled = 1
		AND ci.srecommend = @SuperID
		AND ci.custid <= @max_custid

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #tblDep_CustProductStatus_batch
			
		DELETE TOP (@BatchSize) cps
		OUTPUT deleted.CustID, deleted.bitmapIsHidden, deleted.bitmapIsDisabled
			INTO #tblDep_CustProductStatus_batch (CustID, bitmapIsHidden, bitmapIsDisabled)
		FROM #tblDep_CustProductStatus cps

		IF @@ROWCOUNT = 0
			BREAK;

		SELECT @CustList = --parse JsonData
					(
						SELECT ca.CustID, ca.bitmapIsHidden, ca.bitmapIsDisabled
						FROM #tblDep_CustProductStatus_batch ca
						FOR JSON PATH
					)

		EXEC dbo.[Acc_Dep_DynamicCustSetting_19] 
					@CustList=@CustList,
					@target = @target
	END

	WAITFOR DELAY '00:00:00:280'
	SET @__messageInfo = 'SuperID: ' + CAST(@SuperID AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
END

DROP TABLE #Supers, #bitmapOrder, #tblDep_CustProductStatus, #tblDep_CustProductStatus_batch

PRINT N'--------------------------------------------------------'
PRINT N'REMOVE STATUS: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
