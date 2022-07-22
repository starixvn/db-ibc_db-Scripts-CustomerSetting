/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220721@Tacy
	Task: Initial global betlimit's SABA Casino for KHR and follow MYR currency.
		 https://nexdev.net/issues/175686 [RedmineID: #175686]
	Database: DBCUST/CustDB
*/
DECLARE @Dep_MaxSLID INT

SELECT @Dep_MaxSLID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel ([GameTypeID], [GameGroupID], [MinLabel], [MaxLabel], [MinStake], [MaxStake], [ExchangeID], [ResourceId], [SiteID], [StakeLevelID])
SELECT [GameTypeID], [GameGroupID], [MinLabel], [MaxLabel], [MinStake], [MaxStake], 71 AS [ExchangeID], [ResourceId], [SiteID], 
		StakeLevelID = @Dep_MaxSLID + ROW_NUMBER() OVER(ORDER BY GameTypeID,exchangeid)
FROM Dep_StakeLevel WITH (NOLOCK)
WHERE ExchangeID = 2  AND  GameTypeID=2101


;WITH tmp AS (
	SELECT MIN([StakeLevelID]) [StakeLevelID]
	FROM Dep_StakeLevelGroupDetail slg WITH (NOLOCK)
	WHERE ((slg.GameTypeID between 2101 and 2199) or (slg.GameTypeID between 2201 and 2299))
	AND EXISTS (SELECT 1 FROM Dep_StakeLevel sl WITH (NOLOCK) WHERE GameTypeID=2101 AND ExchangeID=2 AND slg.StakeLevelID=sl.StakeLevelID)
)
INSERT INTO Dep_StakeLevelGroupDetail([StakeLevelID], [GameTypeID], [MinLabel], [MaxLabel], [MinStake], [MaxStake], [ParentTypeID], [MaxGameStake])
SELECT DISTINCT sl.[StakeLevelID], slg.[GameTypeID], slg.[MinLabel], slg.[MaxLabel], slg.[MinStake], slg.[MaxStake], slg.[ParentTypeID], slg.[MaxGameStake]
FROM Dep_StakeLevelGroupDetail slg WITH (NOLOCK)
	INNER JOIN tmp t ON t.StakeLevelID=slg.StakeLevelID
	CROSS APPLY (SELECT MIN(StakeLevelID) StakeLevelID FROM Dep_StakeLevel sl WITH (NOLOCK) WHERE sl.GameTypeID=2101 AND sl.ExchangeID=71) sl
WHERE ((slg.GameTypeID between 2101 and 2199) or (slg.GameTypeID between 2201 and 2299))
UNION
SELECT DISTINCT sl.[StakeLevelID], slg.[GameTypeID], slg.[MinLabel], slg.[MaxLabel], slg.[MinStake], slg.[MaxStake], slg.[ParentTypeID], slg.[MaxGameStake]
FROM Dep_StakeLevelGroupDetail slg WITH (NOLOCK)
	CROSS APPLY (SELECT MAX(StakeLevelID) StakeLevelID FROM Dep_StakeLevel sl WITH (NOLOCK) WHERE sl.GameTypeID=2101 AND sl.ExchangeID=71) sl
WHERE ((slg.GameTypeID between 2101 and 2199) or (slg.GameTypeID between 2201 and 2299))
AND EXISTS (SELECT 1 FROM Dep_StakeLevel sl WITH (NOLOCK) WHERE GameTypeID=2101 AND ExchangeID=2 AND slg.StakeLevelID=sl.StakeLevelID)
AND slg.StakeLevelID NOT IN (SELECT StakeLevelID FROM tmp)