/*
	Creator: 20200615@Eden
	Task: Insert VRCustSetting - Redmine: #134978
	DB: CustDB@DBCUST and custdb_CustSetting publication
*/
--------step 1 : Run at DBCUST/CUSTDB------------------------
USE CUSTDB
GO
ALTER PROCEDURE [dbo].[Acc_custsetting_19]
	@SportLevel INT ,
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('VRCustSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('VRSettingManualUpdAcc') = 0 RETURN
	IF dbo.f_CheckRepTable('VRSettingHierarchy') = 0 RETURN
	IF dbo.f_CheckRepTable('VRBettypeGroup') = 0 RETURN

	CREATE TABLE #BasketBallVR_Temp (
		[VRValue_HDPLive] [money] ,
		[VRValue_HDPNonLive] [money] ,
		[VRValue_OULive] [money] ,
		[VRValue_OUNonLive] [money] ,
		[VRValue_OELive] [money] ,
		[VRValue_OENonLive] [money] ,
		[VRValue_MNLive] [money] ,
		[VRValue_MNNonLive] [money] ,
		[CustID] [int]
	)

	--Step 2: Delete VRCustSetting
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) [VRCustSetting] WITH(ROWLOCK) WHERE LevelID >= @SportLevel AND CustID <> 0

		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:00.010'
	END

	--Step 3: Insert setting at sport level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #BasketBallVR_Temp

		UPDATE TOP (5000) t
		SET t.IsFinish = 1
		OUTPUT 
			 Inserted.VRValue_HDPLive
			,Inserted.VRValue_HDPNonLive
			,Inserted.CustID
		INTO #BasketBallVR_Temp(
			 VRValue_HDPLive
			,VRValue_HDPNonLive
			,CustID
		)
		FROM BasketBallVR_Temp t WITH(ROWLOCK) 
		WHERE HasSameVR = 1
			AND t.IsFinish = 0

		INSERT INTO [dbo].[VRCustSetting]
			   ([CustID]
			   ,[LevelID]
			   ,[ValueIDLIVE]
			   ,[ValueIDNonLIVE])
		SELECT t.CustID, @SportLevel
				, t.VRValue_HDPLive, t.VRValue_HDPNonLive
		FROM #BasketBallVR_Temp t WITH(NOLOCK)

		IF @@ROWCOUNT < 5000  BREAK

		WAITFOR DELAY '00:00:00.010'
	END

	--Step 4: Insert setting at bettype group level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #BasketBallVR_Temp

		UPDATE TOP (50) t
		SET t.IsFinish = 1
		OUTPUT 
			 Inserted.VRValue_HDPLive
			,Inserted.VRValue_HDPNonLive
			,Inserted.VRValue_OULive
			,Inserted.VRValue_OUNonLive
			,Inserted.VRValue_OELive
			,Inserted.VRValue_OENonLive
			,Inserted.VRValue_MNLive
			,Inserted.VRValue_MNNonLive
			,Inserted.CustID
		INTO #BasketBallVR_Temp(
			 VRValue_HDPLive
			,VRValue_HDPNonLive
			,VRValue_OULive
			,VRValue_OUNonLive
			,VRValue_OELive
			,VRValue_OENonLive
			,VRValue_MNLive
			,VRValue_MNNonLive
			,CustID
		)
		FROM BasketBallVR_Temp t WITH(ROWLOCK) 
		WHERE HasSameVR = 0
			AND t.IsFinish = 0

		IF @@ROWCOUNT = 0  BREAK

		INSERT INTO [dbo].[VRCustSetting]
			   ([CustID]
			   ,[LevelID]
			   ,[ValueIDLIVE]
			   ,[ValueIDNonLIVE])
		SELECT t.CustID
				, h.LevelID --Bettype Group Level
				, CASE  WHEN btg.GroupName = 'Handicap'   THEN t.VRValue_HDPLive
						WHEN btg.GroupName = 'Over/Under' THEN t.VRValue_OULive
						WHEN btg.GroupName = 'Odd/Even'   THEN t.VRValue_OELive
						WHEN btg.GroupName = 'Moneyline'  THEN t.VRValue_MNLive
					END
				, CASE  WHEN btg.GroupName = 'Handicap'   THEN t.VRValue_HDPNonLive
						WHEN btg.GroupName = 'Over/Under' THEN t.VRValue_OUNonLive
						WHEN btg.GroupName = 'Odd/Even'   THEN t.VRValue_OENonLive
						WHEN btg.GroupName = 'Moneyline'  THEN t.VRValue_MNNonLive
					END
		FROM #BasketBallVR_Temp t WITH(NOLOCK)
			CROSS JOIN #LevelID_BettypeGroup h
			INNER JOIN VRBettypeGroup btg WITH(NOLOCK,FORCESEEK) ON h.VRBetTypeGroupID = btg.GroupID

		WAITFOR DELAY '00:00:00.010'
	END

	--> Step 5: Insert into VRSettingManualUpdAcc
	WHILE (1=1)
	BEGIN
		INSERT INTO [dbo].VRSettingManualUpdAcc([CustID],SportType)
		SELECT TOP (5000) t.CustID, 2
		FROM BasketBallVR_Temp t
		WHERE t.IsManuallyUpdate = 1
			AND NOT EXISTS (SELECT 1 
							FROM [dbo].VRSettingManualUpdAcc v WITH(NOLOCK)
							WHERE SportType = 2 AND v.CustID = t.CustID)

		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:00.010'
	END

	DROP TABLE #BasketBallVR_Temp

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

-----------------Step 2 - run at Replication server-------------------
--Step 1: Prepare LevelID
DECLARE @SportLevel INT 
SELECT @SportLevel = LevelID 
FROM VRSettingHierarchy WITH(NOLOCK)
WHERE SportType = 2 AND VRLeagueGroupID = -1 AND BetType = -1

--bettype group level ID
SELECT LevelID,VRBetTypeGroupID
INTO #LevelID_BettypeGroup
FROM VRSettingHierarchy (NOLOCK)
WHERE SportType = 2
	AND BetType = -1
	AND VRBetTypeGroupID <> -1

EXEC [Acc_custsetting_19] 
	@SportLevel  = @SportLevel,
	@target = 'REPLICATED'

DROP TABLE #LevelID_BettypeGroup
GO

-----------------Step 3 - run at DBCUST server-------------------
--Step 1: Prepare LevelID
DECLARE @SportLevel INT 
SELECT @SportLevel = LevelID 
FROM VRSettingHierarchy WITH(NOLOCK)
WHERE SportType = 2 AND VRLeagueGroupID = -1 AND BetType = -1

--bettype group level ID
SELECT LevelID,VRBetTypeGroupID
INTO #LevelID_BettypeGroup
FROM VRSettingHierarchy (NOLOCK)
WHERE SportType = 2
	AND BetType = -1
	AND VRBetTypeGroupID <> -1

EXEC [Acc_custsetting_19] 
	@SportLevel  = @SportLevel,
	@target = 'DBCUST'

DROP TABLE #LevelID_BettypeGroup
GO
