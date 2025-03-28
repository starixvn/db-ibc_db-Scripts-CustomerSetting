/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Delete data reduntdant [#221908] 
	DB: DBCust/CustDB
*/

SET NOCOUNT ON
DECLARE @__batchSize INT = 2000
	, @__redBatch INT = 50000

CREATE TABLE #Temp_ToDelete (CustID INT)
DECLARE @Batch_Temp_ToDelete TABLE (CustID INT)
DECLARE @__custIds VARCHAR(MAX)

-- Process each table sequentially

-- Table: VRMemberBigStake
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRMemberBigStake V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRMemberBigStake'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: BetLimitControlCustSetting
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM BetLimitControlCustSetting V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'BetLimitControlCustSetting'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: RobotList
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM RobotList V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'RobotList'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: VRAgentAutoAdjustment
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRAgentAutoAdjustment V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRAgentAutoAdjustment'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: VRCustAutoAdjustment
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRCustAutoAdjustment V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRCustAutoAdjustment'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: VRCustLockStatus
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRCustLockStatus V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRCustLockStatus'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: VRCustSetting
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRCustSetting V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRCustSetting'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: VRSettingManualUpdAcc
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRSettingManualUpdAcc V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRSettingManualUpdAcc'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: WinLimit_CustGameMonitoring
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM WinLimit_CustGameMonitoring V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'WinLimit_CustGameMonitoring'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: WinLimit_CustGameMonitoring_History
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM WinLimit_CustGameMonitoring_History V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'WinLimit_CustGameMonitoring_History'
	END

	WAITFOR DELAY '00:00:00:100'
END

-- Table: WinLimit_CustGameStatus
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM WinLimit_CustGameStatus V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(custid, ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'WinLimit_CustGameStatus'
	END

	WAITFOR DELAY '00:00:00:100'
END