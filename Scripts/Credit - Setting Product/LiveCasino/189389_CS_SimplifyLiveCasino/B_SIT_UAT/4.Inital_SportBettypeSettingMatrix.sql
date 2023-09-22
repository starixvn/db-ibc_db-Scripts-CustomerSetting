/*<info serverAlias="DBCUST-CustDB,DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting SportBettypeSettingMatrix in Replicate , execute manual  [#189389] 
	DB: DBCUST-CustDB,DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--> Step 6.1: Insert Missing SportType - BetType in SportBettypeSettingMatrix and Insert
	

	CREATE TABLE #tmpSportTypeBetType (
			SportType			SMALLINT,
			BetType				SMALLINT,
			isLicensee			BIT,
			isLive				BIT,
			RealProductID		TINYINT)

	CREATE TABLE #INS_SportBetTypeMatrix (
			[SportType]						[smallint] NOT NULL,
			[BetType]						[int] NOT NULL,
			[isLicensee]					[bit] NOT NULL,
			[isLive]						[bit] NOT NULL,
			[Site]							[varchar](50) NOT NULL,
			[isActive]						[bit] NOT NULL,
			[SportTypeRefPT]				[smallint] NULL,
			[BetTypeRefPT]					[int] NULL,
			[isLivePT]						[bit] NOT NULL,
			[TablePT]						[varchar](50) NULL,
			[SportTypeRefComm]				[smallint] NULL,
			[BetTypeRefComm]				[int] NULL,
			[TableComm]						[varchar](50) NULL,
			[SportTypeRefBetSetting]		[smallint] NULL,
			[BetTypeRefBetSetting]			[int] NULL,
			[TableBetSetting]				[varchar](50) NULL,
			[IsLiveComm]					[bit] NOT NULL,
			[IsLiveBetSetting]				[bit] NOT NULL,
			[TableBettrans]					[varchar](100) NULL,
			[SporttypeRefWinlossLimit]		[smallint] NULL,
			[BettypeRefWinlossLimit]		[smallint] NULL,
			[RealProductId]					[tinyint] NULL,
			[isDeleted]						[bit] NULL,
			[RepUpdateTime]					[datetime2](7) NULL,
			[ProductID]						[tinyint] NULL)

	-- Collect Data Missing  SportType - BetType
	INSERT INTO #tmpSportTypeBetType (SportType , BetType , isLicensee , isLive , RealProductID)  
	SELECT SportType , BetType , 0 , isLive , RealProductID
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = 41
	AND SettingType IN (6,12)		-- SettingType WinlostLimit
	AND SettingStatus = 0
		INSERT INTO #INS_SportBetTypeMatrix (
			[SportType],
			[BetType],
			[isLicensee],
			[isLive],
			[Site],
			[isActive],
			[SportTypeRefPT],
			[BetTypeRefPT],
			[isLivePT],
			[TablePT],
			[SportTypeRefComm],
			[BetTypeRefComm],
			[TableComm],
			[SportTypeRefBetSetting],
			[BetTypeRefBetSetting],
			[TableBetSetting],
			[IsLiveComm],
			[IsLiveBetSetting],
			[TableBettrans],
			[SporttypeRefWinlossLimit],
			[BettypeRefWinlossLimit],
			[RealProductId],
			[isDeleted],
			[RepUpdateTime],
			[ProductID])
	SELECT 
	   sb.[SportType]
      ,sb.[BetType]
      ,sb.[isLicensee]
      ,sb.[isLive]
      ,'All'						AS [Site]
      ,1 AS [isActive]
      ,sb.[SportType]				AS [SportTypeRefPT]
      ,sb.[BetType]					AS [BetTypeRefPT]
      ,0 AS [isLivePT]
      ,'CustPTSetting3rd_member'	AS [TablePT]
      ,sb.[SportType]				AS [SportTypeRefComm]
      ,sb.[BetType]					AS[BetTypeRefComm]
      ,'CustDiscount3rd_member'		AS [TableComm]
      ,sb.[SportType]				AS [SportTypeRefBetSetting]
      ,sb.[BetType]					AS [BetTypeRefBetSetting]
      ,'CustStakeLevel_member'		AS [TableBetSetting]
      ,0							AS [IsLiveComm]
      ,0							AS [IsLiveBetSetting]
      ,'bettransLC'					AS [TableBettrans]
      ,sb.[SportType]				AS [SporttypeRefWinlossLimit]
      ,sb.[BetType]					AS [BettypeRefWinlossLimit]
      ,sb.[RealProductId]
	  ,0							AS [isDeleted]
	  ,SYSDATETIME()				AS [RepUpdateTime]
      ,41							AS [ProductID]
	FROM #tmpSportTypeBetType sb
	LEFT JOIN SportBettypeSettingMatrix sb_matrix WITH (NOLOCK)
		ON sb.SportType = sb_matrix.SportType AND sb.BetType = sb_matrix.BetType AND sb.isLicensee = sb_matrix.isLicensee
	WHERE sb_matrix.SportType IS NULL

	-- Insert Missing SportType - BetType
	IF EXISTS (SELECT 1 FROM #INS_SportBetTypeMatrix)
	BEGIN
		INSERT INTO [dbo].[SportBettypeSettingMatrix]
			   ([SportType]
			   ,[BetType]
			   ,[isLicensee]
			   ,[isLive]
			   ,[Site]
			   ,[isActive]
			   ,[SportTypeRefPT]
			   ,[BetTypeRefPT]
			   ,[isLivePT]
			   ,[TablePT]
			   ,[SportTypeRefComm]
			   ,[BetTypeRefComm]
			   ,[TableComm]
			   ,[SportTypeRefBetSetting]
			   ,[BetTypeRefBetSetting]
			   ,[TableBetSetting]
			   ,[IsLiveComm]
			   ,[IsLiveBetSetting]
			   ,[TableBettrans]
			   ,[SporttypeRefWinlossLimit]
			   ,[BettypeRefWinlossLimit]
			   ,[RealProductId]
			   ,[isDeleted]
			   ,[RepUpdateTime]
			   ,[ProductID])
		SELECT * FROM #INS_SportBetTypeMatrix
	END


	-- Update Ref Winloss Limit setting for testing UAT
	UPDATE mt 
		SET SporttypeRefWinlossLimit	= 9911
		  , BettypeRefWinlossLimit		= 2400
		  ,	RepUpdateTime				= SYSDATETIME ()
	FROM SportBettypeSettingMatrix mt WITH(ROWLOCK)  
	INNER JOIN #tmpSportTypeBetType sb ON mt.SportType = sb.SportType AND mt.BetType = sb.BetType AND mt.isLicensee = sb.isLicensee
	WHERE mt.Site = 'All'

	-- Update RealProductId for SportBettypeSettingMatrix From SportBettypeMatrix (DBTXN.bodb02)

	UPDATE sbtmp
		SET RealProductID = sbm.ProductID
	FROM  DBTXN.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
	INNER JOIN #tmpSportTypeBetType sbtmp 
	ON sbm.SportType = sbtmp.SportType 
	AND sbm.BetType = sbtmp.BetType 
	AND sbm.IsLive = sbtmp.isLive

	--SELECT * FROM #tmpSportTypeBetType

	UPDATE mt
		SET mt.RealProductId  = tmp.RealProductID
		,	ProductID		  = 41
		,	RepUpdateTime	  = SYSDATETIME ()
	FROM SportBettypeSettingMatrix mt WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #tmpSportTypeBetType tmp 
		ON mt.SportType = tmp.SportType 
	   AND mt.BetType = tmp.BetType 
	   AND mt.isLicensee = tmp.isLicensee
	   WHERE mt.Site = 'All'
	
	DROP TABLE #INS_SportBetTypeMatrix
	DROP TABLE #tmpSportTypeBetType




	

