/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240918
	Task: BG - Clean global bet limit - RMB  [Redmine:#210585] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

CREATE TABLE #tmpSetting (
		StakeLevelID	INT
		,GameTypeID		SMALLINT
		,ExchangeID		INT
		,SiteID			INT
)


--Get lowest bet limit
;WITH tmpSiteCurrency AS (
	SELECT siteid, ExchangeID, GameTypeID
	FROM Dep_StakeLevel WITH (NOLOCK)
	WHERE GameTypeID=3501 AND ExchangeID=13
	GROUP BY siteid, ExchangeID, GameTypeID
	HAVING COUNT(1)>1
)
INSERT INTO #tmpSetting (StakeLevelID, GameTypeID, SiteID, ExchangeID)
SELECT sl.StakeLevelID, t.GameTypeID, t.SiteID, t.ExchangeID
FROM tmpSiteCurrency t
CROSS APPLY (SELECT TOP 1 sl.StakeLevelID
			 FROM Dep_StakeLevel sl WITH (NOLOCK)
			 WHERE t.GameTypeID=sl.GameTypeID
			 AND t.SITEID=sl.SiteID
			 AND t.ExchangeID=sl.ExchangeID
			 ORDER BY sl.MinStake, sl.MaxStake
			 )sl

DELETE sl
FROM Dep_StakeLevel sl WITH (ROWLOCK)
INNER JOIN #tmpSetting t 
		ON t.GameTypeID=sl.GameTypeID
		AND t.SITEID=sl.SiteID
		AND t.ExchangeID=sl.ExchangeID
		AND t.StakeLevelID<>sl.StakeLevelID
GO