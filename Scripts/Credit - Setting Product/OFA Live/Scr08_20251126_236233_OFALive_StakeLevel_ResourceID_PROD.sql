/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Virgil@20251126
	Task: OFA Live - Mapping StakeLevel with ResourceId - PROD [RedmineID: #236233]
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
	GameTypeID	INT DEFAULT (12250),	--new product's bettype
	ExchangeId	INT,
	currency	NVARCHAR(50),
	MinStake	DECIMAL(19, 8),
	MaxStake	DECIMAL(19, 8),
	ResourceId	VARCHAR(50),
	IsCredit	BIT
)

INSERT INTO @tmpStakeLevelList (currency, ResourceIds, StakeLevelList, IsCredit)
SELECT 'RMB',	'3',	'100 - 10000',		1
UNION ALL
SELECT 'EURO',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'HK$',	'3',	'100 - 10000',		1
UNION ALL
SELECT 'IN',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'IND',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'IDD',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'IDR',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'DDD',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'Won',	'13',	'100 - 200000',		1
UNION ALL
SELECT 'MMK',	'13',	'50 - 5000',		1
UNION ALL
SELECT 'HKK',	'3',	'100 - 10000',		1
UNION ALL
SELECT 'RM',	'3',	'100 - 10000',		1
UNION ALL
SELECT 'THB',	'5',	'100 - 100000',		1
UNION ALL
SELECT '$US',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'US$',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'Yen',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'UT',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'USD',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'UUS',	'9',	'20 - 3000',		1
UNION ALL
SELECT 'INH',	'1',	'100 - 50000',		1
UNION ALL
SELECT 'YNG',	'9',	'20 - 3000',		1
-- Deposit
UNION ALL
SELECT 'US$',	'9',	'20 - 3000',		0
UNION ALL
SELECT 'EURO',	'9',	'20 - 3000',		0
UNION ALL
SELECT 'RMB',	'3',	'100 - 10000',		0
UNION ALL
SELECT 'IN',	'1',	'100 - 50000',		0
UNION ALL
SELECT 'UUS',	'9',	'20 - 3000',		0
UNION ALL
SELECT 'INH',	'1',	'100 - 50000',		0
UNION ALL
SELECT 'INH2',	'1',	'100 - 50000',		0	
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
;WITH Split_ResourceId AS (
	SELECT t.currency, r.ResourceId, t.StakeLevelList, IsCredit
		,ROW_NUMBER() OVER (PARTITION BY currency, IsCredit ORDER BY (SELECT NULL)) AS reRowNum
	FROM @tmpStakeLevelList t
	CROSS APPLY (SELECT TRIM(VALUE) ResourceId
				 FROM STRING_SPLIT(T.ResourceIds, ',')) r
)
,
Split_StakeLevel AS (
	SELECT currency, ResourceId, reRowNum, IsCredit
		,CAST(TRIM(SUBSTRING(Betlimit, 1, CHARINDEX('-', Betlimit) - 1)) AS DECIMAL(18,2)) AS MinBet
		,CAST(TRIM(SUBSTRING(Betlimit, CHARINDEX('-', Betlimit) + 1, LEN(Betlimit))) AS DECIMAL(18,2)) AS MaxBet
		,ROW_NUMBER() OVER (PARTITION BY currency, ResourceId, IsCredit ORDER BY (SELECT NULL)) AS slRowNum
	FROM Split_ResourceId t
	CROSS APPLY (SELECT TRIM(VALUE) Betlimit
				 FROM STRING_SPLIT(T.StakeLevelList, ',')) sl
)
INSERT INTO #tmpStakeLevel (ExchangeId, currency, MinStake, MaxStake, ResourceId, IsCredit)
SELECT e.ExchangeId, e.currency, sl.MinBet, sl.MaxBet, sl.ResourceId, sl.IsCredit
FROM Split_StakeLevel sl
INNER JOIN exchange E WITH (NOLOCK) ON sl.currency=e.currency
WHERE reRowNum=slRowNum
--ORDER BY sl.IsCredit, e.currency, sl.reRowNum

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