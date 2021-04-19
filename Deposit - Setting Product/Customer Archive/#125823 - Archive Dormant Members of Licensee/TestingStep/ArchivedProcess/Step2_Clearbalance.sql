/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Step 2: Clear Balance and Archive Customer/custinfo tables --> Run job at DBTRANS : 'Archive Deposit Member - Step 2: Clear Balance and CustInfo'
	DB: DBTXN.bodb02
*/
USE bodb02
GO
EXEC DBTXN.bodb02.dbo.[Task_Dep_Cust_Archive_Clear_Balance_UAT4]
	@BatchSize = 100
