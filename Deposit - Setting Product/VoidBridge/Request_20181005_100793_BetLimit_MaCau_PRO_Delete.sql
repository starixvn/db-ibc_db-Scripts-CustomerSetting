/*
	Created By: Winnie
	Created Date: 20181005
	Description: Delete Stakelevel for MaCau PRO GameTypeID BETWEEN  4031 AND 4037
	DB: DBCust/CustDB	
*/
DELETE g
FROM StakeLevelGroupDetail g
	INNER JOIN StakeLevel s WITH(NOLOCK) ON g.StakelevelID=s.StakelevelID
where g.GameTypeID BETWEEN  4031 AND 4037
	AND GameGroupID IN(1,2)
	


DELETE g
FROM Dep_StakeLevelGroupDetail g
	INNER JOIN Dep_StakeLevel s WITH(NOLOCK) ON g.StakelevelID=s.StakelevelID
WHERE g.GameTypeID BETWEEN  4031 AND 4037
	AND GameGroupID IN(3)
	
