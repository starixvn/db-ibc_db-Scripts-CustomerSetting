/*
	Created: 20200908@Johnson
	Task: set customerClass = NULL Incase customerClass = 14
	DB: DBCUST/CustDB
*/

--248 rows affects
UPDATE CustInfo WITH(UPDLOCK,ROWLOCK)
SET customerClass = NULL
WHERE customerClass = 14