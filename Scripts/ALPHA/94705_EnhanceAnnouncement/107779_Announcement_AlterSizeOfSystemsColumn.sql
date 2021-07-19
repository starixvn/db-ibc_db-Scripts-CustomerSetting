USE bodb_Message
GO

ALTER TABLE dbo.Announcements
    ALTER COLUMN Systems nvarchar(200);
GO