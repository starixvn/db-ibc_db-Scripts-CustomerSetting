/*
	Created: 20200908@Johnson
	Task: set customerClass = NULL Incase customerClass = 14
	DB: DBCUST/CustDB
*/

UPDATE CustInfo WITH(UPDLOCK,ROWLOCK)
SET customerClass = NULL
WHERE customerClass = 14