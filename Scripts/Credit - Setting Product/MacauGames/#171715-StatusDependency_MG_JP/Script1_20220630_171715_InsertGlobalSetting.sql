/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220630@Eden
	Task: Insert Global Setting [redmine : 171715]
	DB: DBCUST/CUSTDB
*/
-----------Insert ProductSettingType-------------
DELETE FROM ProductSettingType WITH(ROWLOCK,UPDLOCK) WHERE SettingType = 21

INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
SELECT 21, 'Product Status', 'DependencyProductStatus'

-----------Insert ProductSettingDetail-------------
DELETE
FROM ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 22 
	AND SettingType = 21

--Macau
INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType = 21,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,RealProductId,MaxChoice
	,ProductSettingID = 224,Parent_ProductSettingID 
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 
	AND SettingType = 13 
	AND sporttype = 212 
	AND bettype = 4001

--JP
INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType = 21,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,RealProductId,MaxChoice
	,ProductSettingID = 225,Parent_ProductSettingID  = 224
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 
	AND SettingType = 13 
	AND sporttype = 9904 
	AND bettype = 4001

-----------Insert MsgError-------------
DECLARE @MsgNameEN NVARCHAR(500) = N'You cannot Enable {ChildSport} when {ParentSport} is Disabled.'

DELETE FROM MsgError WITH(ROWLOCK,UPDLOCK) WHERE MsgID = 60037

INSERT INTO MsgError(
	 MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameJP
	,MsgNameTH
	,MsgNameKO
	,MsgNameES
	,MsgNameVI
	,IsActive
	,MsgNameCN
)
SELECT MsgID = 60037
	,MsgGroupID = 7
	,MsgNameEN	= @MsgNameEN
	,MsgNameCT	= @MsgNameEN
	,MsgNameCS	= @MsgNameEN
	,MsgNameJP	= @MsgNameEN
	,MsgNameTH	= @MsgNameEN
	,MsgNameKO	= @MsgNameEN
	,MsgNameES	= @MsgNameEN
	,MsgNameVI	= @MsgNameEN
	,IsActive	= 1
	,MsgNameCN	= @MsgNameEN

-------ProductSettingSystemDisplay
DELETE t
FROM dbo.ProductSettingSystemDisplay t WITH(ROWLOCK)
WHERE ProductID = 22
	AND SettingType = 21

INSERT INTO ProductSettingSystemDisplay (SystemID,ProductID,SettingType,DisplayMode)
SELECT SystemID,ProductID,SettingType = 21,DisplayMode 
FROM dbo.ProductSettingSystemDisplay WITH(NOLOCK)
WHERE ProductID = 22
	AND SettingType = 13
/*
SELECT *
FROM ProductSettingType WITH(NOLOCK) 
WHERE SettingType = 21

SELECT *
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 
	AND SettingType IN(13,21) 

SELECT *
FROM MsgError WITH(NOLOCK) 
WHERE MsgID = 60037

UPDATE t
SET t.settingstatus = 0
FROM ProductSettingDetail t WITH(NOLOCK) 
WHERE ProductID = 22 
	AND SettingType = 21

SELECT *
FROM dbo.ProductSettingSystemDisplay t WITH(NOLOCK)
WHERE ProductID = 22
	AND SettingType IN(13,21)
*/