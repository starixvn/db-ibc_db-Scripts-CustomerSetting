/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Delete data reduntdant [#221908] 
	DB: DBCust/CustDB
*/

ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_16
@target			VARCHAR (20)
AS
BEGIN

	SET NOCOUNT ON 

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at dbcust only

	-- Declare reusable parameters and temporary table
	DECLARE @BatchSize INT = 2000;
	DECLARE @IsDeleted BIT = 0; -- Parameter to track if data deletion occurred
	DECLARE @Msg NVARCHAR(200); -- Parameter for formatted messages

	-- Create a reusable temporary table
	CREATE TABLE #Temp_ToDelete (CustID INT);
	CREATE CLUSTERED INDEX IX_ToBeDeleted_ID ON #Temp_ToDelete(CustID);

	/*--------------Block1 VRMemberBigStake----------*/
	IF OBJECT_ID('VRMemberBigStake', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM VRMemberBigStake V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRMemberBigStake V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRMemberBigStake has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRMemberBigStake.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block2 BetLimitControlCustSetting----------*/
	IF OBJECT_ID('BetLimitControlCustSetting', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM BetLimitControlCustSetting V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM BetLimitControlCustSetting V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from BetLimitControlCustSetting has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from BetLimitControlCustSetting.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block3 RobotList ----------*/
	IF OBJECT_ID('RobotList', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT TOP (@BatchSize) V.CustID
		  FROM RobotList V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM RobotList V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from RobotList has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from RobotList.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block4 VRAgentAutoAdjustment ----------*/
	IF OBJECT_ID('VRAgentAutoAdjustment', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.AgentID
		  FROM VRAgentAutoAdjustment V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.AgentID = C.recommend
		  WHERE C.recommend IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRAgentAutoAdjustment V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.AgentID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRAgentAutoAdjustment has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRAgentAutoAdjustment.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block5 VRCustAutoAdjustment ----------*/
	IF OBJECT_ID('VRCustAutoAdjustment', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM VRCustAutoAdjustment V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRCustAutoAdjustment V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRCustAutoAdjustment has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRCustAutoAdjustment.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block6 VRCustLockStatus ----------*/
	IF OBJECT_ID('VRCustLockStatus', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM VRCustLockStatus V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRCustLockStatus V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRCustLockStatus has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRCustLockStatus.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block7 VRCustSetting ----------*/
	IF OBJECT_ID('VRCustSetting', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM VRCustSetting V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRCustSetting V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRCustSetting has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRCustSetting.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block8 VRSettingManualUpdAcc----------*/
	IF OBJECT_ID('VRSettingManualUpdAcc', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM VRSettingManualUpdAcc V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM VRSettingManualUpdAcc V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from VRSettingManualUpdAcc has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from VRSettingManualUpdAcc.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block9 WinLimit_CustGameMonitoring----------*/
	IF OBJECT_ID('WinLimit_CustGameMonitoring', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM WinLimit_CustGameMonitoring V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM WinLimit_CustGameMonitoring V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from WinLimit_CustGameMonitoring has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from WinLimit_CustGameMonitoring.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block10 WinLimit_CustGameMonitoring_History----------*/
	IF OBJECT_ID('WinLimit_CustGameMonitoring_History', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM WinLimit_CustGameMonitoring_History V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM WinLimit_CustGameMonitoring_History V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from WinLimit_CustGameMonitoring_History has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from WinLimit_CustGameMonitoring_History.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;

	    -- Wait for 0.05 seconds before processing the next table
	    WAITFOR DELAY '00:00:0.050';
	END

	/*--------------Block11 WinLimit_CustGameStatus----------*/
	IF OBJECT_ID('WinLimit_CustGameStatus', 'U') IS NOT NULL 
	BEGIN
	    WHILE 1 = 1
	    BEGIN
		  -- Clear the temporary table for the next batch
		  TRUNCATE TABLE #Temp_ToDelete;

		  -- Insert rows into the temporary table
		  INSERT INTO #Temp_ToDelete (CustID)
		  SELECT DISTINCT TOP (@BatchSize) V.CustID
		  FROM WinLimit_CustGameStatus V WITH (NOLOCK)
		  LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
		  WHERE C.CustID IS NULL;

		  -- Check if the temporary table has data
		  IF NOT EXISTS (SELECT TOP 1 1 FROM #Temp_ToDelete)
		  BEGIN
			BREAK;
		  END;

		  DELETE V
		  FROM WinLimit_CustGameStatus V WITH (ROWLOCK)
		  INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

		  -- Set the parameter to 1 to indicate data was deleted
		  SET @IsDeleted = 1;

		  -- Output a formatted message indicating successful deletion
		  SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @BatchSize) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
		  RAISERROR (@Msg, 0, 1) WITH NOWAIT;

		  -- Wait for 0.05 seconds before processing the next batch
		  WAITFOR DELAY '00:00:0.050';
	    END

	    -- Check if the table's data was deleted
	    IF @IsDeleted = 1
	    BEGIN
		  PRINT 'Data from WinLimit_CustGameStatus has been successfully deleted.';
	    END
	    ELSE
	    BEGIN
		  PRINT 'No data was deleted from WinLimit_CustGameStatus.';
	    END;

	    -- Reset the deletion flag
	    SET @IsDeleted = 0;

	    -- Reset the temporary table after resetting the deletion flag
	    TRUNCATE TABLE #Temp_ToDelete;
	END

	-- Drop the reusable temporary table
	DROP TABLE #Temp_ToDelete;
	
END