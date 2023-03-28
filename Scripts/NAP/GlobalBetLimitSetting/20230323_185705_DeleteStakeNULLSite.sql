/*<info serverAliAS="DBCUST-CustDB"></info>*/
/*
	Created: 20230323@Tacy
	Task: Delete - SiteID's Dep_StakeLevel is NULL
		https://nexdev.net/issues/185705
*/
USE CustDB
GO

DELETE sd
FROM Dep_StakeLevelGroupDetail sd WITH (ROWLOCK)
INNER JOIN Dep_StakeLevel s WITH (NOLOCK) ON sd.StakeLevelID=s.StakeLevelID
WHERE s.SiteID IS NULL AND s.GameGroupID=0

DELETE FROM Dep_StakeLevel WITH (ROWLOCK)
WHERE SiteID IS NULL and GameGroupID=0