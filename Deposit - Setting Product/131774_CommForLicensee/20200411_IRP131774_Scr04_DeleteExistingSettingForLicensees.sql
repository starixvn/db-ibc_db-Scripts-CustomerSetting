/*
	Created: Johnson
	Date: 2020-04-11
	Task: Delete existing Allbet comm setting
	DB: DBCUST/CustDB
*/
--2452 rows affected
DELETE Dep_CustDiscountGroupSetting_Member WITH(UPDLOCK,ROWLOCK)
WHERE sporttype = 211
GO

--1447 rows affected
DELETE Dep_CustDiscountSetting_Member WITH(UPDLOCK,ROWLOCK)
WHERE sporttype = 211