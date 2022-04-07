/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Elodie
	Date: 20220406
	Task: Setting job management
	DB: DBTXN/bodb02
*/
USE msdb ;  
GO  
  
EXEC sp_delete_job  
    @job_name = N'bodb02 : Game : ResetYesterday' 
  
EXEC sp_delete_job  
    @job_name = N'bodb02 : Game : Task_BalanceUpd'
GO
