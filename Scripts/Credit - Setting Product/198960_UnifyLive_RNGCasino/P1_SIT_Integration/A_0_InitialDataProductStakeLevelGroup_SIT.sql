/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductStakeLevelGroup [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/

DECLARE @Temp_StakeLevelID TABLE (StakeLevelID INT)
DECLARE @Temp_Stake TABLE (SportType INT , MinStake DECIMAL (19,8) , MaxStake DECIMAL (19,8) )

INSERT INTO @Temp_StakeLevelID (StakeLevelID)
SELECT sl.StakeLevelID 
FROM StakeLevel sl WITH (NOLOCK)
WHERE sl.ExchangeId = 20
AND 	sl.GameTypeID IN (3801,5500,4601,4602,4605)


INSERT INTO @Temp_Stake (SportType , MinStake , MaxStake)
SELECT DISTINCT C.* 
FROM (
	SELECT 
		CASE 
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
		CASE 
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


IF EXISTS (SELECT 1 FROM ProductStakeLevelGroup WITH (NOLOCK) WHERE Sporttype IN (171,224,245) AND CreditGroupID = 6)
BEGIN
	DELETE FROM ProductStakeLevelGroup WITH (ROWLOCK) WHERE Sporttype IN (171,224,245) AND CreditGroupID = 6
END

INSERT INTO ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , CreditGroupID
	    , Remark
	    , RepUpdateTime
	    , isDeleted
	)

SELECT
	SportType
,	1			AS GameGroupID
,	MAX(MinStake)	AS MinBet
,	MIN(MaxStake)	AS MaxBet
,	6			AS CreditGroupID
,	NULL			AS Remark
,	SYSDATETIME ()
,	0
FROM @Temp_Stake
GROUP BY SportType