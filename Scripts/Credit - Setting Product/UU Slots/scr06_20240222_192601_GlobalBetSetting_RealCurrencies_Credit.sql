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
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 5000	AS MaxBet, 1	AS CreditGroupID UNION ALL	--MYR(RM),HKD(HKK) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 17500	AS MaxBet, 2	AS CreditGroupID UNION ALL	--IDR(IN,IND,IDD,IDR,DDD)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1250	AS MaxBet, 3	AS CreditGroupID UNION ALL	--USD(US$,Yen,$US,UT,USD)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 3750	AS MaxBet, 5	AS CreditGroupID UNION ALL	--CNY(RMB) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 5000	AS MaxBet, 4	AS CreditGroupID UNION ALL	--HKD(HK$)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 350000 AS MaxBet, 8	AS CreditGroupID UNION ALL	--KRW(Won)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1000	AS MaxBet, 10	AS CreditGroupID UNION ALL	--MMK(MMK) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 37500	AS MaxBet, 7	AS CreditGroupID UNION ALL	--THB(THB) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 50000	AS MaxBet, 12	AS CreditGroupID			--PHP(PC) 
