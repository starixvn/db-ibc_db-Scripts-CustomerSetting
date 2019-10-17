/*
	Created: 20191017@Elodie
	Task: Update MaxPT of Esport for CustID IN (73166)
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE cs
SET cs.MaxPT = 85
FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
WHERE cs.CustID IN (73166, 2)
	AND sporttype IN (43)
	AND MaxPT < 85


