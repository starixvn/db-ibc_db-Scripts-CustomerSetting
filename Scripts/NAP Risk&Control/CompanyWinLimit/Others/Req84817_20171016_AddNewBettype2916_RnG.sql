/*
	Created: 20171016@Johnson
	Task: CWL - OneRNG - Support to add new bettype 2916 (Tablet)Texas Hold'em
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

INSERT INTO Winlimit_GameGroupSetting (ProductID, BetTypeID, GroupID)
VALUES (6,2916,3)

GO