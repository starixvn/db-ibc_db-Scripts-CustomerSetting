/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240617
	Task: Update MaxStake for Saba.Games & Saba Casino [Redmine:#206515] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO
/*
DELETE FROM StakeLevel WITH (ROWLOCK)
WHERE StakeLevelID=2711
GO

UPDATE TOP (4) sl
SET sl.MinStake=0.1
	,sl.MinLabel='0.1'
	, sl.MaxStake= CASE WHEN StakeLevelID=2327 THEN 500
						WHEN StakeLevelID=1946 THEN 3000
						WHEN StakeLevelID=2710 THEN 5000
					END
	, sl.MaxLabel = CASE WHEN StakeLevelID=2327 THEN '500'
						WHEN StakeLevelID=1946 THEN '3,000'
						WHEN StakeLevelID=2710 THEN '5,000'
					END
FROM StakeLevel sl WITH (ROWLOCK, UPDLOCK)
WHERE sl.StakeLevelID IN (1946, 2710	-- SABA.Games
						 , 2327)		-- Saba Casino
	AND sl.GameTypeID IN (1611, 2101)
	AND sl.ExchangeId=6 
GO
*/

UPDATE TOP (3) sl
SET sl.MinLabel=NULL
	,sl.MaxLabel=NULL
	,sl.MinStake= 0
	,sl.MaxStake = 0
FROM StakeLevel sl WITH (ROWLOCK, UPDLOCK)
WHERE sl.StakeLevelID IN (2327, 2328)	-- Saba Casino
	AND sl.GameTypeID IN (2101)
	AND sl.ExchangeId=6 
GO

DELETE FROM StakeLevel WITH (ROWLOCK)
WHERE StakeLevelID IN (2710,2711)
GO