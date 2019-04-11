/*
	Created by: Elodie
	Date: 20190411
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE l
SET l.MsgNameCN = l.MsgNameCS
FROM dbo.MsgError l WITH (ROWLOCK)
WHERE l.MsgID = 40038
