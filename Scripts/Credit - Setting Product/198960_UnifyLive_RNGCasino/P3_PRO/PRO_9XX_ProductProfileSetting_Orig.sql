/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Product Profile Setting Main Table [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

-------------------------1.ProductSettingProfile------------------------------------

	-- Clear Data
	DELETE FROM ProductSettingProfile WITH (ROWLOCK)
	 
	-- Copy Data From Table UAT To Table Main
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
	FROM ProductSettingProfile_UAT WITH (NOLOCK)

	-------------------------2.ProductSettingDetail------------------------------------

	-- Clear Data
	DELETE FROM ProductSettingDetail WITH (ROWLOCK)

	-- Copy Data From Table UAT To Table Main
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
	FROM ProductSettingDetail_UAT psdu WITH (NOLOCK)