/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240222
	Task: UUSlots - Integrate New Product - Implement Customer setting , Initial Setting [Redmine: #192601]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 216,	--UU Slots
		@GameGroupID TINYINT = 1	--Slot game

INSERT INTO Dep_ProductStakeLevelGroup(Sporttype, GameGroupID, MinBet, MaxBet, LicenseeGroupID)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 4000	AS MaxBet, 5	AS LicenseeGroupID UNION ALL --CNY(RMB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 500	AS MaxBet, 4	AS LicenseeGroupID UNION ALL --EUR(EURO)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 7500	AS MaxBet, 7	AS LicenseeGroupID UNION ALL --IDR(IN)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 42500	AS MaxBet, 15	AS LicenseeGroupID UNION ALL --INR(INR)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 75000	AS MaxBet, 8	AS LicenseeGroupID UNION ALL --JPY(JPY)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 500000	AS MaxBet, 10	AS LicenseeGroupID UNION ALL --KRW(Won)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 2000	AS MaxBet, 16	AS LicenseeGroupID UNION ALL --MMK(MKK)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 2500	AS MaxBet, 1	AS LicenseeGroupID UNION ALL --MYR(RM)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 50000	AS MaxBet, 14	AS LicenseeGroupID UNION ALL --RUB(RUB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 17500	AS MaxBet, 3	AS LicenseeGroupID UNION ALL --THB(TB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 500	AS MaxBet, 2	AS LicenseeGroupID UNION ALL --USD(US$,USDT)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 12500	AS MaxBet, 13	AS LicenseeGroupID			 --VND(INH)











