/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250827@Virgil
	Task: Revise core function report to use SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/

----------------- Temporary Tables --------------------
CREATE TABLE #tempSBM (
	bettype_group VARCHAR(50),
	BetType SMALLINT,
	ProductID TINYINT,
	SubProduct VARCHAR(500)
);

CREATE TABLE #FinalSBM (
	ProductID TINYINT,
	BetType SMALLINT,
	BettypeRef SMALLINT,
	bettype_group VARCHAR(50)
);

-- ====================== Bettype =========================== --
-- Prize_Contribution bettypes --
INSERT INTO #tempSBM (bettype_group, BetType, ProductID, SubProduct)
SELECT DISTINCT ck.bettype_group, sp.BetType, sp.ProductID, sp.SubProduct
FROM SportBettypeMatrix sp (nolock)
CROSS apply (
	select case 
		when ProductID in (6) and bettype in (2198, 2398, 2998) then 'Contribution' 
		when ProductID in (32, 36, 42, 66, 101) and SubProduct in ('Jackpot Contribution') then 'Contribution' 
		when ProductID in (6) and BetType IN(2199,2399,2999) then 'Prize' 
		when ProductID in (21) and SubProduct IN('Promotion') then 'Prize'
		when ProductID in (32, 36, 42, 66, 101) and SubProduct IN('Jackpot Prize') then 'Prize'
		when ProductID in (32, 66, 73, 79, 87, 89, 95,103,107,108) and SubProduct IN('Prize') then 'Prize'
		when ProductID in (34) and SubProduct IN('Bonus') then 'Prize'
		when ProductID in (32, 36, 42, 66, 101) and SubProduct in ('Jackpot Prize', 'Prize') AND bettype <> 4598 then 'Prize' 
		else null end as bettype_group
) as ck
where RefTable in (1,2)
	AND SubProduct <> ''
	AND bettype_group is not null

-- BetTypeRef and BettypeGroup mapping --
INSERT INTO #FinalSBM (ProductID, BetType, BettypeRef, bettype_group)
SELECT ISNULL(sp.ProductID, tmp.ProductID) AS ProductID, 
        ISNULL(sp.BetType, tmp.BetType) AS BetType,
        sp.BettypeRef,
        tmp.bettype_group
FROM (
    -- Hardcode bettypes in Task_Sum_Winloss --
    SELECT DISTINCT sp.ProductID, sp.SubProduct, sp.BetType, ck.bettype_new AS BetTypeRef
    FROM SportBettypeMatrix sp WITH (NOLOCK)
    CROSS APPLY (
        SELECT CASE 
            WHEN ProductID = 21 AND SubProduct = 'Promotion' THEN bettype 
            WHEN ProductID IN (32, 36, 101) AND SubProduct IN ('Jackpot Contribution', 'Jackpot Prize') THEN bettype 
            WHEN ProductID = 45 AND SubProduct IN ('Lucky Draw') then bettype 
            WHEN ProductID in (66,73,79,87,89,95,103,107,108) AND SubProduct IN ('Prize') THEN bettype 
        ELSE 0 END AS bettype_new
    ) AS ck
    where RefTable IN (1,2)
        AND sp.SubProduct <> ''
        AND bettype_new > 0
) sp
FULL JOIN #tempSBM tmp ON sp.BettypeRef = tmp.BetType

--SELECT * FROM #FinalSBM ORDER BY bettype_group, BetType

-- Update Promotion BettypeRef & BettypeGroup --
UPDATE A
SET A.ExtraInfo = JSON_MODIFY(
                    JSON_MODIFY(ISNULL(A.ExtraInfo, '{}'), '$.BettypeRef', B.BettypeRef),
                    '$.BettypeGroup', B.bettype_group
                )
FROM SportBettypeMatrix A
JOIN #FinalSBM B ON A.ProductID = B.ProductID AND A.BetType = B.BetType

/*
SELECT A.*
FROM SportBettypeMatrix A (NOLOCK)
JOIN #FinalSBM B ON A.ProductID = B.ProductID AND A.BetType = B.BetType
*/

DROP TABLE IF EXISTS #tempSBM, #FinalSBM