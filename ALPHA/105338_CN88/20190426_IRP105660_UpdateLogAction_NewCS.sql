/*
	Created by: Elodie
	Date: 20190405
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH, ActionNameCN)
SELECT	1213, N'建立股東時設定信用額度', N'创建股东时设定信用额度' UNION ALL
SELECT	1220, N'更新股東信用額度', N'更新股东信用额度' UNION ALL

SELECT	119997, N'增加股東的佔成數', N'添加股东的占成数' UNION ALL
SELECT	100000, N'更新股東的佔成數', N'更新股东的占成数' UNION ALL

SELECT	139996, N'增加股東的退水值', N'添加股东的退水值' UNION ALL
SELECT	120000, N'更新股東的退水設定', N'更新股东的退水设定' UNION ALL

SELECT	149996, N'增加股東的限額', N'添加股东的限额' UNION ALL
SELECT	140000, N'更新股東的限額', N'更新股东的限额' UNION ALL

SELECT	160000, N'為股東增加一般資訊', N'为股东添加一般信息' UNION ALL
SELECT	160004, N'更新股東的一般資訊', N'更新股东的一般信息' UNION ALL

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
