/*
	Created: 20180314@Johnson
	Task: CWL - OneRNG - Support to add 2 new bettypes (Mobile)Roulette Pro 2321 and (Tablet)Roulette Pro 2921
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

INSERT INTO Winlimit_GameGroupSetting (ProductID, BetTypeID, GroupID)
SELECT 6,2321,3
UNION SELECT 6,2921,3

GO