/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: {Nickname}@{date}
	Task: {ProductName} - Mapping StakeLevel with ResourceId - PROD [RedmineID: #xxx]
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
-- Deposit
UNION ALL 
SELECT 'IN',	'66,18,393',	'5 - 10000,10 - 20000,100 - 40000',		0
UNION ALL
SELECT 'INH',	'66,18,26',		'5 - 10000,10 - 20000,100 - 50000',		0
UNION ALL
SELECT 'INH2',	'66,18,26',		'5 - 10000,10 - 20000,100 - 50000',		0
UNION ALL
SELECT 'EURO',	'63,628,608',	'5 - 1000,20 - 2000,50 - 3000',			0
UNION ALL
SELECT 'US$',	'63,628,608',	'5 - 1000,20 - 2000,50 - 3000',			0
UNION ALL
SELECT 'RMB',	'64,50,51',		'10 - 2000,50 - 5000,100 - 10000',		0
UNION ALL
SELECT 'UUS',	'621,630,623',	'5000 - 500000,10000 - 1000000,30000 - 2500000',	0

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