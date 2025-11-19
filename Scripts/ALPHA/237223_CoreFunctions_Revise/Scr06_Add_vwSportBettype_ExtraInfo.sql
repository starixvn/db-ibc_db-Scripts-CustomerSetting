/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20251002@Virgil
	Task: Enhance report for f_SportBettype_SumWinloss [RedmineId: #235369]	
	DB: DBAGE.bodb02
*/

IF OBJECT_ID('[dbo].[vw_SportBettype_ExtraInfo]', 'V') IS NOT NULL
    DROP VIEW [dbo].[vw_SportBettype_ExtraInfo];
GO

CREATE VIEW [dbo].[vw_SportBettype_ExtraInfo]
WITH SCHEMABINDING
AS
	SELECT  
		ProductID,
		RefTable,
		SportTypeRef = ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.SportTypeRef') AS SMALLINT), 0),
		BettypeRef = ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.BettypeRef') AS SMALLINT), 0),
		ResourceId = ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.ResourceId') AS VARCHAR(20)), 0),
		BettypeGroup = ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.BettypeGroup') AS VARCHAR(20)), ''),
		COUNT_BIG(*) AS TotalRow
	FROM dbo.SportBettypeMatrix
	WHERE ExtraInfo IS NOT NULL
	GROUP BY
		ProductID,
		RefTable,
		ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.SportTypeRef') AS SMALLINT), 0),
		ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.BettypeRef') AS SMALLINT), 0),
		ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.ResourceId') AS VARCHAR(20)), 0),
		ISNULL(TRY_CAST(JSON_VALUE(ExtraInfo, '$.BettypeGroup') AS VARCHAR(20)), '')
GO

CREATE UNIQUE CLUSTERED INDEX CIX_vw_SportBettype_ExtraInfo
ON [dbo].[vw_SportBettype_ExtraInfo](ProductID, RefTable, SportTypeRef, BettypeRef, ResourceId, BettypeGroup);
GO

