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
	-- CleanUp Main Table
	DELETE FROM ProductSettingDetail
	DELETE FROM ProductSettingProfile
	DELETE FROM ProductProfileSiteCurrency


	-- CleanUp UAT Table
	DELETE FROM ProductSettingDetail_UAT
	DELETE FROM ProductSettingProfile_UAT
	DELETE FROM ProductProfileSiteCurrency_UAT

	-- Restore Main Table Profile

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
	SELECT * FROM ProductSettingDetail_helios WITH (NOLOCK)


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
	SELECT * FROM ProductSettingProfile_helios WITH (NOLOCK)

	INSERT INTO ProductProfileSiteCurrency 
	(
		SiteID
	    , Currency
	    , ProductSettingID
	)
	SELECT * FROM ProductProfileSiteCurrency_helios WITH (NOLOCK)

	-- Restore UAT Table Profile

	INSERT INTO ProductSettingDetail_UAT 
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
	SELECT * FROM ProductSettingDetail_UAT_helios WITH (NOLOCK)


	INSERT INTO ProductSettingProfile_UAT 
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
	SELECT * FROM ProductSettingProfile_UAT_helios WITH (NOLOCK)

	INSERT INTO ProductProfileSiteCurrency_UAT 
	(
		SiteID
	    , Currency
	    , ProductSettingID
	)
	SELECT * FROM ProductProfileSiteCurrency_UAT_helios ppscuh WITH (NOLOCK)

