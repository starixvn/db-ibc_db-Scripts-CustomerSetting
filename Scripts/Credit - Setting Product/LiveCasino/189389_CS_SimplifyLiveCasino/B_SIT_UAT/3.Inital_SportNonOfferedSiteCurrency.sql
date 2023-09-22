/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting  [#189389]
	DB: DBCust/CustDB
*/


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	---------------------------1.SportNonOfferedSiteCurrency------------------------------------

--> Step 1.1: Initial Data SportNonOfferedSiteCurrency

	CREATE TABLE #SportTypeBetType (
		SportType			SMALLINT,
		BetType				SMALLINT
	)

	CREATE TABLE #SportTypeBetType_NonOffer (
		SportType			SMALLINT,
		BetType				SMALLINT,
		Currency			SMALLINT,
		SiteID				SMALLINT
			PRIMARY KEY CLUSTERED (SportType ASC ,BetType ASC , Currency ASC , SiteID ASC)
	)

	-- Collect All SportType - BetType OF Live Casino from ProductSettingDetail
	INSERT INTO #SportTypeBetType (SportType , BetType )
	SELECT SportType, BetType 
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = 41
	AND SettingType = 13
	AND SettingStatus = 0					

	-- Collect All Site - Currency Of SportType - BetType Live Casino

	INSERT INTO #SportTypeBetType_NonOffer (SportType , BetType , Currency , SiteID)
	SELECT c.SportType , c.BetType , Currency , SiteID 
	FROM ProductStatusSiteCurrency c WITH (NOLOCK)
	INNER JOIN #SportTypeBetType sb ON c.SportType = sb.SportType AND c.BetType = sb.BetType
	where c.IsHidden = 1
	and sb.SportType <> 242

	-- IBC Bet offer for IBC indo onl
	INSERT INTO #SportTypeBetType_NonOffer (SportType , BetType , Currency , SiteID)
	SELECT  242 as SportType , 3201 as BetType ,0 as Currency , s.SiteID  
	FROM SITE s WITH (NOLOCK) 
	WHERE isLicensee = 0 	AND isDeposit = 0 	AND isActive = 1 AND SiteID <> 487

	--select * from #SportTypeBetType

	--select * from #SportTypeBetType_NonOffer

	------ DELETE OLD Data SportNonOfferedSiteCurrency
	DELETE nonOff
	FROM SportNonOfferedSiteCurrency nonOff WITH (NOLOCK)
	INNER JOIN #SportTypeBetType_NonOffer tem ON nonOff.SportType = tem.SportType AND nonOff.BetType = tem.BetType AND nonOff.Currency = tem.Currency AND nonOff.SiteID = tem.SiteID

	------ Insert New Data
	INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
	SELECT SportType , BetType , Currency , SiteID
	FROM #SportTypeBetType_NonOffer


	DROP TABLE #SportTypeBetType
	DROP TABLE #SportTypeBetType_NonOffer
	
