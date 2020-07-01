/*
	Created: 20200630@Johnson
	Task: initial setting for IBCBet Live Casino for INDOBS
	DB: DBCUST/CUSTDB	
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT,
	@currency INT,	
	@maxcustid INT,	
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1	   
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1	 
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 1	 
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1	   
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1	   
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1	   
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1	   		
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1	   		
	   )
		RETURN
		
	CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT, isFinished BIT DEFAULT 0)	
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend
		AND Enabled = 1
		AND custid <= @maxcustid
		
	--PT setting	
	INSERT INTO [dbo].[CustPTSetting3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[IsAutoMasterPT]
           ,[AutoMasterPT]
           ,[IsAutoSuperPT]
           ,[AutoSuperPT]
           ,[MinPT]
           ,[MaxPT])
	SELECT custid, 242, 3201, 0,
		CASE WHEN roleid = 4 THEN 75 WHEN roleid = 3 THEN 5 ELSE 0 END as SuperPT,
		CASE WHEN roleid = 4 THEN 75 WHEN roleid = 3 THEN 70 ELSE 0 END as MasterPT,
		CASE WHEN roleid = 4 THEN 75 ELSE 0 END as AgentPT, 
		0 as IsAutoMasterPT,
		0 as AutoMasterPT,
		0 as IsAutoSuperPT,
		0 as AutoSuperPT,
		0 as MinPT,
		100 as MaxPT
	FROM #tblCust
	WHERE roleid > 1
	
	INSERT INTO [dbo].[CustPTSetting3rd_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[IsAutoMasterPT]
           ,[AutoMasterPT]
           ,[IsAutoSuperPT]
           ,[AutoSuperPT])
    SELECT  custid, 242, 3201, 0,
		0 as SuperPT,
		0 as MasterPT,
		0 as AgentPT, 
		0 as IsAutoMasterPT,
		0 as AutoMasterPT,
		0 as IsAutoSuperPT,
		0 as AutoSuperPT		
	FROM #tblCust
	WHERE roleid = 1
	
	--Discount setting
	INSERT INTO [dbo].[CustDiscount3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
    SELECT custid, 242, 3201, 
		CASE WHEN roleid IN (3,4) THEN 0.007 ELSE 0 END
	FROM #tblCust
	WHERE roleid > 1
	
	INSERT INTO [dbo].[CustDiscount3rd_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[PlayerDiscount]
           ,[AgentDiscount]
           ,[MasterDiscount]
           ,[SuperDiscount])
	SELECT custid, 242, 3201, 0, 0, 0.007, 0.007
	FROM #tblCust
	WHERE roleid = 1
	
	--bet setting
	DECLARE @StakeLevelID INT
	
	SELECT @StakeLevelID = StakeLevelID
	FROM StakeLevel WITH(NOLOCK)
	WHERE Exchangeid = @currency
		AND GameTypeID = 3201
		
	INSERT INTO [dbo].[CustStakeLevel_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
    SELECT custid, 242, 3201, @StakeLevelID	
	FROM #tblCust 
	WHERE roleid > 1
	
	INSERT INTO [dbo].[CustStakeLevel_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])
    SELECT custid, 242, 3201, @StakeLevelID, GETDATE()
	FROM #tblCust
	WHERE roleid = 1
	
	--winlimit
	INSERT INTO [dbo].[CustWinLossLimit_Agent]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
	SELECT custid, 242, 3201,MaxWinLimit,MaxLossLimit,IsAutoReset
	FROM CustWinLossLimit_Agent WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
		AND sporttype = 243
	
	INSERT INTO [dbo].[CustWinLossLimit_Member]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
    SELECT custid, 242, 3201,MaxWinLimit,MaxLossLimit,IsAutoReset
	FROM CustWinLossLimit_Member WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
		AND sporttype = 243
	
	DROP TABLE #tblCust
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, @currency INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid, currency)
SELECT c.custid, c.currency
FROM Acc_CustGroup g WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON g.custid = c.custid
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
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting3rd_19 
			@srecommend = @srecommend
			,@currency = @currency
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #supers
GO
---
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT, @currency INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid, currency)
SELECT c.custid, c.currency
FROM Acc_CustGroup g WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON g.custid = c.custid
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
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting3rd_19 
			@srecommend = @srecommend
			,@currency = @currency
			,@maxcustid = @max_custid
			,@target = 'DBCUST'	
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #supers
GO
---
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB-----
--------------------------------------------------------------------------------------
