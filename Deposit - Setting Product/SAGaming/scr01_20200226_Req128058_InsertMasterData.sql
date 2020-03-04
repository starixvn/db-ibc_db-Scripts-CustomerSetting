/*
	Created: 20200224@Tiara
	Date: 20200224
	Task: Insert product profile for SA Gaming Deposit [Redmine: 128058]
	DB: DBCUST/CustDB
*/
USE [CustDB]
Go
--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = 39 AND D.ProductSettingID BETWEEN 42 AND 44

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (42,39,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (43,39,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (44,39,7,0,3,3) -- StakeLevel

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = 244 AND D.BetType = 3001

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (42,244,3001,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (43,244,3001,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (44,244,3001,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = 244 AND D.BetType = 3001

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (244,3001,14)

--StakeLevel
 
CREATE TABLE #temp(
	ID INT IDENTITY (1,1),
	StakeLevelID INT,
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]			[decimal](19, 8) NULL,
	[MaxStake]			[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]
GO

INSERT #temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT 3001,'1','500',1,500,20 UNION ALL
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

DELETE D 
FROM Dep_StakeLevel D WITH (ROWLOCK)
WHERE D.GameTypeID BETWEEN 3001 AND 3007 AND D.ExchangeId IN (20)

DECLARE @maxStakeLevel INT
SELECT @maxStakeLevel=MAX(StakeLevelID) FROM Dep_StakeLevel WITH(NOLOCK)

UPDATE #temp SET StakeLevelID = @maxStakeLevel + ID

INSERT INTO Dep_StakeLevel(StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel,	MinStake, MaxStake,	ExchangeID)
SELECT DISTINCT T.StakeLevelID,T.GameTypeID, 0, T.MinLabel,T.MaxLabel, T.MinStake,T.MaxStake, T.ExchangeId
FROM Dep_StakeLevel D WITH (NOLOCK) INNER JOIN #temp T WITH (NOLOCK) ON D.ExchangeID = T.ExchangeId
WHERE T.GameTypeID BETWEEN 3001 AND 3007 AND D.ExchangeId IN (20)

DROP TABLE #temp

