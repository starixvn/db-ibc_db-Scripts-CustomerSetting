/*
	Created by: Elodie
	Date: 20200609
	Task: Reset PT of IBC Bet
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_09
	@srecommend INT,
	@Target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN	

	DECLARE @PT TINYINT = 75, @batch INT = 4000, @CurrentMinPT_242 TINYINT, @NewMinPT_242 TINYINT, @SportType SMALLINT = 242, @Bettype SMALLINT = 3201

	SELECT @CurrentMinPT_242 = MinPT FROM dbo.CustPTSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @srecommend AND SportType = @SportType AND BetType = @Bettype

	IF @CurrentMinPT_242 > @PT 
		SELECT @NewMinPT_242 = @PT
	ELSE 
		SELECT @NewMinPT_242 = @CurrentMinPT_242	

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	
	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM dbo.Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM dbo.Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3) AND Enabled = 1

	UPDATE cs 
	SET cs.SuperPT = @PT,
		cs.MasterPT = @PT,
		cs.AgentPT = @PT,
		cs.AutoMasterPT = 0,
		cs.IsAutoMasterPT = 0,
		cs.AutoSuperPT = 0,
		cs.IsAutoSuperPT = 0,
		cs.MinPT = @NewMinPT_242
	FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	WHERE cs.SportType = @SportType
		AND cs.CustID = @srecommend

	UPDATE cs 
	SET cs.SuperPT = 0,
		cs.MasterPT = 0,
		cs.AgentPT = 0,
		cs.AutoMasterPT = 0,
		cs.IsAutoMasterPT = 0,
		cs.AutoSuperPT = 0,
		cs.IsAutoSuperPT = 0,
		cs.MinPT = 0
	FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #SMATemp a ON a.CustID = cs.CustID
	WHERE cs.SportType = @SportType

	UPDATE cs 
	SET cs.SuperPT = @NewMinPT_242,
		cs.MasterPT = 0,
		cs.AgentPT = 0,
		cs.AutoMasterPT = 0,
		cs.IsAutoMasterPT = 0,
		cs.AutoSuperPT = 0,
		cs.IsAutoSuperPT = 0
	FROM dbo.CustPTGroupSetting3rd_Member cs WITH (ROWLOCK)
		INNER JOIN #SMATemp a ON a.CustID = cs.AgentID
	WHERE cs.SportType = @SportType
		AND a.roleid = 2

	--UPDATE cs 
	--SET cs.SuperPT = 0,
	--	cs.MasterPT = 0,
	--	cs.AgentPT = 0,
	--	cs.AutoMasterPT = 0,
	--	cs.IsAutoMasterPT = 0,
	--	cs.AutoSuperPT = 0,
	--	cs.IsAutoSuperPT = 0
	--FROM dbo.CustPTSetting3rd_Member cs WITH (ROWLOCK)
	--	INNER JOIN #MemberTemp a ON a.CustID = cs.CustID
	--WHERE cs.SportType IN (241, 243)

	CREATE TABLE #BatchMember(CustID INT)

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #BatchMember

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID INTO #BatchMember(CustID)
		FROM #MemberTemp a 

		IF @@ROWCOUNT = 0 
			BREAK

		UPDATE cs 
		SET cs.SuperPT = @NewMinPT_242,
			cs.MasterPT = 0,
			cs.AgentPT = 0,
			cs.AutoMasterPT = 0,
			cs.IsAutoMasterPT = 0,
			cs.AutoSuperPT = 0,
			cs.IsAutoSuperPT = 0
		FROM dbo.CustPTSetting3rd_Member cs WITH (ROWLOCK)
			INNER JOIN #BatchMember a ON a.CustID = cs.CustID
		WHERE cs.SportType = @SportType

		WAITFOR DELAY '00:00:00.100'
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @maxcustid INT, @srecommend INT

--SELECT @maxcustid = xxx
--1104 supers
INSERT INTO #supers(custid)
SELECT custid
FROM vw_Customer WITH (NOLOCK) 
WHERE roleid = 4 AND site = 'IBCIndo'

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			--,@maxcustid = @maxcustid
			,@target = 'REPLICATED'
			
	waitfor delay '00:00:0.100'
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @maxcustid INT, @srecommend INT

--SELECT @maxcustid = xxx

--1104 supers
INSERT INTO #supers(custid)
SELECT custid
FROM vw_Customer WITH (NOLOCK) 
WHERE roleid = 4 AND site = 'IBCIndo'

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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			--,@maxcustid = @maxcustid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
