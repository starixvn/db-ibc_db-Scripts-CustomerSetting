/*
	Created: 20200508@Elodie
	Task: Update BlockNewCusti7 flag [#RM:133755]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE dbo.Site 
SET BlockNewCust = 0,
	UnblockTime = '01:30 PM (GMT+8)'
WHERE site IN ('Indo', 'IbcIndo')
