/*
	Created by: Elodie
	Date: 20190408
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCS NVARCHAR(500), MsgNameCN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCS)
SELECT	40041, N'无效的股东', N'無效的股東' UNION ALL
--SELECT	40001, N'', N'' UNION ALL
--SELECT	40004, N'', N'' UNION ALL
--SELECT	40030, N'', N'' UNION ALL
--SELECT	40032, N'', N'' UNION ALL
--SELECT	90011, N'', N'' UNION ALL
--SELECT	70003, N'', N'' UNION ALL
--SELECT	40029, N'', N'' UNION ALL
--SELECT	70027, N'', N'' UNION ALL --new msg
--SELECT	70028, N'', N'' UNION ALL --new msg

UPDATE l
SET l.MsgNameCS = t.MsgNameCS,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
