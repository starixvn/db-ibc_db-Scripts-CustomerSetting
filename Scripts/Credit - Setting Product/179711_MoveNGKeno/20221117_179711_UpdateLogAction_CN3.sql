/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20210730
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO
DECLARE @tmpAction TABLE (ActionID INT, ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameVI)
SELECT 220039, N'Cập nhật Giới Hạn Cược Sportsbook cho Super' 
UNION ALL 
SELECT 220040, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Super'
UNION ALL
SELECT 220041, N'Cập nhật Giới Hạn Cược Sportsbook cho Master' 
UNION ALL 
SELECT 220042, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Master'
UNION ALL
SELECT 220043, N'Cập nhật Giới Hạn Cược Sportsbook cho Agent' 
UNION ALL 
SELECT 220044, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Agent' 
UNION ALL
SELECT 220045, N'Cập nhật Giới Hạn Cược Sportsbook cho Member' 

UPDATE l
SET l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

GO