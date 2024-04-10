/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240222
	Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 216,	--UU Slots
		@GameGroupID TINYINT = 1	--Slot game

INSERT INTO ProductStakeLevelGroup(Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1250 AS MaxBet, 6 AS CreditGroupID --UUS
