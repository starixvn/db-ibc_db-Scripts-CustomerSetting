/*
	Created: Eden@20210111
	Task: insert GameGroup = 20 - Level 2 for Saba.Club [#147941]
	DB: DBCust/CustDB
*/
USE CUSTDB
GO
INSERT INTO GameGroup (GameGroupID,GroupName,RefSportType,RefBetType,IsDeposit)
SELECT 20, 'Level 2', 200, 1611, 0

--SELECT * FROM GameGroup (NOLOCK) WHERE GameGroupID = 20