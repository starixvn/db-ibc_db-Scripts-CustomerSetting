/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210413@Tina
	Task: insert new message [redmine: #148600]
	DB: DBCUST.custDB
*/

USE [CustDB]
GO

IF NOT EXISTS (SELECT 1 FROM dbo.MsgError M WITH (NOLOCK) WHERE M.MsgID = 40057)
BEGIN
	INSERT INTO MsgError (MsgID, MsgGroupID, MsgNameEN, IsActive)
	SELECT 40057 MsgID, 5 MsgGroupID, 'This account is locked, please unlock it and try again.' MsgNameEN, 1 IsActive
END

UPDATE MsgError 
SET MsgNameCS = N'此账号已被锁定，请解锁后再次重试。', --Chinese Simplified (zh-CN)
	MsgNameCT = N'此賬號已被鎖定，請解鎖後再次重試。', --Chinese Traditional (zh-TW)
	MsgNameTH = N'บัญชีนี้ถูกล็อก กรุณาปลดล็อกและลองใหม่อีกครั้ง' --Thai
WHERE MsgID = 40057


