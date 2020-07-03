/*
	Created: 20200702@Elodie
	Task: Update BlockNewCusti7 flag [#RM:136700]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE dbo.Site 
SET BlockNewCust = 0
WHERE site IN ('755555')
