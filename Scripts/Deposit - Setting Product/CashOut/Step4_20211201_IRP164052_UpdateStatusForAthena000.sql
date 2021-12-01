/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211129@Johnson
	Task: Enable Cash Out for Athena000
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@srecommend INT, 
	@max_custid	INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN 
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	DECLARE @BitmapOrder INT = 31,
		@ProductSettingID INT = 116
	
	INSERT INTO #Dummy(CustID)
	SELECT CustID 
	FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

	INSERT INTO #tblCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend 
		AND ci.custid<=@max_custid 		
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmp(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 	
		FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmp)
			
		DELETE @tmp		
	END
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=@ProductSettingID)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,@ProductSettingID
	END
	
	DROP TABLE #tblCust	
	DROP TABLE #Dummy
END
GO	
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------



-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'		
	AND ci.Enabled=1
	AND cs.site IN('Athena000')

		
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order: %d'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@Custid = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @Custid
			,@max_custid = @max_custid
			,@target = @target	
			
	WAITFOR DELAY '00:00:0.280'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------

	