/*
	Creator: 20200615@Eden
	Task: Insert VRCustSetting - Redmine: #134978
		Step 1: Prepare LevelID
		Step 2: Delete VRCustSetting
		Step 3: Insert setting at sport level
		Step 4: Insert setting at bettype group level
		Step 5: Insert VRSettingManualUpdAcc
	Run at: CustDB@DBCUST 
*/
USE CustDB
GO
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
		
	--Step 2: Delete VRCustSetting
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) [VRCustSetting] WITH(ROWLOCK) WHERE LevelID >= @SportLevel AND CustID <> 0

		IF @@ROWCOUNT < 5000
			BREAK
	END

	--Step 3: Insert setting at sport level
	WHILE (1=1)
	BEGIN
		INSERT INTO [dbo].[VRCustSetting]
			   ([CustID]
			   ,[LevelID]
			   ,[ValueIDLIVE]
			   ,[ValueIDNonLIVE])
		SELECT TOP (5000) t.CustID, @SportLevel
				, t.VRValue_HDPLive, t.VRValue_HDPNonLive
		FROM BasketBallVR_Temp t WITH(NOLOCK)
		WHERE t.HasSameVR = 1
			AND NOT EXISTS (SELECT 1 
							FROM [dbo].[VRCustSetting] v WITH(NOLOCK)
							WHERE v.LevelID >= @SportLevel AND v.CustID = t.CustID)

		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:03'
	END

	--Step 4: Insert setting at bettype group level
	WHILE (1=1)
	BEGIN
		INSERT INTO [dbo].[VRCustSetting]
			   ([CustID]
			   ,[LevelID]
			   ,[ValueIDLIVE]
			   ,[ValueIDNonLIVE])
		SELECT	TOP (5000) t.CustID
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
		FROM BasketBallVR_Temp t WITH(NOLOCK)
			CROSS JOIN #LevelID_BettypeGroup h
			INNER JOIN VRBettypeGroup btg WITH(NOLOCK) ON h.VRBetTypeGroupID = btg.GroupID
		WHERE t.HasSameVR = 0
			AND NOT EXISTS (		SELECT 1 
									FROM [dbo].[VRCustSetting] vr WITH(NOLOCK)
									WHERE vr.CustID = t.CustID
										AND vr.LevelID = h.LevelID
								)
		
		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:03'
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

		WAITFOR DELAY '00:00:03'
	END

DROP TABLE #LevelID_BettypeGroup