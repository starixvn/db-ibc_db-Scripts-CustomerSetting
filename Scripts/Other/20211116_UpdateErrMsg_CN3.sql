/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211116@Elodie
	Task: Update MsgError 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameVI NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameVI)
SELECT 10068, N'Bạn đã vượt quá số lần cho phép cập nhật Position Taking mỗi ngày (tối đa 2 lần). Vui lòng thử lại sau {0} 12:00 PM GMT+8.'

UPDATE l
SET l.MsgNameVI = t.MsgNameVI
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID

SELECT * 
FROM MSgError l WITH (NOLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID