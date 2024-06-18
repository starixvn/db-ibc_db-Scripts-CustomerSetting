/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240618@Tacy
	Task: MsgError - Notify Member Last bets - CN3 [Redmine: #193689]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE MsgError WITH (ROWLOCK, UPDLOCK)
SET MsgNameVI=N'Số lượng bộ lọc đã bật thông báo đã vượt quá giới hạn tối đa là 3.'
WHERE MsgID = 90027
GO