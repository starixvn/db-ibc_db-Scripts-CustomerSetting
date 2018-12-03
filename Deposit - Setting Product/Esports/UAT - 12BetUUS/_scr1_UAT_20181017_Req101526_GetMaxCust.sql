/*
	Created: Winnie
	Date: 20181017
	Task: Delete existing data of Deposit Esports
	DB: DBCust/CustDB
*/
USE CustDB
GO

SELECT MAX(CustID) FROM Customer WITH(NOLOCK)
