/*
	Created: 20180110@Vicky
	Task: Initiate Bet List permission value for sub account
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE custSub
SET PageAccess = PageAccess + '[L]'
WHERE PageAccess LIKE '%[E]%' OR PageAccess LIKE '%[D]%'


