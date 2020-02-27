/*
	Created: 20200224@Tiara
	Date: 20200224
	Task: Insert product profile for SA Gaming Deposit [Redmine: 128058]
	DB: DBCUST/CustDB
*/
USE [CustDB]
Go
--Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (42,41,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (43,41,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (44,41,7,0,3,3) -- StakeLevel


--Dep_ProductSettingDetail

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (42,244,3001,0,0,0)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (43,244,3001,0,0,0)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (44,244,3001,0,0,0)


--Dep_ProductStatusProfile 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (244,3001,14)


--StakeLevel
DECLARE @maxStakeLevel INT
SELECT @maxStakeLevel=MAX(StakeLevelID) FROM Dep_StakeLevel WITH(NOLOCK) 

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]			[decimal](19, 8) NULL,
	[MaxStake]			[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]
GO

INSERT #temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)

SELECT 3002,'1','500',1,500,20 UNION ALL
SELECT 3003,'1','500',1,500,20 UNION ALL
SELECT 3004,'1','500',1,500,20 UNION ALL
SELECT 3005,'1','500',1,500,20 UNION ALL
SELECT 3006,'1','500',1,500,20 UNION ALL
SELECT 3007,'1','500',1,500,20 UNION ALL
SELECT 3001,'50','1000',50,1000,20 UNION ALL
SELECT 3002,'50','1000',50,1000,20 UNION ALL
SELECT 3003,'50','1000',50,1000,20 UNION ALL
SELECT 3004,'50','1000',50,1000,20 UNION ALL
SELECT 3005,'50','1000',50,1000,20 UNION ALL
SELECT 3006,'50','1000',50,1000,20 UNION ALL
SELECT 3007,'50','1000',50,1000,20 UNION ALL
SELECT 3001,'100','2000',100,2000,20 UNION ALL
SELECT 3002,'100','2000',100,2000,20 UNION ALL
SELECT 3003,'100','2000',100,2000,20 UNION ALL
SELECT 3004,'100','2000',100,2000,20 UNION ALL
SELECT 3005,'100','2000',100,2000,20 UNION ALL
SELECT 3006,'100','2000',100,2000,20 UNION ALL
SELECT 3007,'100','2000',100,2000,20 

INSERT INTO Dep_StakeLevel(StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel,	MinStake, MaxStake,	ExchangeID)
SELECT  @maxStakeLevel+1,3001, 0, '1','500',1,500,20

INSERT INTO Dep_StakeLevel(StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel,	MinStake, MaxStake,	ExchangeID)
SELECT StakeLevelID, 0, T.MinLabel,T.MaxLabel, T.MinStake,T.MaxStake
FROM Dep_StakeLevel D WITH (NOLOCK) INNER JOIN #temp T WITH (NOLOCK) ON D.ExchangeID = T.ExchangeId
WHERE T.GameTypeID BETWEEN 3001 AND 3007 AND D.ExchangeId IN (20)
