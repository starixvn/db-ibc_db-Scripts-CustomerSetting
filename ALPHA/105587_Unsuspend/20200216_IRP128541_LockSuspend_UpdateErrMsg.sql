/*
	Created by: Elodie
	Date: 20200216
	Task: Update ErrMsg
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCT NVARCHAR(500), MsgNameCS NVARCHAR(500), MsgNameVI NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCT, MsgNameCS, MsgNameVI)
SELECT	40033, N'您的賬號目前無權限執行此操作。 請聯系客服部門以獲得進一步的協助。謝謝!', N'您的账号目前无权限执行此操作。 请联系客服部门以获得进一步的协助。谢谢!', N'Tài khoản của bạn hiện không có quyền để thực hiện hành động này. Vui lòng liên hệ bộ phận Chăm Sóc Khách Hàng để được trợ giúp thêm.'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCS = t.MsgNameCS,
	l.MsgNameVI = t.MsgNameVI
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	
SELECT *
FROM MsgError where MsgID = 40033