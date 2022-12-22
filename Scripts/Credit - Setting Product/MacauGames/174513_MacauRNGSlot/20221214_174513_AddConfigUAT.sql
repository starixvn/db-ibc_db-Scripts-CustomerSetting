/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221214
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting - Add config UAT [Redmine: 174513]
	DB:		 DBCUST/CustDB
*/ 

DECLARE @MaxProductSettingID INT
SELECT @MaxProductSettingID = (SELECT MAX(ProductSettingID) FROM ProductSettingDetail WITH(NOLOCK))
-- Insert PT
INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType, 9906 AS SportType,BetType,IsLive,18 AS ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,18 AS RealProductId,MaxChoice ,ProductSettingID = @MaxProductSettingID + 1,Parent_ProductSettingID 
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 AND SettingType = 1 AND sporttype = 212 AND bettype = 4001

INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType, 9906 AS SportType,BetType,IsLive,18 AS ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,18 AS RealProductId,MaxChoice ,ProductSettingID = @MaxProductSettingID + 2,Parent_ProductSettingID 
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 AND SettingType = 6 AND sporttype = 212 AND bettype = 4001
