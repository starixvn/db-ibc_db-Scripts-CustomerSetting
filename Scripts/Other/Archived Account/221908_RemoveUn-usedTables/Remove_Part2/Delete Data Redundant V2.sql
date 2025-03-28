-- Declare reusable parameters and temporary table
DECLARE @BatchSize INT = 2000;
DECLARE @DeletedCount INT = 0; -- Parameter to track the total number of rows deleted
DECLARE @Msg NVARCHAR(200); -- Parameter for formatted messages

-- Create a reusable temporary table
CREATE TABLE #Temp_ToDelete (CustID INT);

/*--------------Block1 VRMemberBigStake and VRMemberBigStake_Del_InHouse ----------*/
IF OBJECT_ID('VRMemberBigStake', 'U') IS NOT NULL 
AND OBJECT_ID('VRMemberBigStake_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRMemberBigStake_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.Type, [dbo].[f_GetDateTime2]()
        INTO VRMemberBigStake_Del_InHouse (CustID, Type, RepUpdateTime)
        FROM VRMemberBigStake V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRMemberBigStake has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRMemberBigStake.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block2 BetLimitControlCustSetting and BetLimitControlCustSetting_Del_InHouse ----------*/
IF OBJECT_ID('BetLimitControlCustSetting', 'U') IS NOT NULL 
AND OBJECT_ID('BetLimitControlCustSetting_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into BetLimitControlCustSetting_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.BetLimitTypeID, [dbo].[f_GetDateTime2]()
        INTO BetLimitControlCustSetting_Del_InHouse (CustID, BetLimitTypeID, RepUpdateTime)
        FROM BetLimitControlCustSetting V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from BetLimitControlCustSetting has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from BetLimitControlCustSetting.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block3 RobotList and RobotList_Del_InHouse ----------*/
IF OBJECT_ID('RobotList', 'U') IS NOT NULL 
AND OBJECT_ID('RobotList_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into RobotList_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, [dbo].[f_GetDateTime2]()
        INTO RobotList_Del_InHouse (CustID, RepUpdateTime)
        FROM RobotList V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from RobotList has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from RobotList.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block4 VRAgentAutoAdjustment and VRAgentAutoAdjustment_Del_InHouse ----------*/
IF OBJECT_ID('VRAgentAutoAdjustment', 'U') IS NOT NULL 
AND OBJECT_ID('VRAgentAutoAdjustment_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRAgentAutoAdjustment_Del_InHouse
        DELETE V
        OUTPUT DELETED.AgentID, DELETED.Type, [dbo].[f_GetDateTime2]()
        INTO VRAgentAutoAdjustment_Del_InHouse (AgentID, Type, RepUpdateTime)
        FROM VRAgentAutoAdjustment V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.AgentID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRAgentAutoAdjustment has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRAgentAutoAdjustment.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block5 VRCustAutoAdjustment and VRCustAutoAdjustment_Del_InHouse ----------*/
IF OBJECT_ID('VRCustAutoAdjustment', 'U') IS NOT NULL 
AND OBJECT_ID('VRCustAutoAdjustment_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRCustAutoAdjustment_Del_InHouse
        DELETE V
        OUTPUT DELETED.SportType, DELETED.CustID, [dbo].[f_GetDateTime2]()
        INTO VRCustAutoAdjustment_Del_InHouse (SportType, CustID, RepUpdateTime)
        FROM VRCustAutoAdjustment V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRCustAutoAdjustment has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRCustAutoAdjustment.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block6 VRCustLockStatus and VRCustLockStatus_Del_InHouse ----------*/
IF OBJECT_ID('VRCustLockStatus', 'U') IS NOT NULL 
AND OBJECT_ID('VRCustLockStatus_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRCustLockStatus_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.Type, [dbo].[f_GetDateTime2]()
        INTO VRCustLockStatus_Del_InHouse (CustID, Type, RepUpdateTime)
        FROM VRCustLockStatus V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRCustLockStatus has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRCustLockStatus.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block7 VRCustSetting and VRCustSetting_Del_InHouse ----------*/
IF OBJECT_ID('VRCustSetting', 'U') IS NOT NULL 
AND OBJECT_ID('VRCustSetting_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRCustSetting_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.LevelID, [dbo].[f_GetDateTime2]()
        INTO VRCustSetting_Del_InHouse (CustID, LevelID, RepUpdateTime)
        FROM VRCustSetting V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRCustSetting has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRCustSetting.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block8 VRSettingManualUpdAcc and VRSettingManualUpdAcc_Del_InHouse ----------*/
IF OBJECT_ID('VRSettingManualUpdAcc', 'U') IS NOT NULL 
AND OBJECT_ID('VRSettingManualUpdAcc_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into VRSettingManualUpdAcc_Del_InHouse
        DELETE V
        OUTPUT DELETED.SportType, DELETED.CustID, [dbo].[f_GetDateTime2]()
        INTO VRSettingManualUpdAcc_Del_InHouse (SportType, CustID, RepUpdateTime)
        FROM VRSettingManualUpdAcc V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from VRSettingManualUpdAcc has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from VRSettingManualUpdAcc.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block9 WinLimit_CustGameMonitoring and WinLimit_CustGameMonitoring_Del_InHouse ----------*/
IF OBJECT_ID('WinLimit_CustGameMonitoring', 'U') IS NOT NULL 
AND OBJECT_ID('WinLimit_CustGameMonitoring_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into WinLimit_CustGameMonitoring_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.ProductID, DELETED.WinlostDate, DELETED.GroupID, [dbo].[f_GetDateTime2]()
        INTO WinLimit_CustGameMonitoring_Del_InHouse (CustID, ProductID, WinlostDate, GroupID, RepUpdateTime)
        FROM WinLimit_CustGameMonitoring V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from WinLimit_CustGameMonitoring has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from WinLimit_CustGameMonitoring.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block10 WinLimit_CustGameMonitoring_History and WinLimit_CustGameMonitoring_History_Del_InHouse ----------*/
IF OBJECT_ID('WinLimit_CustGameMonitoring_History', 'U') IS NOT NULL 
AND OBJECT_ID('WinLimit_CustGameMonitoring_History_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into WinLimit_CustGameMonitoring_History_Del_InHouse
        DELETE V
        OUTPUT DELETED.LogID, [dbo].[f_GetDateTime2]()
        INTO WinLimit_CustGameMonitoring_History_Del_InHouse (LogID, RepUpdateTime)
        FROM WinLimit_CustGameMonitoring_History V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from WinLimit_CustGameMonitoring_History has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from WinLimit_CustGameMonitoring_History.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

/*--------------Block11 WinLimit_CustGameStatus and WinLimit_CustGameStatus_Del_InHouse ----------*/
IF OBJECT_ID('WinLimit_CustGameStatus', 'U') IS NOT NULL 
AND OBJECT_ID('WinLimit_CustGameStatus_Del_InHouse', 'U') IS NOT NULL
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

        -- Delete rows from the main table and log deleted rows into WinLimit_CustGameStatus_Del_InHouse
        DELETE V
        OUTPUT DELETED.CustID, DELETED.ProductID, DELETED.BettypeID, [dbo].[f_GetDateTime2]()
        INTO WinLimit_CustGameStatus_Del_InHouse (CustID, ProductID, BettypeID, RepUpdateTime)
        FROM WinLimit_CustGameStatus V WITH (ROWLOCK)
        INNER JOIN #Temp_ToDelete T ON V.CustID = T.CustID;

        -- Increment the deleted count
        SET @DeletedCount = @DeletedCount + @@ROWCOUNT;

        -- Output a formatted message indicating successful deletion
        SET @Msg = 'Deleted ' + CONVERT(VARCHAR(50), @@ROWCOUNT) + ' rows successfully at: ' + CONVERT(VARCHAR(50), GETDATE(), 121);
        RAISERROR (@Msg, 0, 1) WITH NOWAIT;

        -- Wait for 0.05 seconds before processing the next batch
        WAITFOR DELAY '00:00:0.050';
    END

    -- Check if any data was deleted
    IF @DeletedCount > 0
    BEGIN
        PRINT 'Data from WinLimit_CustGameStatus has been successfully deleted. Total rows deleted: ' + CONVERT(VARCHAR(50), @DeletedCount);
    END
    ELSE
    BEGIN
        PRINT 'No data was deleted from WinLimit_CustGameStatus.';
    END;

    -- Reset the deleted count
    SET @DeletedCount = 0;

    -- Reset the temporary table after resetting the deleted count
    TRUNCATE TABLE #Temp_ToDelete;
END

-- Drop the reusable temporary table
DROP TABLE #Temp_ToDelete;