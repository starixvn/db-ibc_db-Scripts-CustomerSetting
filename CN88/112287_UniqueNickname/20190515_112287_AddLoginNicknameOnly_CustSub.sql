/*
	Created: 20190422@Elodie
	Task: Add NicknameLoginOnly column into CustSub
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

ALTER TABLE dbo.custSub ADD NicknameLoginOnly BIT NULL
GO