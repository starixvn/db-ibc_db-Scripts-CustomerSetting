/*
	Created by: Elodie
	Date: 20200131
	Task: Correct LogAction for Transfer Option
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT 700, 'Update Transfer Condition', 'Acc_CustomerUpdTransferOption', 0, 4, NULL 

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t

UPDATE l
SET l.ActionNameCS = N'默认个人头像已添加成功。',
	l.ActionNameCH = N'默認個人頭像已添加成功。',
	l.ActionNameTH = N'รูปโปรไฟล์ เพิ่มสำเร็จแล้ว',
	l.ActionNameVI = N'Ảnh đại diện đã được thêm vào'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 700

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO