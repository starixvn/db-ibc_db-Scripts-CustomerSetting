/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250415@Elodie
	Task: Alpha - Agency Cash Service - modified Structure [#223896] 
	DB: DBCust/CustDB 
*/
USE CustDB
GO

DELETE FROM ProductSettingProfile WHERE ProductSettingID BETWEEN 377 AND 381

DECLARE @ProductSettingID INT 
SELECT @ProductSettingID = 376

INSERT INTO ProductSettingProfile ([ProductSettingID], [SettingType], [SportType],[BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], [SettingStatus], [IntervalValue], [RealProductId], [MaxChoice], [Parent_ProductSettingID], [Child_DisplayOrder], [SubType], [GroupID], [GroupType], [GroupTypeOrder], [SubGroupID], [SubGroupOrder], [CreationStatus], [DisplayType], [MarketType], [RepUpdateTime], [OfferType])
SELECT CASE WHEN SportType = 9906 THEN @ProductSettingID + 1
			WHEN SportType = 9908 THEN @ProductSettingID + 2
			WHEN SportType = 9909 THEN @ProductSettingID + 3
			WHEN SportType = 9911 THEN @ProductSettingID + 4
			WHEN SportType = 9918 THEN @ProductSettingID + 5 END,
	29, [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden], [IsDisabled], [SettingLevel], [DisplayOrder], [SettingStatus], [IntervalValue], [RealProductId], [MaxChoice], [Parent_ProductSettingID], [Child_DisplayOrder], [SubType], [GroupID], 161, [GroupTypeOrder], [SubGroupID], [SubGroupOrder], [CreationStatus], [DisplayType], [MarketType], dbo.f_GetDateTime2(), 2
FROM ProductSettingProfile
where settingType IN (6,22) AND settingStatus <> 2