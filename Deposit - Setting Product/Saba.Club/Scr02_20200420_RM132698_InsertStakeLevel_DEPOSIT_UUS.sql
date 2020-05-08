/*
	Date: 20200420
	Created: Eden
	Task: Stake level Saba.Club - Deposit [#132698] - UUS
	DB: DBCUST/CUSTDB
*/

-- SELECT * FROM DEP_StakeLevel WITH(NOLOCK) WHERE GameTypeID = 1611
-- SELECT * FROM Dep_StakeLevelGroupDetail WITH(NOLOCK) WHERE GameTypeID = 1611
DECLARE @Sporttype INT = 200, @Bettype INT = 1611
DECLARE  @list varchar (max) = 'UUS'
DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO DEP_StakeLevel(
	 GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
	,StakeLevelID
)
SELECT GameTypeID = @Bettype
	,ExchangeId = e.exchangeid
	,ResourceId = NULL
	,GameGroupID = gg.GameGroupID --DEP
	,StakeLevelID =  @MaxStakeLevelID + ROW_NUMBER() OVER (ORDER BY e.exchangeID) 
FROM exchange e WITH(NOLOCK) 
	CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = @Sporttype AND IsDeposit = 1) gg
	LEFT JOIN DEP_StakeLevel s WITH(NOLOCK) ON e.exchangeid = s.ExchangeId AND s.GameTypeID = @Bettype
WHERE e.currency IN ( SELECT LTRIM(val) as Currency FROM  dbo.f_StringSplit (@list ,','))
	AND s.ExchangeId IS NULL

CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT @Bettype, 20, '0.1', '10,000', 0.1, 10000 -- UUS

;WITH T AS(
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = @Bettype
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
