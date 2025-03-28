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

	DECLARE @BatchSize INT = 2000;

	IF @TableName = 'VRMemberBigStake'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRMemberBigStake vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'BetLimitControlCustSetting'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM BetLimitControlCustSetting vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'RobotList'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM RobotList vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'VRAgentAutoAdjustment'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRAgentAutoAdjustment vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.AgentID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'VRCustAutoAdjustment'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRCustAutoAdjustment vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'VRCustLockStatus'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRCustLockStatus vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'VRCustSetting'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRCustSetting vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'VRSettingManualUpdAcc'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM VRSettingManualUpdAcc vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'WinLimit_CustGameMonitoring'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM WinLimit_CustGameMonitoring vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'WinLimit_CustGameMonitoring_History'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM WinLimit_CustGameMonitoring_History vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
	ELSE IF @TableName = 'WinLimit_CustGameStatus'
		AND OBJECT_ID(@TableName) IS NOT NULL 
	BEGIN
		
		WHILE 1 = 1
		BEGIN
			--remve data
			DELETE TOP(@BatchSize) vr
			FROM WinLimit_CustGameStatus vr WITH (ROWLOCK)
			WHERE EXISTS (
				SELECT TOP 1 1
				FROM STRING_SPLIT(@CustIdList, ',') t
				WHERE t.value = vr.CustID
			)

			IF @@ROWCOUNT = 0
				RETURN

		END
		RETURN
	END
END