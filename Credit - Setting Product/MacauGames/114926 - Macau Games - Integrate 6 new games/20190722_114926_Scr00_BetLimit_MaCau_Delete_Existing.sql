/*
	Created By: Eden
	Created Date: 20190722
	Description: Delete Stakelevel for MaCau GameTypeID BETWEEN  4038 AND 4043
	DB: DBCust/CustDB	
*/

DELETE g
FROM StakeLevelGroupDetail g
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON g.StakelevelID = s.StakelevelID
WHERE g.GameTypeID BETWEEN 4038 AND 4043
      AND GameGroupID IN(1, 2);

DELETE g
FROM Dep_StakeLevelGroupDetail g
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON g.StakelevelID = s.StakelevelID
WHERE g.GameTypeID BETWEEN 4038 AND 4043
      AND GameGroupID IN(3);
	
