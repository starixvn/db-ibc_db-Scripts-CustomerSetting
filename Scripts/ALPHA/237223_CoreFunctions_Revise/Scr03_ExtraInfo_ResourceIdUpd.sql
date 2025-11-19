/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250827@Virgil
	Task: Revise core function report to use SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/

CREATE TABLE #tProductDetail (
	ResourceId 		VARCHAR(20),
	ProductId 		TINYINT,
	Sporttype 		SMALLINT,
	Bettype 		SMALLINT,
	[Order] 		SMALLINT,
	LeagueGroupID 	SMALLINT,
	TicketType 		TINYINT,
	ChildResourceId TINYINT
);

-- Hardcode ResourceId mapping --
INSERT INTO #tProductDetail (ResourceId, ProductId, Sporttype, Bettype, [Order], LeagueGroupID, TicketType, ChildResourceId)
SELECT '1' AS ResourceId, 32 AS ProductId, 248 AS Sporttype, 0 AS Bettype, 1 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '2' AS ResourceId, 32 AS ProductId, 248 AS Sporttype, 4297 AS Bettype, 2 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '3' AS ResourceId, 32 AS ProductId, 248 AS Sporttype, 4298 AS Bettype, 3 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '4' AS ResourceId, 45 AS ProductId, 243 AS Sporttype, 0 AS Bettype, 4 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '5' AS ResourceId, 45 AS ProductId, 243 AS Sporttype, 3150 AS Bettype, 5 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '6' AS ResourceId, 36 AS ProductId, 247 AS Sporttype, 0 AS Bettype, 6 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '7' AS ResourceId, 36 AS ProductId, 247 AS Sporttype, 4599 AS Bettype, 7 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '8' AS ResourceId, 36 AS ProductId, 247 AS Sporttype, 4600 AS Bettype, 8 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '9' AS ResourceId, 21 AS ProductId, 211 AS Sporttype, 0 AS Bettype, 9 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
UNION ALL 
SELECT '10' AS ResourceId, 21 AS ProductId, 211 AS Sporttype, 2499 AS Bettype, 10 AS [Order], 0 AS LeagueGroupID,  0 AS TicketType, NULL AS ChildResourceId
--- MG RNG
UNION ALL 
SELECT '17' AS ResourceId, 73 AS ProductId, 155 AS Sporttype, 0 AS Bettype, 17 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Normal Bets
UNION ALL 
SELECT '18' AS ResourceId, 73 AS ProductId, 155 AS Sporttype, 8695 AS Bettype, 18 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Prize
--- Live22
UNION ALL 
SELECT '21' AS ResourceId, 79 AS ProductId, 227 AS Sporttype, 0 AS Bettype, 21 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '22' AS ResourceId, 79 AS ProductId, 227 AS Sporttype, 7698 AS Bettype, 22 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Prize
--- FastSpin
UNION ALL 
SELECT '26' AS ResourceId, 87 AS ProductId, 230 AS Sporttype, 0 AS Bettype, 26 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '27' AS ResourceId, 87 AS ProductId, 230 AS Sporttype, 11295 AS Bettype, 27 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Prize
--- Vgaming
UNION ALL
SELECT '28' AS ResourceId, 66 AS ProductId, 171 AS Sporttype, 0 AS Bettype, 28 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '29' AS ResourceId, 66 AS ProductId, 171 AS Sporttype, 3897 AS Bettype, 29 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Bets
--- FA CHAI
UNION ALL
SELECT '30' AS ResourceId, 89 AS ProductId, 146 AS Sporttype, 0 AS Bettype, 30 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '31' AS ResourceId, 89 AS ProductId, 146 AS Sporttype, 11399 AS Bettype, 31 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Bets
--- ASKMESLOT
UNION ALL
SELECT '32' AS ResourceId, 103 AS ProductId, 130 AS Sporttype, 0 AS Bettype, 32 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '33' AS ResourceId, 103 AS ProductId, 130 AS Sporttype, 15199 AS Bettype, 33 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Bet
--- HOTDOG
UNION ALL
SELECT '34' AS ResourceId, 95 AS ProductId, 139 AS Sporttype, 0 AS Bettype, 34 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '35' AS ResourceId, 95 AS ProductId, 139 AS Sporttype, 11999 AS Bettype, 35 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Bets
--- MGLC
UNION ALL
SELECT '36' AS ResourceId, 107 AS ProductId, 124 AS Sporttype, 0 AS Bettype, 36 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '37' AS ResourceId, 107 AS ProductId, 124 AS Sporttype, 13995 AS Bettype, 37 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Promotion Bets
--- PTLC
UNION ALL
SELECT '40' AS ResourceId, 101 AS ProductId, 129 AS Sporttype, 0 AS Bettype, 40 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL 
SELECT '41' AS ResourceId, 101 AS ProductId, 129 AS Sporttype, 15798 AS Bettype, 41 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Jackpot Contribution
UNION ALL 
SELECT '42' AS ResourceId, 101 AS ProductId, 129 AS Sporttype, 15799 AS Bettype, 42 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId -- Jackpot Prize
--- RGRNG
UNION ALL
SELECT '43' AS ResourceId, 108 AS ProductId, 123 AS Sporttype, 0 AS Bettype, 43 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Normal Bets
UNION ALL
SELECT '44' AS ResourceId, 108 AS ProductId, 123 AS Sporttype, 15899 AS Bettype, 44 AS [Order], 0 AS LeagueGroupID, 0 AS TicketType, NULL AS ChildResourceId-- Promotion Bets


-- SELECT * FROM #tProductDetail WHERE Bettype <> 0 ORDER BY ProductId, Sporttype, Bettype

/*
SELECT *, JSON_VALUE(ExtraInfo, '$.BettypeRef') AS BettypeRef
FROM SportBettypeMatrix A WITH (NOLOCK)
JOIN #tProductDetail B 
	ON A.ProductID = B.ProductID
	AND A.SportType = B.SportType
	-- AND A.BetType = B.BetType
WHERE B.Bettype = 0
ORDER BY A.ProductId, A.Sporttype, A.Bettype
*/

-- Update ResourceId for Normal Bettypes --
UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.ResourceId', pd.ResourceId)
FROM SportBettypeMatrix sbm
JOIN #tProductDetail pd ON pd.ProductID = sbm.ProductID AND pd.Sporttype = sbm.Sporttype 
WHERE pd.Bettype = 0

-- Update ResourceId for Promotion Bettypes --
UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.ResourceId', pd.ResourceId)
FROM SportBettypeMatrix sbm
JOIN #tProductDetail pd ON pd.ProductID = sbm.ProductID AND pd.Sporttype = sbm.Sporttype AND pd.Bettype = sbm.Bettype


DROP TABLE IF EXISTS #tProductDetail