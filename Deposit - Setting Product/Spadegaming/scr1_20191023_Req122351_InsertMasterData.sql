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

CREATE TABLE #temp(
	GameTypeID		INT,
	[exchangeid]	[int] ,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[Min]			[decimal](19, 8) NULL,
	[Max]			[decimal](19, 8) NULL,	
) ON [PRIMARY]

INSERT #temp (GameTypeID,[exchangeid],[MinLabel],[MaxLabel], [Min], [Max]) 
SELECT 4302,20,'0.05','100',0.05,100 UNION ALL 
SELECT 4303,20,'0.4','80',0.4,80 UNION ALL 
SELECT 4304,20,'0.4','80',0.4,80 UNION ALL 
SELECT 4305,20,'0.2','100',0.2,100 UNION ALL 
SELECT 4306,20,'0.2','100',0.2,100 UNION ALL 
SELECT 4307,20,'0.6','60',0.6,60 UNION ALL 
SELECT 4308,20,'0.6','150',0.6,150 UNION ALL 
SELECT 4309,20,'0.1','90',0.1,90 UNION ALL 
SELECT 4310,20,'1','100',1,100 UNION ALL 
SELECT 4311,20,'0.3','75',0.3,75 UNION ALL 
SELECT 4312,20,'0.6','150',0.6,150 UNION ALL 
SELECT 4313,20,'0.5','75',0.5,75 UNION ALL 
SELECT 4314,20,'0.5','90',0.5,90 UNION ALL 
SELECT 4315,20,'0.4','80',0.4,80 UNION ALL 
SELECT 4316,20,'0.4','100',0.4,100 UNION ALL 
SELECT 4317,20,'0.1','90',0.1,90 UNION ALL 
SELECT 4318,20,'0.09','90',0.09,90 UNION ALL 
SELECT 4319,20,'0.5','150',0.5,150 UNION ALL 
SELECT 4320,20,'0.5','100',0.5,100 UNION ALL 
SELECT 4321,20,'0.2','80',0.2,80 UNION ALL 
SELECT 4322,20,'0.2','100',0.2,100 UNION ALL 
SELECT 4323,20,'0.1','90',0.1,90 UNION ALL 
SELECT 4324,20,'0.3','75',0.3,75 UNION ALL 
SELECT 4325,20,'1','100',1,100 UNION ALL 
SELECT 4301,20,'0.5','150',0.5,150 

DELETE FROM #temp WHERE GameTypeID = 4313 -- Don't offer Ming Dynasty anymore

INSERT INTO Dep_StakeLevel(StakeLevelID,GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT @maxStakeLevel+1,4301 ,11 ,	NULL,	NULL,	NULL,	NULL,	20	,NULL

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,t.GameTypeID,	CAST(CAST(t.Min AS float) AS NVARCHAR(50)),CAST(CAST(t.Max AS float) AS NVARCHAR(50)),	t.Min , t.Max
FROM Dep_StakeLevel e WITH(NOLOCK) 
	INNER JOIN #temp t ON e.ExchangeID=t.exchangeid
WHERE e.GameTypeID=4301 AND GameGroupID=11 AND e.exchangeid=20

