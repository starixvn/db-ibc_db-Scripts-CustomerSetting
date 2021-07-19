/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210708@Elodie
	Task: Update MsgError 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameVI NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameVI)
SELECT 10055, N'Giá trị phải là một số dương.'
UNION ALL
SELECT 10056, N'<Bet Type>: Thiết lập của <Column> cao hơn của cấp trên.'
UNION ALL
SELECT 10058, N'Thiết lập này sẽ thay thế cho thiết lập của những cấp dưới nào có giá trị cao hơn thiết lập mới này. Bạn có chắc muốn tiếp tục?'
UNION ALL
SELECT 40057, N'Tài khoản này đã bị khóa, vui lòng mở khóa và thử lại.'
UNION ALL
SELECT 80007, N'Tài khoản của bạn đã bị khóa do nhiều lần xác thực không thành công. Vui lòng liên hệ với cấp trên của bạn để mở khóa.'
UNION ALL
SELECT 40045, N'Tài khoản của bạn đã bị khóa do nhiều lần xác thực không thành công. Vui lòng liên hệ với cấp trên của bạn để mở khóa.'

UPDATE l
SET l.MsgNameVI = t.MsgNameVI
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID

SELECT * 
FROM MSgError l WITH (NOLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID