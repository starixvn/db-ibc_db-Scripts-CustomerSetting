/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*  
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBCUST/CustDB 
 */
USE CustDB
GO  

/*************PLEASE RUN SCRIPT INSERT TABLE _UAT FIRST BEFORE RUNNING THIS SCRIPT*************/

/*Merge ProductSettingProfile_UAT to ProductSettingProfile for inserted/updated records*/
MERGE INTO ProductSettingProfile AS target
USING (SELECT ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime 
    FROM ProductSettingProfile_UAT WHERE ProductSettingID IN (228,332,331,368,209,385,386,387)) AS source
	ON target.ProductSettingID = source.ProductSettingID
WHEN MATCHED THEN
	UPDATE SET 
		target.SettingType = source.SettingType,
		target.SportType = source.SportType,
		target.BetType = source.BetType,
		target.IsLive = source.IsLive,
		target.ProductID = source.ProductID,
		target.MaxPT = source.MaxPT,
		target.MaxDiscount = source.MaxDiscount,
		target.IsSync = source.IsSync,
		target.IsHidden = source.IsHidden,
		target.IsDisabled = source.IsDisabled,
		target.SettingLevel = source.SettingLevel,
		target.DisplayOrder = source.DisplayOrder,
		target.SettingStatus = source.SettingStatus,
		target.IntervalValue = source.IntervalValue,
		target.RealProductId = source.RealProductId,
		target.MaxChoice = source.MaxChoice,
		target.Parent_ProductSettingID = source.Parent_ProductSettingID,
		target.Child_DisplayOrder = source.Child_DisplayOrder,
		target.SubType = source.SubType,
		target.GroupID = source.GroupID,
		target.GroupType = source.GroupType,
		target.GroupTypeOrder = source.GroupTypeOrder,
		target.SubGroupID = source.SubGroupID,
		target.SubGroupOrder = source.SubGroupOrder,
		target.CreationStatus = source.CreationStatus,
		target.DisplayType = source.DisplayType,
		target.MarketType = source.MarketType,
		target.OfferType = source.OfferType,
		target.RepUpdateTime = dbo.f_GetDateTime2()
WHEN NOT MATCHED BY TARGET THEN
	INSERT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime)
	VALUES (source.ProductSettingID, source.SettingType, source.SportType, source.BetType, source.IsLive, source.ProductID, source.MaxPT, source.MaxDiscount, source.IsSync, source.IsHidden, source.IsDisabled, source.SettingLevel, source.DisplayOrder, source.SettingStatus, source.IntervalValue, source.RealProductId, source.MaxChoice, source.Parent_ProductSettingID, source.Child_DisplayOrder, source.SubType, source.GroupID, source.GroupType, source.GroupTypeOrder, source.SubGroupID, source.SubGroupOrder, source.CreationStatus, source.DisplayType, source.MarketType, source.OfferType, dbo.f_GetDateTime2());


/*Remove setting IBCBet Live Casino*/
DELETE FROM ProductSettingProfile WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, dbo.f_GetDateTime2()
INTO dbo.ProductSettingProfile_Del_InHouse(ProductSettingID, RepUpdateTime)
WHERE SportType = 242; 

PRINT 'Merge ProductSettingProfile completed';



/*Merge ProductProfileSiteCurrency_UAT to ProductProfileSiteCurrency for inserted/updated records*/
MERGE INTO ProductProfileSiteCurrency AS target
USING (SELECT siteid, Currency, ProductSettingID, RepUpdateTime FROM ProductProfileSiteCurrency_UAT 
        WHERE ProductSettingID IN (385,386,387,332,331,228)) AS source
	ON target.siteid = source.siteid AND target.ProductSettingID = source.ProductSettingID
WHEN MATCHED THEN
	UPDATE SET 
		target.Currency = source.Currency,
		target.RepUpdateTime = dbo.f_GetDateTime2()
WHEN NOT MATCHED BY TARGET THEN
	INSERT (siteid, Currency, ProductSettingID, RepUpdateTime)
	VALUES (source.siteid, source.Currency, source.ProductSettingID, dbo.f_GetDateTime2());


/*Remove setting IBCBet Live Casino*/
DELETE FROM ProductProfileSiteCurrency WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, DELETED.siteid, DELETED.Currency, dbo.f_GetDateTime2()
INTO dbo.ProductProfileSiteCurrency_Del_InHouse(ProductSettingID, siteid, Currency, RepUpdateTime)
WHERE ProductSettingID IN (92,209,220)


PRINT 'Merge ProductProfileSiteCurrency completed';