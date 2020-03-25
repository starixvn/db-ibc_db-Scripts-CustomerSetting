/*
	Created: Johnson
	Task: Enable Esports for supers & downlines of hl ZU01 [RedmineID: #131058]
	DB: DBCUST/CustDB
	Date: 20200325
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT	
	,@maxcustid INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	
	DECLARE @BitOrder INT = 18-- E-sports	

	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmpCust TABLE(custid INT)
	
	INSERT INTO #tblCust(CustID)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 
		INNER JOIN CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
	WHERE ci.srecommend = @srecommend 		
		AND ci.Enabled=1	
		AND ci.custid <= @maxcustid
		AND (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapIsDisabled,@BitOrder)) = 1
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) #tblCust
		OUTPUT DELETED.* 
		INTO @tmpCust

		IF @@ROWCOUNT=0
			BREAK	
			
		UPDATE cs
		SET	bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),							
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,0)
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)

		DELETE @tmpCust
	END
	
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN CustAccount ca (nolock) ON ci.custid = ca.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ca.groupid = 515 --ZU01	
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers)

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustomerInfo_09] 
			@srecommend = @srecommend, 			
			@maxcustid = @max_custid,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN CustAccount ca (nolock) ON ci.custid = ca.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ca.groupid = 515 --ZU01	
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers)

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustomerInfo_09] 
			@srecommend = @srecommend, 			
			@maxcustid = @max_custid,
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	




