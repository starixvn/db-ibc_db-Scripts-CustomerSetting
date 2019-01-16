/*
	Created: Johnson
	Date: 20190116
	Task: hide VIP Baccarat for Allbet
	DB: DBCUST/CUSTDB
*/

USE CustDB
GO

UPDATE ProductSettingDetail WITH(UPDLOCK,ROWLOCK)
SET SettingStatus = 2--hide vip baccarat
WHERE SportType = 211 
	AND bettype = 2402
	AND SettingType IN (7,13)--stakelevel & status
GO