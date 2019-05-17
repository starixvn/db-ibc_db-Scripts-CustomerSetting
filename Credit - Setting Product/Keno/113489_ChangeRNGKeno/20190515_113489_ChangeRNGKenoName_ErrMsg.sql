/*
	Created: 20190517@Elodie	
	Task: Update data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MsgID INTO #tmp
FROM [dbo].MsgError WITH(NOLOCK)
where MsgNameEN LIKE '%Keno%'

UPDATE m
SET m.MsgNameEN = REPLACE(m.MsgNameEN, 'Keno', 'RNG Keno'),
	m.MsgNameCT = CASE WHEN MsgNameCT LIKE '%Keno%' THEN REPLACE(m.MsgNameCT, 'Keno', 'RNG Keno') ELSE m.MsgNameCT END,
	m.MsgNameCS = CASE WHEN MsgNameCS LIKE '%Keno%' THEN REPLACE(m.MsgNameCS, 'Keno', 'RNG Keno') ELSE m.MsgNameCS END,
	m.MsgNameJP = CASE WHEN MsgNameJP LIKE '%Keno%' THEN REPLACE(m.MsgNameJP, 'Keno', 'RNG Keno') ELSE m.MsgNameJP END,
	m.MsgNameES = CASE WHEN MsgNameES LIKE '%Keno%' THEN REPLACE(m.MsgNameES, 'Keno', 'RNG Keno') ELSE m.MsgNameES END,
	m.MsgNameTH = CASE WHEN MsgNameTH LIKE '%Keno%' THEN REPLACE(m.MsgNameTH, 'Keno', 'RNG Keno') ELSE m.MsgNameTH END,
	m.MsgNameKO = CASE WHEN MsgNameKO LIKE '%Keno%' THEN REPLACE(m.MsgNameKO, 'Keno', 'RNG Keno') ELSE m.MsgNameKO END,
	m.MsgNameVI = CASE WHEN MsgNameVI LIKE '%Keno%' THEN REPLACE(m.MsgNameVI, 'Keno', 'RNG Keno') ELSE m.MsgNameVI END,
	m.MsgNameCN = CASE WHEN MsgNameCN LIKE '%Keno%' THEN REPLACE(m.MsgNameCN, 'Keno', 'RNG Keno') ELSE m.MsgNameCN END
FROM MsgError m WITH (NOLOCK)
	INNER JOIN #tmp t ON t.MsgID = m.MsgID 

SELECT m.*
FROM dbo.MsgError m WITH (NOLOCK)
	INNER JOIN #tmp t ON t.MsgID = m.MsgID 