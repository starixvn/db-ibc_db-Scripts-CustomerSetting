/*
	Created: 20190625@Winnie
	Task: DCS Deposit for CardClub - [Redmine:#115322]
		Insert Master Data:
	DB: Run at DBCust.CustDB
*/  
USE [CustDB]
Go

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES 
	--Status
	(26,33,4,0,1,1)
	-- PT
	,(27,33,1,0,2,1)
	-- Stakelevel group
	,(28,33,7,0,3,1)
GO
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES 
	(26,165,1901,0,0,1)
	,(27,165,1901,0,0,1)
	,(28,165,1901,0,0,1)
GO

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (165,1901,9)
GO

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 10,	165,	1901,	'Level 1',	1


DECLARE @maxStakeLevel INT
SELECT @maxStakeLevel=MAX(StakeLevelID) FROM Dep_StakeLevel WITH(NOLOCK) 

INSERT INTO Dep_StakeLevel(StakeLevelID,GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT @maxStakeLevel+1,1901 ,10 ,	NULL,	NULL,	NULL,	NULL,	20	,NULL

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,	GameTypeID,	'0.25',	' 125.00',	 0.25 , 125.00 
FROM Dep_StakeLevel e WITH(NOLOCK) 
WHERE GameTypeID=1901 AND GameGroupID=10 AND e.exchangeid=20
