/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240513@Tacy
	Task: Add new error message [#204089]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO MsgError ([MsgID], [MsgGroupID], [MsgNameEN], [MsgNameCT], [MsgNameCS], [MsgNameJP], [MsgNameTH], [MsgNameKO], [MsgNameES], [MsgNameVI], [IsActive])
VALUES 
	(40067,5,N'Member username is invalid.',N'會員賬號無效。',N'会员账号无效。',N'Member username is invalid.',N'ชื่อผู้ใช้สมาชิกไม่ถูกต้อง',N'Member username is invalid.',N'Member username is invalid.',N'Tên người dùng của Member không đúng.',1)
GO