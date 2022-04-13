/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert stake level for Saba Casino - UUS [#164280]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

CREATE TABLE #StakeLevel(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int],
	[GameGroupID]	INT,
	ID				INT IDENTITY(1,1),
	StakeLevelID	INT
) ON [PRIMARY]

GO
INSERT #StakeLevel (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT 2101, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2101, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2103, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2103, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2104, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2104, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2105, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2105, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2107, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2107, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2108, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2108, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2109, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2109, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2111, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2111, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2112, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2112, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2113, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2113, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2115, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2115, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2120, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2120, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2121, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2121, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2147, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2147, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2149, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2149, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2151, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2151, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2155, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2155, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2162, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2162, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2163, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2163, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2165, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2165, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2167, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2167, 20, '0.01', '62.5', 0.01, 62.5 UNION ALL -- UUS
SELECT 2178, 20, '2.5', '500', 2.5, 500 UNION ALL -- UUS
SELECT 2178, 20, '10', '1,000', 10, 1000 UNION ALL -- UUS
SELECT 2180, 20, '0.01', '1,250', 0.01, 1250 UNION ALL -- UUS
SELECT 2180, 20, '0.01', '1,250', 0.01, 1250 UNION ALL -- UUS
SELECT 2181, 20, '1', '100', 1, 100 UNION ALL -- UUS
SELECT 2181, 20, '2.5', '250', 2.5, 250 UNION ALL -- UUS
SELECT 2201, 20, '1', '250', 1, 250 UNION ALL -- UUS
SELECT 2201, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2203, 20, '1', '250', 1, 250 UNION ALL -- UUS
SELECT 2203, 20, '1', '500', 1, 500 UNION ALL -- UUS
SELECT 2205, 20, '0.1', '250', 0.1, 250 UNION ALL -- UUS
SELECT 2205, 20, '0.1', '500', 0.1, 500 UNION ALL -- UUS
SELECT 2207, 20, '0.1', '250', 0.1, 250 UNION ALL -- UUS
SELECT 2207, 20, '0.1', '500', 0.1, 500 UNION ALL -- UUS
SELECT 2208, 20, '0.1', '50', 0.1, 50 UNION ALL -- UUS
SELECT 2208, 20, '0.1', '100', 0.1, 100  -- UUS

/*
remove 5 games bellow:
	2155 Chinese Zodiac
	2162 Football Fans
	2111 Roulette Pro (Fast)
	2178 Baccarat(Progressive JP)
	2151 Fox Force 5
*/
DELETE FROM #StakeLevel WHERE GameTypeID IN(2155,2162,2111,2178,2151)

/*
	Update maxlabel = MaxStake*5 for 5 game bellow :
	2103  Blackjack
	2181 Fast Blackjack
	2203 (Mini) Blackjack
	2112   Blackjack Perfect Pair
	2121   Face Up 21
*/
UPDATE st
SET st.Maxlabel = CONVERT(VARCHAR(20),CONVERT(DECIMAL(20,0),MaxStake*5))
FROM #StakeLevel st
WHERE GameTypeID IN(2103,2181,2203,2112,2121)

--ADD ',' to stake label
UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel t
WHERE MaxStake*5 > 999
	AND GameTypeID IN(2103,2181,2203,2112,2121)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #StakeLevel t
WHERE MaxStake*5 > 999999
	AND GameTypeID IN(2103,2181,2203,2112,2121)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),12,0,','))
FROM #StakeLevel t
WHERE MaxStake*5 > 999999999
	AND GameTypeID IN(2103,2181,2203,2112,2121)
------------------------------------------------

DECLARE @Max_StakeLevelID INT

SELECT @Max_StakeLevelID = MAX(StakeLevelID) FROM Dep_StakeLevel WITH(NOLOCK)

;WITH TMP AS(
	SELECT s.*,
	ROW_NUMBER() OVER( PARTITION BY GameTypeID,ExchangeID ORDER BY MaxStake,MinStake) AS Level,
	ROW_NUMBER() OVER( PARTITION BY GameTypeID ORDER BY ExchangeID,MaxStake,MinStake) + @Max_StakeLevelID AS StakeLevelID_TMP
	FROM #StakeLevel s
)
UPDATE t
SET t.GameGroupID = CASE WHEN tmp.level = 1 then 33 ELSE 35 END,
	t.StakeLevelID = tmp.StakeLevelID_TMP
FROM #StakeLevel t
INNER JOIN TMP 
	ON t.ID = tmp.ID

-->Insert StakeLevel
INSERT INTO Dep_StakeLevel(StakeLevelID,GameTypeID,ExchangeId,GameGroupID)
SELECT StakeLevelID,GameTypeID, ExchangeID,t.GameGroupID
FROM #StakeLevel t
WHERE t.GameTypeID = 2101
	AND NOT EXISTS (SELECT 1 
					FROM Dep_StakeLevel s WITH(NOLOCK) 
					WHERE t.ExchangeId = s.ExchangeId 
						AND t.GameTypeID = s.GameTypeID
						AND t.GameGroupID = s.GameGroupID )


--Insert StakeLevelGroupDetail
;WITH STAKE_TEMP AS (
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel t 
				  WHERE t.ExchangeId = s.ExchangeId
					AND t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 2101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;

DROP TABLE #StakeLevel

/*
DELETE sl
FROM Dep_StakeLevelGroupDetail SL WITH (NOLOCK)
	INNER JOIN Dep_StakeLevel s WITH(NOLOCK)ON sl.StakeLevelID = s.StakeLevelID
WHERE S.GameTypeID = 2101 AND s.exchangeid = 20

DELETE sl
FROM Dep_StakeLevel SL WITH (NOLOCK)
	inner join exchange e (NOLOCK) on sl.exchangeid = e.exchangeid
WHERE SL.GameTypeID = 2101 AND sl.exchangeid = 20

SELECT sl.*,e.code
FROM Dep_StakeLevel SL WITH (NOLOCK)
	inner join exchange e (NOLOCK) on sl.exchangeid = e.exchangeid
WHERE SL.GameTypeID = 2101 AND sl.exchangeid = 20
ORDER BY sl.gametypeID,sl.exchangeID,sl.gamegroupID

SELECT sl.*,s.exchangeid,s.gamegroupID
FROM Dep_StakeLevelGroupDetail SL WITH (NOLOCK)
	INNER JOIN Dep_StakeLevel s WITH(NOLOCK)ON sl.StakeLevelID = s.StakeLevelID
WHERE S.GameTypeID = 2101 AND s.exchangeid = 20
ORDER BY sl.gametypeID,s.exchangeID,s.gamegroupID
*/

