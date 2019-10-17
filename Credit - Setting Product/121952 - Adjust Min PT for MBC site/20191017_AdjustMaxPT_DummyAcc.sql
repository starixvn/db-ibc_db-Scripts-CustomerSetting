/*
	Created: 20191017@Elodie
	Task: Update MaxPT of Esport for CustID IN (4179, 156390, 4300, 4175, 4176)
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE cs
SET cs.MaxPT = 85
FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
WHERE cs.CustID IN (4179, 156390, 4300, 4175, 4176)
	AND sporttype IN (43)
	AND MaxPT < 85


