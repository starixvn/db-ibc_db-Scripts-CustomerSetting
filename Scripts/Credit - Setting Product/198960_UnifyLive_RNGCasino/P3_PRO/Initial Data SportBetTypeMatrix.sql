/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting SportBetTypeMatrix [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	-- Move FGG From Virtual Games (64) to LiveCasino (41)
	IF NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix WITH (NOLOCK) 
					WHERE isLicensee = 0 
					AND Site = 'ALL' 
					AND isDeleted = 0
					AND SportType = 176
					AND BetType = 8201
			   )
	BEGIN
		
		UPDATE sb 
			SET SporttypeRefWinlossLimit = 9911 , BettypeRefWinlossLimit = 2400 , ProductID = 41 , RepUpdateTime = SYSDATETIME ()
		FROM SportBettypeSettingMatrix sb WITH (ROWLOCK , UPDLOCK) 
		WHERE isLicensee = 0 
		AND Site = 'ALL' 
		AND isDeleted = 0
		AND SportType = 176
		AND BetType = 8201
	END

	-- Init RNG Casino , Other RNG Casino
	IF NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix WITH (NOLOCK) 
					WHERE isLicensee = 0 
					AND Site = 'ALL' 
					AND isDeleted = 0
					AND SportType IN (9906,9918)
					AND BetType IN (4001,4601)
			   )
	BEGIN
		INSERT INTO SportBettypeSettingMatrix
		(
			SportType
			, BetType
			, isLicensee
			, isLive
			, Site
			, isActive
			, SportTypeRefPT
			, BetTypeRefPT
			, isLivePT
			, TablePT
			, SportTypeRefComm
			, BetTypeRefComm
			, TableComm
			, SportTypeRefBetSetting
			, BetTypeRefBetSetting
			, TableBetSetting
			, IsLiveComm
			, IsLiveBetSetting
			, TableBettrans
			, SporttypeRefWinlossLimit
			, BettypeRefWinlossLimit
			, RealProductId
			, isDeleted
			, RepUpdateTime
			, ProductID
		)
		-- RNG Casino
		SELECT
			9906  AS SportType
		    , 4001  AS BetType
		    , 0     AS isLicensee
		    , 0     AS isLive
		    , 'All' AS Site
		    , 0     AS isActive
		    , 9906  AS SportTypeRefPT
		    , 4001  AS BetTypeRefPT
		    , 0     AS isLivePT
		    , ''    AS TablePT
		    , 9906  AS SportTypeRefComm
		    , 4001  AS BetTypeRefComm
		    , ''    AS TableComm
		    , 9906  AS SportTypeRefBetSetting
		    , 4001  AS BetTypeRefBetSetting
		    , ''    AS TableBetSetting
		    , 0     AS IsLiveComm
		    , 0     AS IsLiveBetSetting
		    , ''    AS TableBettrans
		    , 9906  AS SporttypeRefWinlossLimit
		    , 4001  AS BettypeRefWinlossLimit
		    , 53    AS RealProductId
		    , 0     AS isDeleted
		    , 53    AS ProductID
		UNION ALL

		-- Other RNG Casino
		SELECT
			9918  AS SportType
		    , 4601  AS BetType
		    , 0     AS isLicensee
		    , 0     AS isLive
		    , 'All' AS Site
		    , 0     AS isActive
		    , 9918  AS SportTypeRefPT
		    , 4601  AS BetTypeRefPT
		    , 0     AS isLivePT
		    , ''    AS TablePT
		    , 9918  AS SportTypeRefComm
		    , 4601  AS BetTypeRefComm
		    , ''    AS TableComm
		    , 9918  AS SportTypeRefBetSetting
		    , 4601  AS BetTypeRefBetSetting
		    , ''    AS TableBetSetting
		    , 0     AS IsLiveComm
		    , 0     AS IsLiveBetSetting
		    , ''    AS TableBettrans
		    , 9918  AS SporttypeRefWinlossLimit
		    , 4601  AS BettypeRefWinlossLimit
		    , 53    AS RealProductId
		    , 0     AS isDeleted
		    , 53    AS ProductID  
	END