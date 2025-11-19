/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20251105@Virgil
	Task: Add WOW Gaming to ExtraInfo of SportBettypeMatrix [Redmine: #241779]
	DB: DBPRO-bodb02
*/

DECLARE @t_Sporttype TABLE(ProductID tinyint, SportType smallint)

-- SportTypeRef mapping of WOW Gaming
INSERT INTO @t_Sporttype (ProductID, SportType)
SELECT 117, 113


UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.SportTypeRef', ts.SportType)
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
JOIN @t_Sporttype ts 
	ON sbm.ProductID = ts.ProductID 
	AND sbm.SportType = ts.SportType
