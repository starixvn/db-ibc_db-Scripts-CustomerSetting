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
	IF dbo.f_CheckRepTable('Dep_SupperProductSetting') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustProductSetting') = 0 RETURN 
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	DECLARE @ProductId INT = 25
	
	MERGE Dep_SupperProductSetting target 
	USING (SELECT @srecommend as custid, @ProductId as ProductID, 1 as IsEnabled ) as Source 
	ON target.CustID = Source.custid AND target.ProductId = Source.ProductID
	WHEN MATCHED AND Target.IsEnabled <> Source.IsEnabled THEN UPDATE SET Target.IsEnabled = Source.IsEnabled
	WHEN NOT MATCHED THEN INSERT(custid,ProductID,IsEnabled) VALUES(Source.custid,Source.ProductID,Source.IsEnabled);

		
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
		AND roleid = 1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmp(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		MERGE Dep_CustProductSetting target 
		USING (SELECT custid, @ProductId as ProductID, 1 as IsEnabled 
				FROM @tmp) as Source 
		ON target.CustID = Source.custid AND target.ProductId = Source.ProductID
		WHEN MATCHED AND Target.IsEnabled <> Source.IsEnabled THEN UPDATE SET Target.IsEnabled = Source.IsEnabled
		WHEN NOT MATCHED THEN INSERT(custid,ProductID,IsEnabled) VALUES(Source.custid,Source.ProductID,Source.IsEnabled);
					
		DELETE @tmp		
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

DECLARE @Custid INT, 
	@max_custid INT,	
	@ProductID INT = 25,
	@UserID INT = 10278938 --starixIT	

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
	
	IF @target = 'DBCUST'
	BEGIN
		EXEC Acc_CustomerInsDummyTrade	@ProductID	= @ProductID	
									,@CustID	=@CustID
									,@UserID	=@UserID								
	END
	
	WAITFOR DELAY '00:00:0.280'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------

	