/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231120
	Task: [Diamond] Disable AdvantPlay & AdvantPlay mini - Existing Customer
		- Disabled status for DiamondSuperINH
		https://nexdev.net/issues/196503
	DB: DBCust/CustDB and all replicated server
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustList NVARCHAR(MAX)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT dbo.f_CheckRepTable('Dep_CustProductStatus') = 1
		RETURN
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY)

	INSERT INTO #CustList (CustID)
	SELECT  TRIM(value)
	FROM STRING_SPLIT(@CustList,',') t
	WHERE TRIM(value)<>''

	DECLARE @xmlStrHidden XML
	
	SET @xmlStrHidden = (
			SELECT DISTINCT
				bitmap AS '@b', 
				1 AS '@s'
			FROM (SELECT 27 AS bitmap	--Advantplay
				  UNION
				  SELECT 29 AS bitmap	--Advantplay Mini
				) vh 
			FOR XML PATH ('r'), ROOT ('root')
			)
	
	UPDATE cs
	SET	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrHidden)))
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList b ON cs.CustID = b.CustID 

	DROP TABLE #CustList
END
GO
------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Cust_cnt	INT,
		@max_custid INT,
		@CustList   NVARCHAR(MAX),
		@BatchSize	INT = 2000

SELECT @max_custid = xxx
	
CREATE TABLE #Customer(CustID INT PRIMARY KEY)

CREATE TABLE #Customer_batch(CustID INT PRIMARY KEY)

------------------------------------------------
INSERT INTO #Customer(custid)
SELECT ci.custid
FROM custInfo ci WITH(NOLOCK)
INNER JOIN Dep_CustSuper cs WITH(NOLOCK) ON cs.custid=ci.srecommend
INNER JOIN Dep_CustProductStatus d WITH (NOLOCK) ON D.CustID=Ci.custid
WHERE  ci.Enabled=1 AND cs.site = 'Diamond' AND ci.currency=51
AND ci.custid<=@max_custid
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #Customer

DECLARE @msg_total NVARCHAR(200) = 'Total of Existing Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

WHILE (1=1)
BEGIN
	DELETE FROM #Customer_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID
		INTO #Customer_batch(CustID)
	FROM #Customer t 

	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustList=STUFF((SELECT ',' + CAST(CustID AS VARCHAR)
							FROM #Customer_batch
							FOR XML PATH('')
							),1,1,'')

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@CustList=@CustList,
			@target = @target
	
	WAITFOR DELAY '00:00:00:280'

	SET @msg_total = 'curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

PRINT N'--------------------------------------------------------'
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO

-- END: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------
