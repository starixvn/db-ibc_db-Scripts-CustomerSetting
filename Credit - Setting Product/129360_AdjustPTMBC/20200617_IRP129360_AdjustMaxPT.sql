/*
	Created: 20200617@Elodie
	Task: update MaxPT
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

UPDATE cs
SET MaxPT = 90
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
WHERE sporttype = 43
	and custid IN (195307, 130867)






