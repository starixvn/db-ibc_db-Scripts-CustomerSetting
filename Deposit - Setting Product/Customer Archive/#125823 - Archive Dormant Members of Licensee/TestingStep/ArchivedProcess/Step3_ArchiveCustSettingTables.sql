/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Step 3: Archive CustSetting tables --> run job at DB05: 'Archive Deposit Member - Step 3:Archive CustSetting' --> call SSIS package : ArchiveDepCust.dtsx
	DB: DBAGE.bodb02
*/
USE bodb02
GO
EXEC dbo.ArchiveDeposit_Step3

