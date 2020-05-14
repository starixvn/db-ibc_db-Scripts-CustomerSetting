/*
	Created: 20200514@Tiara
	Date: 20200514
	Task: Remove unused stakelevel for SAGaming  [Redmine: #134176]
	DB: DBCUST/CustDB
*/
--StakeLevel
 
USE CustDB
GO

DELETE D 
FROM Dep_StakeLevel D WITH (ROWLOCK)
WHERE D.GameTypeID = 3001 
	AND D.ExchangeID IN (13,5,67)
