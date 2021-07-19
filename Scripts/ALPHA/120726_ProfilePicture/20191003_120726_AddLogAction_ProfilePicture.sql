/*
	Created by: Elodie
	Date: 20191009
	Task: Insert LogAction for Profile picture
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT 697, 'Default profile picture has been added.', 'Age_CustomerUpdProfilePicture', 0, 4, NULL UNION ALL
SELECT 698, 'Default profile picture has been changed to user''s picture.', 'Age_CustomerUpdProfilePicture', 0, 4, NULL UNION ALL
SELECT 699, 'User''s profile picture has been changed to default.', 'Age_CustomerUpdProfilePicture', 0, 4, NULL UNION ALL
SELECT 700, 'Default profile picture has been changed.', 'Age_CustomerUpdProfilePicture', 0, 4, NULL UNION ALL
SELECT 701, 'User''s profile picture has been changed.', 'Age_CustomerUpdProfilePicture', 0, 4, NULL

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName
FROM @tmpAction t

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO