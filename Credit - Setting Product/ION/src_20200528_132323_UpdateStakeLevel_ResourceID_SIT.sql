/*
	Created: 20200528@Eden
	Task: Update ResourceId Of StakeLevel table of ION - SIT [Redmine: 132323]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.ResourceId = 2
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 5601


