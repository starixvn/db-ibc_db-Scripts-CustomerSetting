/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20250206
	Task: MBC - Add a new bet settings for Live Casino products - SUPER only [redmine: #217463]
	DB: DBCust/CustDB
*/ 
----------------------------------------------------------------------------------------------
PRINT N'Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------
USE CustDB 
GO

DECLARE @Cust_cnt	INT

CREATE TABLE #SportBettype (SportType SMALLINT, BetType SMALLINT, NewStakeLevelID INT)

CREATE TABLE #tbCustomer(
		CustID	INT, 
		SportType SMALLINT, 
		BetType SMALLINT, 
		NewStakeLevelID INT
		PRIMARY KEY(CustID, Sporttype, Bettype)
)

INSERT INTO #SportBettype(SportType, BetType)
SELECT SportType, BetType
FROM ProductSettingProfile WITH(NOLOCK)
WHERE SettingType IN (7,17)		-- stake level
	AND SportType IN (	138,    -- ON Casino
						159,    -- YeeBet
						170,    -- PP Live Casino
						211,    -- Allbet
						228,    -- WE Live Casino
						239,    -- BG
						243,    -- AE Sexy
						244     -- SA Gaming
	)

;WITH cte_New AS (
	SELECT psd.SportType, psd.BetType
		, MAX(sl.StakeLevelID) StakeLevelID
	FROM StakeLevel sl WITH (NOLOCK)
	INNER JOIN #SportBettype psd ON psd.BetType=sl.GameTypeID
	WHERE sl.ExchangeId=43 AND sl.MaxStake=200000
	GROUP BY psd.SportType, psd.BetType
)
UPDATE sb
SET sb.NewStakeLevelID=t.StakeLevelID
FROM #SportBettype sb
INNER JOIN cte_New t ON t.SportType=sb.SportType AND t.BetType=sb.BetType

INSERT INTO #tbCustomer (CustID, SportType, BetType, NewStakeLevelID)
SELECT c.custid
	, sb.SportType
	, sb.BetType
	, sb.NewStakeLevelID
FROM customer c WITH (NOLOCK) 
INNER JOIN custInfo ci WITH (NOLOCK) ON c.custid=ci.custid
INNER JOIN site s WITH (NOLOCK) ON s.site=c.site
LEFT JOIN Dep_CustSuper cs WITH (NOLOCK) ON cs.custid=c.custid
CROSS APPLY (SELECT SportType, BetType, NewStakeLevelID FROM #SportBettype) sb
WHERE c.roleid = 4 AND c.username NOT LIKE '3rdSuper%'
	AND cs.custid IS NULL
	AND s.SiteLabel='MBC'
	AND ci.currency IN (43)	-- THB
	AND ci.Enabled=1

---------------------------------------------------------------------------------------------
-- For deployer info
SELECT @Cust_cnt = COUNT(DISTINCT CustID)
FROM #tbCustomer

DECLARE @msg_total NVARCHAR(200) = 'Total of Supers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

-- Delete: supers had new stake level setting
DELETE ci
FROM #tbCustomer ci
INNER JOIN CustStakeLevel_Agent cg WITH (NOLOCK) ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType
CROSS APPLY (SELECT TOP 1 1 AS VAL 
			 FROM STRING_SPLIT(cg.StakeLevelList,',') 
			 WHERE CAST(value AS INT)=ci.NewStakeLevelID) ss

-- Update new setting
UPDATE cg
SET cg.StakeLevelList += ',' + CAST(ci.NewStakeLevelID AS VARCHAR(10))
FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK, UPDLOCK)	
INNER JOIN #tbCustomer ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

DROP TABLE #tbCustomer
GO	

PRINT N'End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO