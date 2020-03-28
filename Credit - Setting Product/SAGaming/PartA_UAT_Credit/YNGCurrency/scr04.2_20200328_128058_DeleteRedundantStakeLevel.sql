/*
	Created: 20200218@Tiara
	Task: Delete redundant StakeLevel for SA Gaming and Sexy Gaming Redmine: #128128
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE S
FROM StakeLevel S WITH (ROWLOCK)
WHERE S.GameTypeID BETWEEN 3002 AND 3007


DELETE S
FROM StakeLevel S WITH (ROWLOCK)
WHERE S.GameTypeID BETWEEN 3102 AND 3105

