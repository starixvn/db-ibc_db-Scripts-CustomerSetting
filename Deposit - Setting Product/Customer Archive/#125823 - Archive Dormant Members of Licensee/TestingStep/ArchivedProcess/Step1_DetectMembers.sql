/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Step 1: Detect members will be archived --> Run Job at DB061 : 'Archive Deposit Member - Step 1: Collect Dormant Member'
	DB: DBACC.bodb02
*/
USE bodb02
GO
EXEC  DBACC.bodb02.dbo.Task_Dep_Customer_Archive_GetDormantCustomer_UAT4
	@CheckBettrans_CustPerBatch = 2000,
	@InsertRepTable_CustPerBatch = 6000

--SELECT * FROM DBACC.bodb_Report.dbo.Tmp_Dep_Customer_Archived