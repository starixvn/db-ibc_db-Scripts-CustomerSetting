/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Data Setting  [#193083]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	-- TRUNCATE Main Table
	TRUNCATE TABLE ProductSettingDetail_helios
	TRUNCATE TABLE ProductSettingProfile_helios
	TRUNCATE TABLE ProductProfileSiteCurrency_helios


	-- TRUNCATE UAT Table
	TRUNCATE TABLE ProductSettingDetail_UAT_helios
	TRUNCATE TABLE ProductSettingProfile_UAT_helios
	TRUNCATE TABLE ProductProfileSiteCurrency_helios_UAT

	-- Restore Main Table Profile

	INSERT INTO ProductSettingDetail_UAT_helios 
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
	SELECT * FROM ProductSettingDetail_UAT WITH (NOLOCK)


	INSERT INTO ProductSettingProfile_helios 
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
	SELECT * FROM ProductSettingProfile WITH (NOLOCK)

	INSERT INTO ProductProfileSiteCurrency_helios 
	(
		SiteID
	    , Currency
	    , ProductSettingID
	)
	SELECT * FROM ProductProfileSiteCurrency WITH (NOLOCK)

	-- Restore UAT Table Profile

	INSERT INTO ProductSettingDetail_helios 
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
	SELECT * FROM ProductSettingDetail WITH (NOLOCK)


	INSERT INTO ProductSettingProfile_UAT_helios 
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
	SELECT * FROM ProductSettingProfile_UAT WITH (NOLOCK)

	INSERT INTO ProductProfileSiteCurrency_helios_UAT 
	(
		SiteID
	    , Currency
	    , ProductSettingID
	)
	SELECT * FROM ProductProfileSiteCurrency_UAT WITH (NOLOCK)

