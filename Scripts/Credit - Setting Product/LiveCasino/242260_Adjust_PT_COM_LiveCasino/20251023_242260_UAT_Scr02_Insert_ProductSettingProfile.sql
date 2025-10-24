/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*  
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBCUST/CustDB 
 */
USE CustDB
GO  

DELETE ProductSettingProfile_UAT;
INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime)
SELECT ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, dbo.f_GetDateTime2()
FROM ProductSettingProfile WITH (NOLOCK);

/*PT - Live Casino 1*/
INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime) 
VALUES (385, 18, 9916, 2400, 0, 41, 90, 0, 0, 1, 0, 2, 3, 0, NULL, 41, NULL, 330, 1, NULL, 3, 153, 3, 12, 1, 0, 2, 1, 0, dbo.f_GetDateTime2());
/*PT - Live Casino 2*/
INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime) 
VALUES (386, 18, 9917, 2400, 0, 41, 90, 0, 0, 1, 0, 2, 3, 0, NULL, 41, NULL, 330, 1, NULL, 3, 153, 3, 13, 1, 0, 2, 1, 0, dbo.f_GetDateTime2());

/*Comm - Live Casino 1*/
INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime) 
VALUES (387, 19, 9916, 2400, 0, 41, 0, 0.008, 0, 1, 0, 2, 2, 0, 0.0005, 41, NULL, 330, 1, NULL, 3, 156, 2, 14, 1, 0, 2, 1, 0, dbo.f_GetDateTime2());
/*Comm - Live Casino 2*/
INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime) 
VALUES (388, 19, 9917, 2400, 0, 41, 0, 0.008, 0, 1, 0, 2, 2, 0, 0.0005, 41, NULL, 330, 1, NULL, 3, 156, 2, 15, 1, 0, 2, 1, 0, dbo.f_GetDateTime2());

INSERT INTO ProductSettingProfile_UAT (ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime, OfferType) 
VALUES (389, 18, 9906, 4001, 0, 53, 90, 0.01, 0, 1, 0, 2, 3, 0, NULL, 53, NULL, NULL, 2, NULL, 3, 153, 3, 11, 1, 0, 2, 1, dbo.f_GetDateTime2(), 0);


SELECT ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, OfferType, RepUpdateTime
FROM ProductSettingProfile_UAT 
WHERE SettingType IN (18, 19) AND SportType IN (9916, 9917) AND BetType = 2400 AND ProductID = 41;


DELETE ProductProfileSiteCurrency_UAT;
INSERT INTO ProductProfileSiteCurrency_UAT(siteid, Currency, ProductSettingID, RepUpdateTime)
SELECT siteid, Currency, ProductSettingID, dbo.f_GetDateTime2()
FROM ProductProfileSiteCurrency WITH (NOLOCK);


/*MBC*/

INSERT INTO ProductProfileSiteCurrency_UAT(siteid, Currency, ProductSettingID, RepUpdateTime)
SELECT siteid, 0 AS Currency, psp.ProductSettingID, dbo.f_GetDateTime2() AS RepUpdateTime
FROM ProductSettingProfile_UAT AS psp WITH (NOLOCK) 
    CROSS JOIN (select Site, siteid, SiteLabel
					from site with (nolock) 
					where SiteLabel in ('MBC') and isLicensee = 0 and isActive = 1) AS si
WHERE 
    psp.ProductSettingID IN (385,386,387,388,389);
    /*ProductID = 41 
    AND BetType = 2400 
    AND SportType IN (9916,9917);*/


/*'789y','IBC'*/


INSERT INTO ProductProfileSiteCurrency_UAT(siteid, Currency, ProductSettingID, RepUpdateTime)
SELECT siteid, 0 AS Currency, psp.ProductSettingID, dbo.f_GetDateTime2() AS RepUpdateTime
FROM ProductSettingProfile_UAT AS psp WITH (NOLOCK) 
    CROSS JOIN (select Site, siteid, SiteLabel
					from site with (nolock) 
					where SiteLabel in ('789y','IBC') and isLicensee = 0 and isActive = 1) AS si
WHERE 
    psp.ProductSettingID IN (331,332,228);
    /*ProductID = 41 
    AND BetType = 2400 
    AND SportType IN (9911)
    AND SettingType in (18,19);*/


SELECT siteid, Currency, ProductSettingID, RepUpdateTime 
FROM ProductProfileSiteCurrency_UAT WITH (NOLOCK)
WHERE ProductSettingID in (385,386,387,388);

/*Update Parent_ProductSettingID*/
UPDATE ProductSettingProfile_UAT WITH (ROWLOCK)
SET 
    Parent_ProductSettingID = 330,
    MarketType = 1,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE SettingType in (18,19) and SportType = 9911 and BetType = 2400 and ProductID = 41;


UPDATE ProductSettingProfile_UAT WITH (ROWLOCK)
SET
    MarketType = 1,
    RepUpdateTime = dbo.f_GetDateTime2()
WHERE ProductSettingID IN (228);