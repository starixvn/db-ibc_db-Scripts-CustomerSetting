/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: Inital Data Setting Product Profile  [#193083]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	-------------------------1.ProductSettingProfile------------------------------------
	-- 1.1 : Remove Old Setting SportsBook , SportsBook2
	DELETE psdu
	FROM ProductSettingDetail psdu WITH (ROWLOCK)

	-- 1.2 : Sync data From UAT
	INSERT INTO ProductSettingDetail
	(
		SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , ProductSettingID
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	)
	SELECT
		SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , ProductSettingID
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	FROM ProductSettingDetail_UAT WITH (NOLOCK)


	-------------------------2.ProductSettingProfile------------------------------------
	-- 2.1 : Remove Old Setting SportsBook , SportsBook2
	DELETE psdu
	FROM ProductSettingProfile psdu WITH (ROWLOCK)

	-- 2.2 : Sync data From UAT
	INSERT INTO ProductSettingProfile
	(
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	)
	SELECT 
		ProductSettingID
	    , SettingType
	    , SportType
	    , BetType
	    , IsLive
	    , ProductID
	    , MaxPT
	    , MaxDiscount
	    , IsSync
	    , IsHidden
	    , IsDisabled
	    , SettingLevel
	    , DisplayOrder
	    , SettingStatus
	    , IntervalValue
	    , RealProductId
	    , MaxChoice
	    , Parent_ProductSettingID
	    , Child_DisplayOrder
	    , SubType
	    , GroupID
	    , GroupType
	    , GroupTypeOrder
	    , SubGroupID
	    , SubGroupOrder
	    , CreationStatus
	    , DisplayType
	    , MarketType
	FROM ProductSettingProfile_UAT pspu WITH (NOLOCK)


	-- 2.3 : Remove Setting Profile Redundant FW & GDG
	DELETE psp
	FROM dbo.ProductSettingProfile psp WITH (ROWLOCK)
	WHERE psp.SportType IN (236,219)

	-------------------------3.ProductProfileSiteCurrency------------------------------------

	--> Step 3.1: Clear Old Data:
		DELETE FROM ProductProfileSiteCurrency WITH (ROWLOCK)

	--> Step 2.2: Sync Data UAT
		INSERT INTO ProductProfileSiteCurrency (SiteID , Currency , ProductSettingID)
		SELECT SiteID , Currency , ProductSettingID
		FROM ProductProfileSiteCurrency_UAT WITH (NOLOCK)




















