/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250505
	Task: W Casino - Clean old Stakelevel setting - PROD [RedmineID: #225850]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @tmpStakeLevelList TABLE
(
	currency	NVARCHAR(50),
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
	IsCredit	BIT
)
INSERT INTO @tmpStakeLevelList (currency, StakeLevelList, IsCredit)

SELECT 'HKK', '10 - 2000,50 - 5000,100 - 10000', 1
UNION ALL
SELECT 'RM', '10 - 2000,50 - 5000,100 - 10000', 1
UNION ALL
SELECT 'RMB', '10 - 2000,50 - 5000,100 - 10000', 1
UNION ALL
SELECT 'HK$', '10 - 2000,50 - 5000,100 - 10000', 1
UNION ALL
SELECT '$US', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'US$', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'Yen', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'UT', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'USD', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'MMK', '5 - 1000,20 - 2000,50 - 5000', 1
UNION ALL
SELECT 'Won', '5000 - 500000,10000 - 1000000,30000 - 2500000', 1
UNION ALL
SELECT 'THB', '10 - 20000,100 - 50000,1000 - 100000', 1
UNION ALL
SELECT 'IN', '5 - 10000,10 - 20000,100 - 40000', 1
UNION ALL
SELECT 'IND', '5 - 10000,10 - 20000,100 - 40000', 1
UNION ALL
SELECT 'IDD', '5 - 10000,10 - 20000,100 - 40000', 1
UNION ALL
SELECT 'IDR', '5 - 10000,10 - 20000,100 - 40000', 1
UNION ALL
SELECT 'DDD', '5 - 10000,10 - 20000,100 - 40000', 1
UNION ALL
SELECT 'INH', '5 - 10000,10 - 20000,100 - 50000', 1
UNION ALL
SELECT 'EURO', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'UUS', '5 - 1000,20 - 2000,50 - 3000', 1
UNION ALL
SELECT 'YNG', '5 - 1000,20 - 2000,50 - 3000', 1
-- Deposit
UNION ALL
SELECT 'IN', '5 - 10000,10 - 20000,100 - 40000', 0
UNION ALL
SELECT 'INH', '5 - 10000,10 - 20000,100 - 50000', 0
UNION ALL
SELECT 'INH2', '5 - 10000,10 - 20000,100 - 50000', 0
UNION ALL
SELECT 'US$', '5 - 1000,20 - 2000,50 - 3000', 0
UNION ALL
SELECT 'EURO', '5 - 1000,20 - 2000,50 - 3000', 0
UNION ALL
SELECT 'RMB', '10 - 2000,50 - 5000,100 - 10000', 0
UNION ALL
SELECT 'UUS', '5 - 1000,20 - 2000,50 - 3000', 0

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
;WITH 
Split_StakeLevel AS (
	SELECT currency, IsCredit
		,CAST(TRIM(SUBSTRING(Betlimit, 1, CHARINDEX('-', Betlimit) - 1)) AS DECIMAL(18,2)) AS MinBet
		,CAST(TRIM(SUBSTRING(Betlimit, CHARINDEX('-', Betlimit) + 1, LEN(Betlimit))) AS DECIMAL(18,2)) AS MaxBet
	FROM @tmpStakeLevelList t
	CROSS APPLY (SELECT TRIM(VALUE) Betlimit
				 FROM STRING_SPLIT(T.StakeLevelList, ',')) sl
)
INSERT INTO #tmpStakeLevel (ExchangeId, currency, MinStake, MaxStake, IsCredit)
SELECT e.ExchangeId, e.currency, sl.MinBet, sl.MaxBet, sl.IsCredit
FROM Split_StakeLevel sl
INNER JOIN exchange E WITH (NOLOCK) ON sl.currency=e.currency
--ORDER BY sl.IsCredit, e.currency

--RETURN

--Update: StakeLevel
DELETE sl 
	OUTPUT deleted.StakeLevelID, dbo.f_GetDateTime2()
	INTO StakeLevel_Del_InHouse (StakeLevelID, RepUpdateTime)
FROM StakeLevel sl WITH(ROWLOCK)
INNER JOIN #tmpStakeLevel T
	ON t.MinStake=sl.MinStake
	AND t.MaxStake=sl.MaxStake
	AND t.ExchangeId=sl.ExchangeId
	AND t.GameTypeID=sl.GameTypeID
	AND t.IsCredit=1

--Update: Dep_StakeLevel
DELETE sl 
	OUTPUT deleted.StakeLevelID, dbo.f_GetDateTime2()
	INTO Dep_StakeLevel_Del_InHouse (StakeLevelID, RepUpdateTime)
FROM Dep_StakeLevel sl WITH(ROWLOCK)
INNER JOIN #tmpStakeLevel T
	ON t.MinStake=sl.MinStake
	AND t.MaxStake=sl.MaxStake
	AND t.ExchangeId=sl.ExchangeId
	AND t.GameTypeID=sl.GameTypeID
WHERE t.IsCredit=0

DROP TABLE #tmpStakeLevel
GO