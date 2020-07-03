/*
	Created: 20200702@Elodie
	Task: Update BlockNewCusti7 flag [#RM:136700]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE dbo.Site 
SET BlockNewCust = 1,
	UnblockTime = '03:30 PM (GMT+8)'
WHERE site IN ('755555')
