/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220803
	Task:  Correct data StakeLevel Group Detail [PP Game] - deposit UUS RedmineID:#175454
	DB: DBCust/CustDB
*/

CREATE TABLE #BetType (TypeID INT, typedesc NVARCHAR(128))

BEGIN TRY
	INSERT INTO #BetType (TypeID, typedesc)
	SELECT typeid, typedesc
	FROM dbage.bodb02.dbo.bettype WITH (NOLOCK)
	WHERE typeid BETWEEN 4001 and 4600
		OR (typeid BETWEEN 6401 and 7000)
		OR (typeid BETWEEN 5800 AND 5999)
END TRY
BEGIN CATCH
	INSERT INTO #BetType (TypeID, typedesc)
	SELECT typeid, typedesc
	FROM dbtxn.bodb02.dbo.bettype WITH (NOLOCK)
	WHERE typeid BETWEEN 4001 and 4600
		OR (typeid BETWEEN 6401 and 7000)
		OR (typeid BETWEEN 5800 AND 5999)
END CATCH

UPDATE sl
SET sl.MaxGameStake = CASE WHEN sl.GameTypeID BETWEEN 6401 AND 6700	THEN 98* sl.MaxStake	--Joker
								WHEN (sl.GameTypeID BETWEEN 4001 AND 4100) OR
									 (sl.GameTypeID BETWEEN 4101 AND 4300) OR 
									 (sl.GameTypeID BETWEEN 6701 AND 7000) OR
									 (sl.GameTypeID BETWEEN 4301 AND 4600) OR
									 (sl.GameTypeID BETWEEN 5800 AND 5999)
								THEN 100*sl.MaxStake	--Macau Games, PP, SG
								ELSE sl.MaxStake
					END 
FROM Dep_StakeLevelGroupDetail sl WITH (ROWLOCK, UPDLOCK)
INNER JOIN Dep_StakeLevel s WITH(NOLOCK) ON sl.StakeLevelID = s.StakeLevelID
INNER JOIN #BetType bt WITH (NOLOCK) ON bt.typeid=sl.GameTypeID
WHERE s.GameTypeID  = 4101 AND typedesc='BuyBonus'
AND ExchangeID  in (4,20) AND GameGroupID = 38 -- TB, UUS

--SELECT sl.*  ,bt.* ,
--CASE WHEN  sl.GameTypeID BETWEEN 6401 AND 6700	THEN 98* sl.MaxStake	--Joker
--								WHEN (sl.GameTypeID BETWEEN 4001 AND 4100) OR
--									 (sl.GameTypeID BETWEEN 4101 AND 4300) OR 
--									 (sl.GameTypeID BETWEEN 6701 AND 7000) OR
--									 (sl.GameTypeID BETWEEN 4301 AND 4600) OR
--									 (sl.GameTypeID BETWEEN 5800 AND 5999)
--																	THEN 100*sl.MaxStake	--Macau Games, PP, SG
--																	ELSE sl.MaxStake
--					END AS MaxGameStake
--FROM Dep_StakeLevelGroupDetail sl WITH (ROWLOCK, UPDLOCK)
--INNER JOIN Dep_StakeLevel s WITH(NOLOCK) ON sl.StakeLevelID = s.StakeLevelID
--INNER JOIN #BetType bt WITH (NOLOCK) ON bt.typeid=sl.GameTypeID
--WHERE s.GameTypeID  = 4101 AND typedesc='BuyBonus'
--AND ExchangeID  in (4,20) AND GameGroupID = 38 -- TB, UUS

DROP TABLE #BetType