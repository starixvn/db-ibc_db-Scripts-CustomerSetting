/*
	Created: 20200514@Tiara
	Date: 20200514
	Task: Remove unused stakelevel for SAGaming  [Redmine: #134176]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

	
DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3001 
	AND S.ExchangeId IN (13,5,67)

