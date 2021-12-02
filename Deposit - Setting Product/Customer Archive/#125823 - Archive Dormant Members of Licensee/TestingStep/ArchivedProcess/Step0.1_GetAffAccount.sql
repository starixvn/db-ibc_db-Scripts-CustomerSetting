/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Step 1: Insert aff accounts to the exception list
		--> run Job:  Archive Deposit Member - Get Affiliate Account
	DB: DBCUST.CustDB
*/
USE CustDB
GO
EXEC dbo.Task_Dep_Customer_Archive_GetAffAccount