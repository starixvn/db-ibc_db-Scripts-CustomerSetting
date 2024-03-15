/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240315
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 189,	--Yolo Play
		@GameGroupID TINYINT = 2	--Others

INSERT INTO ProductStakeLevelGroup(Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 50000 AS MaxBet, 6 AS CreditGroupID --UUS
