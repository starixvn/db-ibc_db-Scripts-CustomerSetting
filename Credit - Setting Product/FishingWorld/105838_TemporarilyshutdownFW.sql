/*
	Created: Winnie
	Task: Fishing World - Temporarily shut down FW RedmineID:#105838
	DB: DBCUST/CustDB
	Date: 20181205
*/ 

UPDATE 
ProductLaunchedSiteCurrency WITH(ROWLOCK)
SET IsLaunched=0
WHERE SportType=219
