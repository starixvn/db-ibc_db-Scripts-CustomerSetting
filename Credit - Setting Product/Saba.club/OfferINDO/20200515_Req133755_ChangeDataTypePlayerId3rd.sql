/*
	Created: 20200515@Elodie
	Task: Change datatype of PlayerId3rd [#RM:133755]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE dbo.CustUserMapping3rd ALTER COLUMN PlayerID3rd VARCHAR(50) NOT NULL