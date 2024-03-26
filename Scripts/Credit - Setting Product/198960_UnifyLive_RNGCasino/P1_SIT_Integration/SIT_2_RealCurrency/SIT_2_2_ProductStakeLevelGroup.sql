/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductStakeLevelGroup - Real Currency [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

DECLARE @Temp_StakeLevelID TABLE (StakeLevelID INT , ExchangeId INT)
DECLARE @Temp_Stake  TABLE  (StakeLevelID INT , SportType INT , MinStake DECIMAL (19,8) , MaxStake DECIMAL (19,8) , ExchangeId INT DEFAULT (0) , CreditGroupID TINYINT DEFAULT (0))

INSERT INTO @Temp_StakeLevelID (StakeLevelID , ExchangeId)
SELECT sl.StakeLevelID , sl.ExchangeId
FROM StakeLevel sl WITH (NOLOCK)
WHERE sl.ExchangeId <> 20
AND 	sl.GameTypeID IN (3801,5500,4601,4602,4605)


INSERT INTO @Temp_Stake (StakeLevelID , SportType , MinStake , MaxStake)
SELECT DISTINCT c.StakeLevelID , c.SportType , c.MinStake , c.MaxStake
FROM (
	SELECT 
		sl.StakeLevelID
	,	CASE 
		WHEN sl.GameTypeID  = 3801 THEN 171
		WHEN sl.GameTypeID  = 5500 THEN 224
		ELSE 245
		END AS SportType
	, ISNULL(sl.MinStake, 0)	AS MinStake
	, ISNULL(sl.MaxStake, 0)	AS MaxStake
	FROM StakeLevel sl WITH (NOLOCK)
	WHERE sl.StakeLevelID IN (SELECT sl.StakeLevelID FROM @Temp_StakeLevelID)
	AND sl.GameTypeID IN (3801,5500,4601,4602,4605)
	UNION ALL
	SELECT 
		sl.StakeLevelID
	,	CASE 
		WHEN sl.GameTypeID  = 3801 THEN 171
		WHEN sl.GameTypeID  = 5500 THEN 224
		ELSE 245
		END AS SportType
	, ISNULL(sl.MinStake, 0)  	AS MinStake
	, ISNULL(sl.MaxStake, 0)	AS MaxStake
	FROM StakeLevelGroupDetail sl WITH (NOLOCK)
	WHERE sl.StakeLevelID IN (SELECT sl.StakeLevelID FROM @Temp_StakeLevelID)
	AND sl.GameTypeID IN (3801,5500,4601,4602,4605)
) AS C


DELETE FROM @Temp_Stake WHERE MinStake = 0 AND MaxStake = 0


UPDATE s 
	SET s.ExchangeId = tl.ExchangeId
FROM @Temp_Stake s
INNER JOIN @Temp_StakeLevelID tl ON s.StakeLevelID = tl.StakeLevelID



UPDATE ts 
	SET ts.CreditGroupID = e.CreditGroupID
FROM @Temp_Stake ts
INNER JOIN exchange e WITH (NOLOCK) ON ts.ExchangeId = e.ExchangeId
WHERE e.CreditGroupID IS NOT NULL

--SELECT TS.* , '      ' AS '      ' , e.CreditGroupID
--FROM @Temp_Stake ts
--INNER JOIN exchange e WITH (NOLOCK) ON ts.ExchangeId = e.ExchangeId
--WHERE e.CreditGroupID IN (3,9,11)

DELETE FROM @Temp_Stake WHERE CreditGroupID = 0

IF NOT EXISTS (SELECT 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype IN (171,224,245) AND CreditGroupID <> 6)
BEGIN
	INSERT INTO ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	)

	SELECT SportType , 1 AS GameGroupID , MAX(MinStake) AS MinBet , MIN(MaxStake) AS MaxBet , CreditGroupID AS CreditGroupID
	FROM @Temp_Stake
	GROUP BY SportType , CreditGroupID
END


