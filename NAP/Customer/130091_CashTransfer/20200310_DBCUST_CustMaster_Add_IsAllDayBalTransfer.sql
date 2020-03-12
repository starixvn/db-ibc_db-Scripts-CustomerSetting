USE CustDB
GO

/*
	Created: 20200310@Percy
	DB: DBCUST.CustDB
	Task: Add new column IsAllDayBalTransfer on CustMaster
	Remark: This table is in publication: CustDB_Customer_Info
*/

ALTER TABLE dbo.CustMaster
	ADD IsAllDayBalTransfer BIT NULL
GO