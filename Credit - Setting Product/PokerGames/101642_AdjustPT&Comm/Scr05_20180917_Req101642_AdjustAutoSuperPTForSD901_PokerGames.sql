/*
	Created: Elodie
	Task: Adjust AutosuperPT Setting for SD901
	DB: DBCUST/CustDB
	Date: 20180917
*/ 
USE CustDB
GO

UPDATE cs
SET cs.AutoSuperPT = 80
FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
WHERE custid = 17272242 AND cs.SportType = 163

