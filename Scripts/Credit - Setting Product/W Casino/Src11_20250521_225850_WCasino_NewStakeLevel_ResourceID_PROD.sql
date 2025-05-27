/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250522
	Task: W Casino - Mapping new StakeLevel with ResourceId - PROD [RedmineID: #225850]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @tmpStakeLevelList TABLE
(
	currency	NVARCHAR(50),
	ResourceIds VARCHAR(50),
	StakeLevelList	VARCHAR(4000),
	IsCredit		BIT
)

DROP TABLE IF EXISTS #tmpStakeLevel

CREATE TABLE #tmpStakeLevel
(
	GameTypeID	INT DEFAULT (12000),	--new product's bettype
	ExchangeId	INT,
	currency	NVARCHAR(50),
	MinStake	DECIMAL(19, 8),
	MaxStake	DECIMAL(19, 8),
	ResourceId	VARCHAR(50),
	IsCredit	BIT
)

INSERT INTO @tmpStakeLevelList (currency, ResourceIds, StakeLevelList, IsCredit)

SELECT 'RMB', '31,26,87', '10 - 10000', 1
UNION ALL
SELECT 'EURO', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'HK$', '31,26,87', '10 - 10000', 1
UNION ALL
SELECT 'IN', '127,68,61', '5 - 40000', 1
UNION ALL
SELECT 'IND', '127,68,61', '5 - 40000', 1
UNION ALL
SELECT 'IDD', '127,68,61', '5 - 40000', 1
UNION ALL
SELECT 'IDR', '127,68,61', '5 - 40000', 1
UNION ALL
SELECT 'DDD', '127,68,61', '5 - 40000', 1
UNION ALL
SELECT 'Won', '34,35,37', '5000 - 2500000', 1
UNION ALL
SELECT 'MMK', '30,80,26', '5 - 5000', 1
UNION ALL
SELECT 'HKK', '31,26,87', '10 - 10000', 1
UNION ALL
SELECT 'RM', '31,26,87', '10 - 10000', 1
UNION ALL
SELECT 'THB', '68,76,83', '10 - 100000', 1
UNION ALL
SELECT '$US', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'US$', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'Yen', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'UT', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'USD', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'UUS', '30,80,14', '5 - 3000', 1
UNION ALL
SELECT 'INH', '127,68,76', '5 - 50000', 1
UNION ALL
SELECT 'YNG', '30,80,14', '5 - 3000', 1
-- Deposit
UNION ALL
SELECT 'US$', '30,80,14', '5 - 3000', 0
UNION ALL
SELECT 'EURO', '30,80,14', '5 - 3000', 0
UNION ALL
SELECT 'RMB', '31,26,87', '10 - 10000', 0
UNION ALL
SELECT 'IN', '127,68,61', '5 - 40000', 0
UNION ALL
SELECT 'UUS', '30,80,14', '5 - 3000', 0
UNION ALL
SELECT 'INH', '127,68,76', '5 - 50000', 0
UNION ALL
SELECT 'INH2', '127,68,76', '5 - 50000', 0

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
;WITH 
Split_StakeLevel AS (
	SELECT currency, ResourceIds, IsCredit
		,CAST(TRIM(SUBSTRING(t.StakeLevelList, 1, CHARINDEX('-', t.StakeLevelList) - 1)) AS DECIMAL(18,2)) AS MinBet
		,CAST(TRIM(SUBSTRING(t.StakeLevelList, CHARINDEX('-', t.StakeLevelList) + 1, LEN(t.StakeLevelList))) AS DECIMAL(18,2)) AS MaxBet
	FROM @tmpStakeLevelList t
)
INSERT INTO #tmpStakeLevel (ExchangeId, currency, MinStake, MaxStake, ResourceId, IsCredit)
SELECT e.ExchangeId, e.currency, sl.MinBet, sl.MaxBet, sl.ResourceIds, sl.IsCredit
FROM Split_StakeLevel sl
INNER JOIN exchange E WITH (NOLOCK) ON sl.currency=e.currency
--ORDER BY sl.IsCredit
--RETURN

--Update: StakeLevel
UPDATE sl 
SET sl.ResourceId=t.ResourceId
	,sl.RepUpdateTime=dbo.f_GetDateTime2()
FROM StakeLevel sl WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpStakeLevel T
	ON t.MinStake=sl.MinStake
	AND t.MaxStake=sl.MaxStake
	AND t.ExchangeId=sl.ExchangeId
	AND t.GameTypeID=sl.GameTypeID
	AND t.IsCredit=1

--Update: Dep_StakeLevel
UPDATE sl 
SET sl.ResourceId=t.ResourceId
	,sl.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_StakeLevel sl WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpStakeLevel T
	ON t.MinStake=sl.MinStake
	AND t.MaxStake=sl.MaxStake
	AND t.ExchangeId=sl.ExchangeId
	AND t.GameTypeID=sl.GameTypeID
WHERE t.IsCredit=0

DROP TABLE #tmpStakeLevel
GO