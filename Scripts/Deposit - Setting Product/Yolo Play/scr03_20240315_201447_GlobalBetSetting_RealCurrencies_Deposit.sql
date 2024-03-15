/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240222
	Task: Yolo Play - Implement customer setting - initial setting [Redmine: #201447]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 189,	--Yolo Play
		@GameGroupID TINYINT = 2	--Others
		

INSERT INTO Dep_ProductStakeLevelGroup(Sporttype, GameGroupID, MinBet, MaxBet, LicenseeGroupID, SiteID)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 100000		AS MaxBet, 20	AS LicenseeGroupID, 0 AS SiteID UNION ALL --BDT(BDT)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1500		AS MaxBet, 11	AS LicenseeGroupID, 0 AS SiteID UNION ALL --BND(BND)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 5000		AS MaxBet, 18	AS LicenseeGroupID, 0 AS SiteID UNION ALL --BRL(BRL)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 8000		AS MaxBet, 5	AS LicenseeGroupID, 0 AS SiteID UNION ALL --CNY(RMB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 4000000	AS MaxBet, 19	AS LicenseeGroupID, 0 AS SiteID UNION ALL --COP(COP)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1000		AS MaxBet, 4	AS LicenseeGroupID, 0 AS SiteID UNION ALL --EUR(EURO)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 15000		AS MaxBet, 7	AS LicenseeGroupID, 0 AS SiteID UNION ALL --IDR(IN)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 85000		AS MaxBet, 15	AS LicenseeGroupID, 0 AS SiteID UNION ALL --INR(INR)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 150000		AS MaxBet, 8	AS LicenseeGroupID, 0 AS SiteID UNION ALL --JPY(JPY)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 4000		AS MaxBet, 17	AS LicenseeGroupID, 0 AS SiteID UNION ALL --KHR(KHR)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1000000	AS MaxBet, 10	AS LicenseeGroupID, 0 AS SiteID UNION ALL --KRW(Won)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 2000		AS MaxBet, 16	AS LicenseeGroupID, 0 AS SiteID UNION ALL --MMK(MKK)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 15000		AS MaxBet, 12	AS LicenseeGroupID, 0 AS SiteID UNION ALL --MXN(MXN)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 5000		AS MaxBet, 1	AS LicenseeGroupID, 0 AS SiteID UNION ALL --MYR(RM)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 100000		AS MaxBet, 22	AS LicenseeGroupID, 0 AS SiteID UNION ALL --NPR(NPR)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 300000		AS MaxBet, 21	AS LicenseeGroupID, 0 AS SiteID UNION ALL --PKR(PKR)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 100000		AS MaxBet, 14	AS LicenseeGroupID, 0 AS SiteID UNION ALL --RUB(RUB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 35000		AS MaxBet, 3	AS LicenseeGroupID, 0 AS SiteID UNION ALL --THB(TB)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 1000		AS MaxBet, 2	AS LicenseeGroupID, 0 AS SiteID UNION ALL --USD(US$,USDT)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 0.01 AS MinBet, 25000		AS MaxBet, 13	AS LicenseeGroupID, 0 AS SiteID	UNION ALL --VND(INH)
	SELECT @Sporttype AS Sporttype, @GameGroupID AS GameGroupID, 1	  AS MinBet, 2500		AS MaxBet, 3	AS LicenseeGroupID, 875 AS SiteID		  --THB(TB) SEAL888
