/*
	Created: 20191023@Winnie
	Task: Insert product profile for Spadegaming Deposit
	DB: DBCUST/CustDB
*/
USE [CustDB]
Go

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES 
	--Status
	(29,36,4,0,1,1)
	-- PT
	,(30,36,1,0,2,1)
	-- Stakelevel group
	,(31,36,8,0,3,1)
GO
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES 
	(29,247,4301,0,0,1)
	,(30,247,4301,0,0,1)
	,(31,247,4301,0,0,1)
GO

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (247,4301,10)
GO

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 11,	247,	4301,	'Level 1',	1


DECLARE @maxStakeLevel INT
SELECT @maxStakeLevel=MAX(StakeLevelID) FROM Dep_StakeLevel WITH(NOLOCK) 

INSERT INTO Dep_StakeLevel(StakeLevelID,GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT @maxStakeLevel+1,4301 ,11 ,	NULL,	NULL,	NULL,	NULL,	20	,NULL

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,	GameTypeID,	'0.25',	' 125.00',	 0.25 , 125.00 
FROM Dep_StakeLevel e WITH(NOLOCK) 
WHERE GameTypeID=4301 AND GameGroupID=11 AND e.exchangeid=20
