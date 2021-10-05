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
SELECT 220020, N'Cập nhật Giới Hạn Cược Sportsbook cho Super' 
UNION ALL 
SELECT 220021, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Super'
UNION ALL
SELECT 220022, N'Cập nhật Giới Hạn Cược Sportsbook cho Master' 
UNION ALL 
SELECT 220023, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Master'
UNION ALL
SELECT 220024, N'Cập nhật Giới Hạn Cược Sportsbook cho Agent' 
UNION ALL 
SELECT 220025, N'Cập nhật gián tiếp Giới Hạn Cược Sportsbook cho Agent' 
UNION ALL
SELECT 220026, N'Cập nhật Giới Hạn Cược Sportsbook cho Member' 
UNION ALL 
SELECT 379, N'Cập nhật Giới Hạn Cược RNG Keno cho Super'
UNION ALL
SELECT 380, N'Cập nhật Giới Hạn Cược RNG Keno cho Master' 
UNION ALL 
SELECT 381, N'Cập nhật Giới Hạn Cược RNG Keno cho Agent' 
UNION ALL
SELECT 382, N'Cập nhật Giới Hạn Cược RNG Keno cho Member' 

UPDATE l
SET l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

GO