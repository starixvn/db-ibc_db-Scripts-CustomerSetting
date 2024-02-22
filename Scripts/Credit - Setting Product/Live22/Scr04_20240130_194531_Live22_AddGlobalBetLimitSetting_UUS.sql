/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240130
	Task: initial data for ProductStakeLevelGroup & Dep_ProductStakeLevelGroup - UUS [Redmine:#194531] 
	DB:	DBCUST-CustDB

	Revision:
		- 20240221@Tacy: Credit - Update MinBet 0.1 --> 0.01
*/
USE CustDB
GO
/*
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet)
SELECT 227,	1,	6,	0.1,	1250
GO
		
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)	 
SELECT 227,	1,	6,	0.01,	500,	0
GO
*/

UPDATE ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET MinBet=0.01, RepUpdateTime=SYSDATETIME()
WHERE Sporttype=227 AND CreditGroupID=6
GO