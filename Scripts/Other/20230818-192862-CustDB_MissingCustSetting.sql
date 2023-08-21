/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230818@Tacy
	Task : Missing setting for some new account
		https://nexdev.net/issues/192862
	DB: DBCUST-CustDB and all replicated servers
*/
/*
	Agents: 95259461, 95259466
	Memebers: 95259740, 95326765
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09] 	 
	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('CustBetSetting_Agent') = 0
		OR dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0	
		OR dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0		 		 
		OR dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0		 		 
		OR dbo.f_CheckRepTable('CustBetSetting_Member') = 0
		OR dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0	
		OR dbo.f_CheckRepTable('CustStakeLevel_Member') = 0		 		 
		OR dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0		
		OR dbo.f_CheckRepTable('Customer') = 0	
		OR dbo.f_CheckRepTable('ProductSettingDetail') = 0		 		 
		)
	RETURN
	
	CREATE TABLE #ProductSettingType ( 
					Sporttype SMALLINT,
					Bettype SMALLINT,
					SettingType TINYINT,
					PRIMARY KEY([SettingType] ASC,[SportType] ASC,[BetType] ASC)
				)

	CREATE TABLE #tblCust ( CustID INT,
							UplineID INT,
							RoleID TINYINT,
							Sporttype SMALLINT,
							Bettype SMALLINT,
							SettingType TINYINT
						)

	--------------------------------------------------------------------------------
	INSERT INTO #ProductSettingType (Sporttype, Bettype, SettingType)
	SELECT SportType, BetType, P.SettingType
	FROM ProductSettingDetail p WITH (NOLOCK)
	WHERE (SettingType in (9,16,20,23)	--bet setting
			or SettingType in (7,8,17)	--stakelevel
			or SettingType in (6,12,22))--winlosslimit
		AND SettingStatus=0

	INSERT INTO #tblCust (CustID, UplineID, RoleID, Sporttype, Bettype, SettingType)
	SELECT custid, mrecommend, roleid, t.Sporttype, t.Bettype, t.SettingType
	FROM Customer WITH (NOLOCK)
	CROSS APPLY (SELECT Sporttype, Bettype, SettingType FROM #ProductSettingType) T
	WHERE custid IN (95259461, 95259466)	--Agent
	UNION
	SELECT custid, recommend, roleid, t.Sporttype, t.Bettype, t.SettingType
	FROM Customer WITH (NOLOCK)
	CROSS APPLY (SELECT Sporttype, Bettype, SettingType FROM #ProductSettingType) T
	WHERE custid IN (95259740, 95326765)	--Memeber
	
	--Bet Setting: SettingType IN (23)
	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustBetSetting_Agent c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (23) AND c.CustID IS NULL AND t.RoleID=2)
	BEGIN
		INSERT INTO CustBetSetting_Agent ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch], [MaxPerNumber], [MaxPayoutPerMatch])
		SELECT t.[CustID], t.[SportType], t.[BetType], up.[MinBet], up.[MaxBet], up.[MaxPerMatch], up.[MaxPerNumber], up.[MaxPayoutPerMatch]
		FROM #tblCust t 
			INNER JOIN CustBetSetting_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustBetSetting_Agent c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (23) AND c.CustID IS NULL AND t.RoleID=2
	END

	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustBetSetting_Member c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (23) AND c.CustID IS NULL AND t.RoleID=1)
	BEGIN
		INSERT INTO CustBetSetting_Member ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch], [MaxPerNumber], [MaxPayoutPerMatch])
		SELECT t.[CustID], t.[SportType], t.[BetType], up.[MinBet], up.[MaxBet], up.[MaxPerMatch], up.[MaxPerNumber], up.[MaxPayoutPerMatch]
		FROM #tblCust t 
			INNER JOIN CustBetSetting_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustBetSetting_Member c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (23) AND c.CustID IS NULL AND t.RoleID=1
	END

	--Bet setting 3rd
	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustBetSetting3rd_Agent c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (9,16,20,23) AND c.CustID IS NULL AND t.RoleID=2)
	BEGIN
		INSERT INTO CustBetSetting3rd_Agent ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
		SELECT t.[CustID], t.[SportType], t.[BetType], up.[MinBet], up.[MaxBet], up.[MaxPerMatch]
		FROM #tblCust t 
			INNER JOIN CustBetSetting3rd_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustBetSetting3rd_Agent c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (9,16,20,23) AND c.CustID IS NULL AND t.RoleID=2
	END

	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustBetSetting3rd_Member c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (9,16,20,23) AND c.CustID IS NULL AND t.RoleID=1)
	BEGIN
		INSERT INTO CustBetSetting3rd_Member ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
		SELECT t.[CustID], t.[SportType], t.[BetType], up.[MinBet], up.[MaxBet], up.[MaxPerMatch]
		FROM #tblCust t 
			INNER JOIN CustBetSetting3rd_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustBetSetting3rd_Member c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (9,16,20,23) AND c.CustID IS NULL AND t.RoleID=1
	END

	--StakeLevel
	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustStakeLevel_Agent c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (7,8,17) AND c.CustID IS NULL AND t.RoleID=2)
	BEGIN
		INSERT INTO CustStakeLevel_Agent ([CustID], [SportType], [BetType], [StakeLevelList])
		SELECT t.[CustID], t.[SportType], t.[BetType], up.[StakeLevelList]
		FROM #tblCust t 
			INNER JOIN CustStakeLevel_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustStakeLevel_Agent c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (7,8,17) AND c.CustID IS NULL AND t.RoleID=2
	END

	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustStakeLevel_Member c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (7,8,17) AND c.CustID IS NULL AND t.RoleID=1)
	BEGIN
		INSERT INTO CustStakeLevel_Member ([CustID], [SportType], [BetType], [StakeLevelList])
		SELECT t.[CustID], t.[SportType], t.[BetType], ISNULL(sr.LowestStakeLevel, '')
		FROM #tblCust t 
			INNER JOIN CustStakeLevel_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			OUTER APPLY ( --get LowestStakeLevel
						SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
						FROM (
							SELECT	CAST(value AS INT) AS val
							FROM	STRING_SPLIT(up.StakeLevelList, ',')
						) AS ss
						INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
								ON	ss.val = sl.StakeLevelID
						ORDER BY	sl.MaxStake, sl.MinStake, sl.GameGroupID
					) sr
			LEFT JOIN CustStakeLevel_Member c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (7,8,17) AND c.CustID IS NULL AND t.RoleID=1
	END
	
	--WinLossLimit
	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustWinLossLimit_Agent c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (6,12,22) AND c.CustID IS NULL AND t.RoleID=2)
	BEGIN
		INSERT INTO CustWinLossLimit_Agent ([CustId], [SportType], [BetType], [MaxWinLimit], [MaxLossLimit], [IsAutoReset])
		SELECT t.[CustId], t.[SportType], t.[BetType], up.[MaxWinLimit], up.[MaxLossLimit], up.[IsAutoReset]
		FROM #tblCust t 
			INNER JOIN CustWinLossLimit_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustWinLossLimit_Agent c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (6,12,22) AND c.CustID IS NULL AND t.RoleID=2
	END
	
	IF EXISTS (SELECT TOP 1 1 FROM #tblCust t 
				LEFT JOIN CustWinLossLimit_Member c WITH (NOLOCK) 
							ON c.CustID=t.CustID
							AND c.SportType=t.Sporttype
							AND c.BetType=t.Bettype
				WHERE t.SettingType IN (6,12,22) AND c.CustID IS NULL AND t.RoleID=1)
	BEGIN
		INSERT INTO CustWinLossLimit_Member([CustId], [SportType], [BetType], [MaxWinLimit], [MaxLossLimit], [IsAutoReset])
		SELECT t.[CustId], t.[SportType], t.[BetType], up.[MaxWinLimit], up.[MaxLossLimit], up.[IsAutoReset]
		FROM #tblCust t 
			INNER JOIN CustWinLossLimit_Agent up WITH (NOLOCK) 
						ON up.CustID=t.UplineID
						AND up.SportType=t.Sporttype
						AND up.BetType=t.Bettype	
			LEFT JOIN CustWinLossLimit_Member c WITH (NOLOCK) 
						ON c.CustID=t.CustID
						AND c.SportType=t.Sporttype
						AND c.BetType=t.Bettype	
			WHERE t.SettingType IN (6,12,22) AND c.CustID IS NULL AND t.RoleID=1
	END
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.bodb_Licensee --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 'REPLICATED'
GO

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 'DBCUST'
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------