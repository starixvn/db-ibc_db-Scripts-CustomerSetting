/*
	Created: Elodie@20200609
	Task: Update comm of IBCBet
	DB: DBCUST/CustDB	
*/ 
ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_19]
	@srecommend INT
	,@target VARCHAR(20) = NULL
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ( 'DB233','DB230\SQLSERVER2008R2','DBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ( 'DB233','DB230\SQLSERVER2008R2','DBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN

	DECLARE @Discount_XML VARCHAR(MAX) = '', @custid INT	
	CREATE TABLE #MasterList (CustID INT PRIMARY KEY, IsFinished BIT)

	----- DATA preparation ---------
	INSERT INTO #MasterList (CustID, IsFinished)
	SELECT custid, 0
	FROM dbo.Customer c WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 3

	SET @Discount_XML = N'<ROOT><Discount SportType="242" BetType="3201" Discount="0.00700000"/></ROOT>'
	
	-------- UPDATE commission customer setting -------------
	EXEC dbo.Acc_DynamicCustSetting3rd_06
			@CustId			= @srecommend
			, @RoleId		= 4
			, @SettingType  = 3
			, @Discount_XML = @Discount_XML

	WHILE (1=1)
	BEGIN
		UPDATE TOP (1) #MasterList
		SET isfinished = 1
			,@custid = custid			
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		EXEC dbo.Acc_DynamicCustSetting3rd_06
			@CustId			= @custid
			, @RoleId		= 3
			, @SettingType  = 3
			, @Discount_XML = @Discount_XML
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))

DECLARE @srecommend INT
-- list of supers
INSERT INTO #supers(custid)
SELECT custid
FROM vw_Customer WITH (NOLOCK) 
WHERE roleid = 4 AND site = 'IBCIndo'

-- For deployer info

DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @target = 'REPLICATED'
			
	WAITFOR DELAY '00:00:0.100'
	
END

GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished BIT DEFAULT(0))

DECLARE @srecommend INT
-- list of supers
INSERT INTO #supers(custid)
SELECT custid
FROM vw_Customer WITH (NOLOCK) 
WHERE roleid = 4 AND site = 'IBCIndo'

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #supers )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Custsetting3rd_19 @srecommend = @srecommend
			, @target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.100'
	
END
GO
