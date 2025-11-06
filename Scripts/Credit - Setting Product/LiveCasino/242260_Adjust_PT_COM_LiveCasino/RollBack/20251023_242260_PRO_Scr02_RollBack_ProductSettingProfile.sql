/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*  
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBCUST/CustDB 
 */
USE CustDB
GO  

DELETE FROM ProductSettingProfile WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, dbo.f_GetDateTime2()
INTO dbo.ProductSettingProfile_Del_InHouse(ProductSettingID, RepUpdateTime)
WHERE ProductSettingID IN (332,331,228,368,92,209,220,385, 386, 387);

INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (92, 7, 242, 3201, 0, 41, 90, 0.01, 0, 1, 0, 2, 6, 0, NULL, 41, NULL, NULL, 15, NULL, 3, 158, 5, NULL, NULL, 0, 1, 0, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (209, 18, 242, 3201, 0, 41, 90, 0.01, 0, 1, 0, 2, 3, 0, NULL, 41, NULL, NULL, 4, NULL, 3, 153, 3, 8, 3, 0, 2, 1, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (228, 18, 9906, 4001, 0, 53, 90, 0.01, 0, 1, 0, 2, 3, 0, NULL, 53, NULL, NULL, 2, NULL, 3, 153, 3, 6, 1, 0, 2, 0, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (331, 18, 9911, 2400, 0, 41, 90, 0.01, 0, 1, 0, 2, 3, 0, NULL, 41, NULL, NULL, 1, NULL, 3, 153, 3, 6, 1, 0, 2, 0, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (368, 18, 9918, 4601, 0, 53, 90, 0.01, 0, 1, 0, 2, 3, 0, NULL, 53, NULL, NULL, 3, NULL, 3, 153, 3, 5, 2, 0, 2, 0, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (220, 19, 242, 3201, 0, 41, 90, 0.007, 0, 1, 0, 2, 2, 0, 0.0005, 41, NULL, NULL, 2, NULL, 3, 156, 2, 7, 2, 0, 2, 1, dbo.f_GetDateTime2(), 0); 
INSERT INTO ProductSettingProfile (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) VALUES (332, 19, 9911, 2400, 0, 41, 90, 0.005, 0, 1, 0, 2, 2, 0, 0.0005, 41, NULL, NULL, 1, NULL, 3, 156, 2, 4, 1, 0, 2, 0, dbo.f_GetDateTime2(), 0); 



DELETE FROM ProductProfileSiteCurrency WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, DELETED.siteid, DELETED.Currency, dbo.f_GetDateTime2()
INTO dbo.ProductProfileSiteCurrency_Del_InHouse(ProductSettingID, siteid, Currency, RepUpdateTime)
WHERE ProductSettingID IN (332,331,228,368,92,209,220,385, 386, 387);
;

INSERT INTO ProductProfileSiteCurrency (SiteID,Currency,ProductSettingID,RepUpdateTime)
VALUES(487,0,209,dbo.f_GetDateTime2())
,(487,0,220,dbo.f_GetDateTime2())



/*
SELECT *
FROM ProductSettingProfile WITH (NOLOCK)
WHERE ProductSettingID IN (332,331,228,368,92,209,220,385, 386, 387);

SELECT *
FROM ProductProfileSiteCurrency WITH (NOLOCK)
WHERE ProductSettingID IN (332,331,228,368,92,209,220,385, 386, 387);


DELETE FROM ProductSettingProfile WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, dbo.f_GetDateTime2()
INTO dbo.ProductSettingProfile_Del_InHouse(ProductSettingID, RepUpdateTime)
WHERE ProductSettingID IN (385, 386, 387);


/*PT - Other RNG Casino*/
UPDATE ProductSettingProfile
SET SubGroupOrder = 2,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE ProductSettingID = 368;

/*PT - IBC Bet Live Casino*/
UPDATE ProductSettingProfile
SET SubGroupOrder = 3,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE ProductSettingID = 209;


/*Update Parent_ProductSettingID*/
UPDATE ProductSettingProfile WITH (ROWLOCK)
SET 
    Parent_ProductSettingID = NULL,
    MarketType = 0,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE ProductSettingID IN (331);


UPDATE ProductSettingProfile WITH (ROWLOCK)
SET
    MarketType = 0,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE ProductSettingID IN (228,332);


/*Remove setting IBCBet Live Casino*/
DELETE FROM ProductSettingProfile_UAT WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, dbo.f_GetDateTime2()
INTO dbo.ProductSettingProfile_UAT_Del_InHouse(ProductSettingID, RepUpdateTime)
WHERE SportType = 242; 




DELETE FROM ProductProfileSiteCurrency WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, DELETED.siteid, DELETED.Currency, dbo.f_GetDateTime2()
INTO dbo.ProductProfileSiteCurrency_Del_InHouse(ProductSettingID, siteid, Currency, RepUpdateTime)
WHERE ProductSettingID IN (385,386,387,332,331,228)
;



/*Remove setting IBCBet Live Casino*/
DELETE FROM ProductProfileSiteCurrency_UAT WITH (ROWLOCK)
OUTPUT DELETED.ProductSettingID, DELETED.siteid, DELETED.Currency, dbo.f_GetDateTime2()
INTO dbo.ProductProfileSiteCurrency_UAT_Del_InHouse(ProductSettingID, siteid, Currency, RepUpdateTime)
WHERE ProductSettingID IN (92,209,220)


*/

