/*
	Created: 20200706@Johnson
	Task: update enabled for IBCBet LC for INDOBS
	DB: DBCUST/CUSTDB	
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT,	
	@maxcustid INT,	
	@xmlstrBitmapDisabled VARCHAR(MAX),
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1	   
	   )
		RETURN
	
	CREATE TABLE #tblCust
	(
		CustID INT PRIMARY KEY CLUSTERED,
		IsFinished BIT DEFAULT(0)
	)	

	INSERT INTO #tblCust (CustID)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE srecommend = @srecommend
		AND Enabled = 1
		AND custid <= @maxcustid
	
	DECLARE @MemberBatch table(CustId INT)

	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET IsFinished = 1
		OUTPUT INSERTED.CustID INTO @MemberBatch
		FROM #tblCust t
		WHERE IsFinished = 0
	 
		IF @@ROWCOUNT = 0
			BREAK
		
		UPDATE cs
		SET bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrBitmapDisabled)))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
			INNER JOIN @MemberBatch ci ON cs.CustID = ci.CustID

		DELETE @MemberBatch
	END

	--Drop all temp tables
	DROP TABLE #tblCust	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, @max_custid INT, 		
		@xmlStrBitmapDisabled VARCHAR(MAX), @xmlBitmapDisabled XML

SELECT @max_custid = xxx

--Create XML string that contains bitmap order of all products 
SET @xmlBitmapDisabled = (
		SELECT (
					SELECT P.bitmapOrder AS '@b'
							, 0	AS '@s'
					FROM dbo.ProductStatusProfile P WITH (NOLOCK)
					WHERE sporttype IN (242--IBCBet LC
										)		
					FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)				

SELECT @xmlStrBitmapDisabled = CONVERT(VARCHAR(MAX),@xmlBitmapDisabled)

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT custid 
FROM Acc_CustGroup WITH(NOLOCK)
where groupname = 'indobs'	
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT


--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			@srecommend = @srecommend			
			,@xmlstrBitmapDisabled=@xmlstrBitmapDisabled
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'			
	WAITFOR DELAY '00:00:0.100'	
END

DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, @max_custid INT, 		
		@xmlStrBitmapDisabled VARCHAR(MAX), @xmlBitmapDisabled XML

SELECT @max_custid = xxx

--Create XML string that contains bitmap order of all products 
SET @xmlBitmapDisabled = (
		SELECT (
					SELECT P.bitmapOrder AS '@b'
							, 0	AS '@s'
					FROM dbo.ProductStatusProfile P WITH (NOLOCK)
					WHERE sporttype IN (242--IBCBet LC
										)		
					FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)				

SELECT @xmlStrBitmapDisabled = CONVERT(VARCHAR(MAX),@xmlBitmapDisabled)

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT custid 
FROM Acc_CustGroup WITH(NOLOCK)
where groupname = 'indobs'	
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT


--Update Disable Customers:
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			@srecommend = @srecommend			
			,@xmlstrBitmapDisabled=@xmlstrBitmapDisabled
			,@maxcustid = @max_custid
			,@target = 'DBCUST'			
	WAITFOR DELAY '00:00:0.100'	
END

DROP TABLE #supers
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------