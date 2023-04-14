/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: DisableKeno if yes [Redmine: #179711]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @CustIDs VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN
	

	/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	DECLARE @BitmapOrder_KN TINYINT = 40
	DECLARE @BatchNum INT = 5000

	CREATE TABLE #CustTemp(CustID INT, Isfinished BIT default 0)
	CREATE TABLE #CustTempBatch(CustID INT)

	INSERT INTO #CustTemp(CustID)
	SELECT value
	FROM STRING_SPLIT(@CustIDs,',')
	WHERE CONVERT(int,value) > 0

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		UPDATE TOP (@BatchNum)  t 
		SET t.IsFinished = 1 
		OUTPUT DELETED.CustID INTO #CustTempBatch(CustID) 
		FROM #CustTemp t 
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET bitmapIsDisabled = dis.NewBitmap
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch ci WITH(NOLOCK) ON cs.CustID = ci.CustID
			CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder_KN,1) as Dis

	END
	
	DROP TABLE #CustTemp
	DROP TABLE #CustTempBatch

END
GO
---------------run sp execrep to disable Keno if yes----------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

CREATE TABLE #supers (custid int PRIMARY KEY)
CREATE TABLE #CustTmp_DisabledKeno (custid int)
CREATE TABLE #CustTmp_Batch (custid int)
DECLARE @Batch INT = 50000
DECLARE @CustIDs VARCHAR(MAX) = ''

INSERT INTO #supers(custid)
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custinfo C WITH(NOLOCK)
		ON c.CustID = ci.custid 
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.Site<>'CN88'
		AND ci.currency NOT IN (20,72)
		AND c.Enabled = 1
		AND c.HideKeno = 0

INSERT INTO #CustTmp_DisabledKeno(custid)
SELECT c.CustID
FROM CustGameType c WITH(NOLOCK)
	INNER JOIN custinfo Ci WITH(NOLOCK)
		ON c.CustID = ci.custid 
WHERE c.GameTypeID = 1 
	AND c.IsDisabled = 1
	AND ci.Enabled = 1
	AND ci.HideKeno = 0
	AND ci.srecommend IN( SELECT custid FROM #supers)

WHILE (1=1)
BEGIN
	SELECT @CustIDs = ''
	TRUNCATE TABLE #CustTmp_Batch

	DELETE TOP (@Batch) t 
	OUTPUT DELETED.CustID INTO #CustTmp_Batch(CustID) 
	FROM #CustTmp_DisabledKeno t 

	IF @@ROWCOUNT=0
		BREAK

	SELECT @CustIDs = @CustIDs + CONVERT(VARCHAR(MAX),',' + CONVERT(VARCHAR(15),c.custid))
	FROM #CustTmp_Batch c
	
	EXEC dbo.Acc_DynamicCustomerInfo_09 
			@CustIDs = @CustIDs

	WAITFOR DELAY '00:00:00.050'
END

DROP TABLE #CustTmp_Batch
DROP TABLE #CustTmp_DisabledKeno
DROP TABLE #supers







