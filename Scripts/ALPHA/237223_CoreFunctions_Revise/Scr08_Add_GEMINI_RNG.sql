/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20251013@Virgil
	Task: Add GEMINI to ExtraInfo of SportBettypeMatrix [Redmine: #239526]
	DB: DBPRO-bodb02
*/

DECLARE @t_Sporttype TABLE(ProductID tinyint, SportType smallint)

-- SportTypeRef mapping of GEMINI
INSERT INTO @t_Sporttype (ProductID, SportType)
SELECT 115, 117

-- SELECT * FROM @t_Sporttype

UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.SportTypeRef', ts.SportType)
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
JOIN @t_Sporttype ts 
	ON sbm.ProductID = ts.ProductID 
	AND sbm.SportType = ts.SportType


/*
	SELECT sbm.*, ts.SWL_SportType AS SportTypeRef
	FROM SportBettypeMatrix sbm (NOLOCK)
	JOIN #t_Sporttype ts
		ON sbm.ProductID = ts.ProductID
		AND sbm.SportType = ts.SBM_SportType
*/	
