/*
	Date: 2019-09-30
	Created: Winnie
	Task: add global setting for cash #120070  4 new currency 
	DB: DBCUST/CUSTDB
*/
DECLARE @MaxID INT
SELECT @MaxID=MAX([StakeLevelID]) FROM [Dep_StakeLevel] WITH(NOLOCK) 
INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
     VALUES
           (@MaxID+1
           ,4101
           ,8
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,41
           ,NULL
           ,NULL)
INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
     VALUES
           (@MaxID+2
           ,4101
           ,8
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,52
           ,NULL
           ,NULL)

INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
     VALUES
           (@MaxID+3
           ,4101
           ,8
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,53
           ,NULL
           ,NULL)


INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
     VALUES
           (@MaxID+4
           ,4101
           ,8
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,54
           ,NULL
           ,NULL)
GO

-------------------
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT a.GameTypeID,41,a.MinLabel,a.MaxLabel,a.MinStake,a.MaxStake
FROM Dep_StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN Dep_StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE b.ExchangeID=1 AND b.GameTypeID=4101
	
;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							
TRUNCATE TABLE #tmpStake
----------------------------------

INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT a.GameTypeID,e.exchangeid,a.MinLabel,a.MaxLabel,a.MinStake,a.MaxStake
FROM Dep_StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN Dep_StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
	CROSS APPLY  Exchange e WITH(NOLOCK) 
WHERE b.ExchangeID=1 AND b.GameTypeID=4101
	AND Code IN('DKK','SEK','NOK')

;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							
DROP TABLE #tmpStake

