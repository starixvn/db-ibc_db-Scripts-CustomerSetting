/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Initialize Product Status of VGaming for Credit customers [#RM:153938]
	DB: DBCUST/CustDB And all subscriber of CustDB_CustomerInfo Publication
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @srecommend INT
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   )
		RETURN
				
	/*******************************CUST PRODUCT STATUS TABLE*******************************/	

	DECLARE @bitmapOrderDest tinyint = 34 --VGaming
	DECLARE @bitmapOrderSource tinyint = 21 --Saba.club

	CREATE TABLE #CustTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #CustStatus
	(
		CustID INT PRIMARY KEY CLUSTERED,
		isDisabled BIT,
		isHidden BIT
	)

	CREATE TABLE #CustStatus_batch
	(
		CustID INT PRIMARY KEY CLUSTERED,
		isDisabled BIT,
		isHidden BIT
	)
	
	INSERT INTO #CustTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND Enabled = 1 AND custid <= @max_custid

	INSERT INTO #CustStatus(CustID,isDisabled,isHidden)
	SELECT c.CustID,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrderSource)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrderSource)) as isHidden
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN #CustTemp d ON c.CustID = d.CustID

	WHILE 1 = 1
	BEGIN
		DELETE TOP (3000) #CustStatus OUTPUT DELETED.CustID,deleted.isDisabled,deleted.isHidden INTO #CustStatus_batch(CustID,isDisabled,isHidden)

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@bitmapOrderDest,ci.isHidden)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@bitmapOrderDest,ci.isDisabled))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
			INNER JOIN #CustStatus_batch ci WITH(NOLOCK) ON cs.CustID = ci.CustID

		TRUNCATE TABLE #CustStatus_batch

	END

	DROP TABLE #CustStatus
	DROP TABLE #CustStatus_batch
	DROP TABLE #CustTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666', 'IBCIndo')
	AND ci.currency IN (
							13, --CNY(RMB)
							6,  --EUR(EURO)
							12, --GBP(GBP)
							5,  --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2,  --MYR(RM)
							43, --THB(THB)
							95  --USD(USD)
						
	)
	AND 1 = (CASE WHEN s.[site] = 'BEST-ODDS' AND ci.currency IN (43,47,33,34,15,22) THEN 0 ELSE 1 END) --exclude Site BEST-ODDS with currencies: THB(THB), IDR(DDD), IDR(IDR), IDR(IDR), IDR(IN), IDR(IND)


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @srecommend = @srecommend
			,@target = @target
			,@max_custid = @max_custid
			
			
	waitfor delay '00:00:00.100'
END
DROP TABLE #supers
GO
