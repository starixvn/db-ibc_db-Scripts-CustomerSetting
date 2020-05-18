/*
	Created: 20200518@Tiara
	Date: 20200518
	Task: Update stakelevel for Allbet - UUS [Redmine: #131171]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE S
SET S.MinLabel = '2', S.MaxLabel = '200', S.MinStake = 2, S.MaxStake = 200, S.ResourceId = 25
FROM StakeLevel S WITH (ROWLOCK, UPDLOCK)
WHERE S.GameTypeID = 2401 AND S.StakeLevelID = 715 AND S.ExchangeId = 20

