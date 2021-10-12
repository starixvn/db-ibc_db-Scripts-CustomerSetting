/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20210914
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l
SET l.IsInternal = 0
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 1221

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, SPName, IsInternal, ActionTypeId, Level)
SELECT 1221, 'Removed the unused account''s given credit by System', N'未使用賬戶的信用額已被系統移除', N'未使用账户的信用额已被系统移除', N'บัญชีที่ไม่ได้ใช้ถูกลบเครดิตโดยระบบ', N'Hệ thống đã xóa hạn mức được cấp cho tài khoản không sử dụng','', 0, NULL, NULL

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameEN,ActionNameTH,ActionNameEN,IsInternal,ActionNameVI
FROM @tmpAction t

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO
