/*
	Created: 20200227@Elodie
	DB: DBTXN/bodb02
	Task: Remove PT reference MuayThai of CN88 
*/

USE bodb02
GO

DELETE
FROM [dbo].[Sport_Bettype_Reference_Setting]
WHERE sporttype = 44
	AND site = 'CN88'