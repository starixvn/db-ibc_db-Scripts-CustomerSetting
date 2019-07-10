/*
	Created by: Elodie
	Date: 20190709
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCT NVARCHAR(500), MsgNameCN NVARCHAR(500), MsgNameEN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCT, MsgNameEN)
SELECT	70024, N'', N'', 'Insufficient Credits' UNION ALL
SELECT	70025, N'', N'', 'Credits must be positive.' UNION ALL
SELECT	70026, N'', N'', 'New Credits is out of range, please refresh the form and try again.' UNION ALL
SELECT	70027, N'', N'', 'Sorry, credit update is not successful, You have exceeded your SMA credits.' UNION ALL
SELECT	70028, N'', N'', 'Sorry, credit update is not successful, You have exceeded your master agent credits.'

UPDATE l
SET l.MsgNameEN = t.MsgNameEN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID

SELECT * FROM dbo.MsgError WHERE MsgID IN (70024, 70025, 70026, 70027, 70028)