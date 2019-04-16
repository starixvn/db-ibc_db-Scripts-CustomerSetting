/*
	Created: Johnson@20190412
	DB: DBCUST/CustDB
	Task: update translate message for cn88
*/

SELECT 40021 as msgID, N'Old password is incorrect.' as MsgEn, N'旧密码错误' as msgCN
INTO #tmp
UNION SELECT 40006 as msgID, N'Nickname is not available' as MsgEn, N'昵称已有人使用。' as msgCN
UNION SELECT 80002 as msgID, N'Account closed. Please contact your administrator!' as MsgEn, N'账户遭关闭，请联系管理员！' as msgCN

UPDATE Msg
SET msg.MsgNameCN = t.msgCn
FROM MsgError msg
	INNER JOIN #tmp t ON msg.MsgID = t.MsgID