/*
	Created: 20190517@Elodie	
	Task: Update data
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

SELECT ActionID INTO #tmp
FROM [dbo].[LogAction] WITH(NOLOCK)
where ActionNameEN LIKE '%Keno%'

UPDATE l
SET l.ActionNameEN = REPLACE(l.ActionNameEN, 'Keno', 'RNG Keno'),
	l.ActionNameCH = CASE WHEN ActionNameCH LIKE '%Keno%' THEN REPLACE(l.ActionNameCH, 'Keno', 'RNG Keno') ELSE l.ActionNameCH END,
	l.ActionNameCS = CASE WHEN ActionNameCS LIKE '%Keno%' THEN REPLACE(l.ActionNameCS, 'Keno', 'RNG Keno') ELSE l.ActionNameCS END,
	l.ActionNameJP = CASE WHEN ActionNameJP LIKE '%Keno%' THEN REPLACE(l.ActionNameJP, 'Keno', 'RNG Keno') ELSE l.ActionNameJP END,
	l.ActionNameIT = CASE WHEN ActionNameIT LIKE '%Keno%' THEN REPLACE(l.ActionNameIT, 'Keno', 'RNG Keno') ELSE l.ActionNameIT END,
	l.ActionNameTH = CASE WHEN ActionNameTH LIKE '%Keno%' THEN REPLACE(l.ActionNameTH, 'Keno', 'RNG Keno') ELSE l.ActionNameTH END,
	l.ActionNameKO = CASE WHEN ActionNameKO LIKE '%Keno%' THEN REPLACE(l.ActionNameKO, 'Keno', 'RNG Keno') ELSE l.ActionNameKO END,
	l.ActionNameVI = CASE WHEN ActionNameVI LIKE '%Keno%' THEN REPLACE(l.ActionNameVI, 'Keno', 'RNG Keno') ELSE l.ActionNameVI END,
	l.ActionNameCN = CASE WHEN ActionNameCN LIKE '%Keno%' THEN REPLACE(l.ActionNameCN, 'Keno', 'RNG Keno') ELSE l.ActionNameCN END
FROM LogAction l WITH (NOLOCK)
	INNER JOIN #tmp t ON t.ActionID = l.ActionID 

SELECT l.*
FROM dbo.LogAction l WITH (NOLOCK)
	INNER JOIN #tmp t ON t.ActionID = l.ActionID 