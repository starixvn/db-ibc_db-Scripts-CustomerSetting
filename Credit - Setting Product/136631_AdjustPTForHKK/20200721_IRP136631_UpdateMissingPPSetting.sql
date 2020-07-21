/*
	Created: 20200721@Johnson
	Task: update missing setting for PP
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpSetting (GameTypeID INT, MinStake MONEY, MaxStake MONEY, MinLabel VARCHAR(10), MaxLabel VARCHAR(10))

INSERT INTO #tmpSetting(GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
SELECT 	4151	,	0.6,	300,	'0.6'	,	'300'	--	Tales of Egypt
UNION ALL SELECT 	4186	,	0.6	,	12	,	'0.6'	,	'12'	--	Sweet Bonanza™

DECLARE @StakeLevelID INT

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID = 4101 
	AND exchangeid = 67

UPDATE s
SET s.MinStake = t.MinStake,
	s.MaxStake = t.MaxStake,
	s.MinLabel = t.MinLabel,
	s.MaxLabel = t.MaxLabel
FROM StakeLevelGroupDetail s WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting t ON s.GameTypeID = t.GameTypeID
WHERE s.StakeLevelID = @StakeLevelID	