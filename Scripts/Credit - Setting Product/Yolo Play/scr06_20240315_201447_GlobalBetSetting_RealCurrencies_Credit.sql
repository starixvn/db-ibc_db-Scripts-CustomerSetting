/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20240315
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 189,	--Yolo Play
		@GameGroupID TINYINT = 2	--Others

INSERT INTO ProductStakeLevelGroup(Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 5000	AS MaxBet, 1	AS CreditGroupID UNION ALL	--MYR(RM),HKD(HKK) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 20000	AS MaxBet, 2	AS CreditGroupID UNION ALL	--IDR(IN,IND,IDD,IDR,DDD)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 5000	AS MaxBet, 3	AS CreditGroupID UNION ALL	--USD(US$,Yen,$US,UT,USD)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 5000	AS MaxBet, 5	AS CreditGroupID UNION ALL	--CNY(RMB) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 5000	AS MaxBet, 4	AS CreditGroupID UNION ALL	--HKD(HK$)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 300000	AS MaxBet, 8	AS CreditGroupID UNION ALL	--KRW(Won)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 20000	AS MaxBet, 7	AS CreditGroupID UNION ALL	--THB(THB) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 25000	AS MaxBet, 9	AS CreditGroupID UNION ALL	--VND(INH) 
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.1 AS MinBet, 50000	AS MaxBet, 12	AS CreditGroupID			--PHP(PC) 
