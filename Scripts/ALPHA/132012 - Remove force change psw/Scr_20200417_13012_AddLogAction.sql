/*
	Created: 20200417@Eden
	Task: Insert LogAction for Remve force change password
	RM: #132012
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT,ActionNameCS NVARCHAR(256),ActionNameCH NVARCHAR(256),ActionNameTH NVARCHAR(256),ActionNameVI NVARCHAR(256))
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level,ActionNameCS,ActionNameCH,ActionNameTH,ActionNameVI)
SELECT 945, 'Skip Changing Password', 'Age_CustomerSkipForceUpdPwd', 0, NULL, NULL,N'略过更换密码',N'略過更换密碼',N'ข้ามการเปลี่ยนรหัสผ่าน',N'Bỏ Thay Đổi Mật Khẩu'

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionNameCH,ActionNameCS,ActionName,ActionNameTH,ActionName,IsInternal,ActionNameVI,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--select * from LogAction (NOLOCK) where actionid = 945