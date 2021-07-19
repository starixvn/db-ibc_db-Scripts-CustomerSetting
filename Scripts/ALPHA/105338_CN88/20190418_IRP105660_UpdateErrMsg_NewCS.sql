/*
	Created by: Elodie
	Date: 20190418
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--8 affected rows
UPDATE l
SET l.MsgNameCN = l.MsgNameEN
FROM dbo.MsgError l WITH (ROWLOCK)
WHERE MsgNameCN IS NULL
