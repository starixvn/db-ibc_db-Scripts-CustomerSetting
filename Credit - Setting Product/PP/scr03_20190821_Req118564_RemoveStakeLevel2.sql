/*
	Created: Winnie
	Task: Remove stake level 2. [RedmineID:#118564]
	DB: DBCUST/CustDB
	Date: 20190821
*/ 

CREATE TABLE #tmpLevel2(GameTypeID INT,GameGroupID INT)	
INSERT INTO #tmpLevel2(GameTypeID ,GameGroupID )
SELECT 4001,2
UNION ALL
SELECT 4101,7


DELETE sd
FROM stakelevel s WITH(NOLOCK) 	
	INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 
	INNER JOIN  StakeLevelGroupDetail sd ON s.StakeLevelID=sd.StakeLevelID

DELETE s
FROM stakelevel s 
	INNER JOIN #tmpLevel2 t ON s.GameTypeID=t.GameTypeID AND s.GameGroupID=t.GameGroupID 

DROP TABLE #tmpLevel2

