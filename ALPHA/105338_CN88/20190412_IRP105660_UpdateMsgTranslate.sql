/*
	Created: Johnson@20190412
	DB: DBCUST/CustDB
	Task: update translate message for cn88
*/
--run this script on DBCUST/CUSTDB
USE CustDB
GO

SELECT 40021 as msgID, N'Old password is incorrect.' as MsgEn, N'旧密码错误' as msgCN
INTO #tmp
UNION SELECT 40006 as msgID, N'Nickname is not available' as MsgEn, N'昵称已有人使用。' as msgCN
UNION SELECT 80002 as msgID, N'Account closed. Please contact your administrator!' as MsgEn, N'账户遭关闭，请联系管理员！' as msgCN

UPDATE Msg
SET msg.MsgNameCN = t.msgCn
FROM MsgError msg
	INNER JOIN #tmp t ON msg.MsgID = t.MsgID
GO
	
--run this script on DBLOG/bodb_CustomerLog
USE	bodb_CustomerLog
GO


DECLARE @tmpAction TABLE (ActionID INT, ActionNameCN NVARCHAR(256),ActionNameEN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCN,ActionNameEN)
SELECT	902,N'Reset own password',N'Reset own password'
UNION SELECT 622, N'设定只能使用「昵称」登入', N'Set login option by nickname only'
UNION SELECT 621, N'创建昵称', N'Create nickname'

UPDATE l
SET l.actionNameCN = ISNULL(t.ActionNameCN,l.ActionNameCN)
FROM LogAction l WITH(UPDLOCK,ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID