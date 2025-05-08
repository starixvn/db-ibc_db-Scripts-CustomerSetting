/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Delete data reduntdant [#221908] 
	DB: DBCust/CustDB
*/
ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_16
	@CustIdList varchar(max),
	@TableName varchar(200)
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE @__paramxml XML = CAST(@CustIdList AS XML)

	DECLARE @__tdata TABLE (custid INT , key1 INT , key2 TINYINT, key3 SMALLINT)
	DECLARE @__tdata1 TABLE (custid INT , key1 TINYINT , key2 SMALLDATETIME, key3 INT)
	DECLARE @__tdata2 TABLE (LogID BIGINT)


	IF @TableName IN ('RobotList','BetLimitControlCustSetting','VRCustAutoAdjustment','VRCustSetting','VRAgentAutoAdjustment','VRCustLockStatus','VRMemberBigStake','VRSettingManualUpdAcc','WinLimit_CustGameStatus')
	BEGIN
		INSERT INTO @__tdata(custid, key1, key2, key3)
		SELECT T.C.value('@c', 'INT')
			, T.C.value('@k1', 'INT')
			, T.C.value('@k2', 'TINYINT')
			, T.C.value('@k3', 'SMALLINT')
		FROM @__paramxml.nodes('/root/r') AS T(C)

		--Start remove
		IF @TableName = 'VRMemberBigStake'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			--remve data
			DELETE vr
			FROM VRMemberBigStake vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID and t.key2 = vr.Type
			)

			RETURN
		END
		ELSE IF @TableName = 'BetLimitControlCustSetting'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM BetLimitControlCustSetting vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID and t.key1 = vr.BetLimitTypeID
			)
			RETURN
		END
		ELSE IF @TableName = 'RobotList'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM RobotList vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID
			)
			RETURN
		END
		ELSE IF @TableName = 'VRAgentAutoAdjustment'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM VRAgentAutoAdjustment vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.AgentID AND t.key2 = vr.Type
			)
			RETURN
		END
		ELSE IF @TableName = 'VRCustAutoAdjustment'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM VRCustAutoAdjustment vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID AND t.key3 = vr.SportType
			)
			RETURN
		END
		ELSE IF @TableName = 'VRCustLockStatus'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM VRCustLockStatus vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID AND t.key2 = vr.Type
			)
			RETURN
		END
		ELSE IF @TableName = 'VRCustSetting'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM VRCustSetting vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID AND t.key1 = LevelID
			)
			RETURN
		END
		ELSE IF @TableName = 'VRSettingManualUpdAcc'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			--remve data
			DELETE vr
			FROM VRSettingManualUpdAcc vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID AND t.key3 = vr.SportType
			)
			RETURN
		END
		ELSE IF @TableName = 'WinLimit_CustGameStatus'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			--remve data
			DELETE vr
			FROM WinLimit_CustGameStatus vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata t
				WHERE t.custid = vr.CustID AND t.key2 = vr.ProductID AND t.key3 = vr.BettypeID
			)
			RETURN
		END
	END
	ELSE IF @TableName IN ('WinLimit_CustGameMonitoring')
	BEGIN
		INSERT INTO @__tdata1(custid, key1, key2, key3)
		SELECT T.C.value('@c', 'INT')
			, T.C.value('@k1', 'TINYINT')
			, T.C.value('@k2', 'SMALLDATETIME')
			, T.C.value('@k3', 'INT')
		FROM @__paramxml.nodes('/root/r') AS T(C)

		--Start remove
		IF @TableName = 'WinLimit_CustGameMonitoring'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			DELETE vr
			FROM WinLimit_CustGameMonitoring vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata1 t
				WHERE t.custid = vr.CustID AND T.key1 = vr.ProductID AND T.key2 = vr.WinlostDate  AND t.key3 = vr.GroupID
			)
			RETURN
		END
	END
	ELSE IF @TableName IN ('WinLimit_CustGameMonitoring_History')
	BEGIN
		INSERT INTO @__tdata2(LogID)
		SELECT T.C.value('@c', 'BIGINT')
		FROM @__paramxml.nodes('/root/r') AS T(C)


		--Start remove
		IF @TableName = 'WinLimit_CustGameMonitoring_History'
			AND OBJECT_ID(@TableName) IS NOT NULL 
		BEGIN
		
			--remve data
			DELETE vr
			FROM WinLimit_CustGameMonitoring_History vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM @__tdata2 t
				WHERE T.LogID = vr.LogID
			)

			RETURN
		END
	END
		
END
    