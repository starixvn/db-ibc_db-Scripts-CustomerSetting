/*<info serverAlias="DBCTG-msdb"></info>*/

/*
	Created: 20230830@Eden
	Task: Disable Job on Central DB : [#RedmineID:#181595]
		bodb02 : Game : Task_BalanceUpd 
		Archive Credit Accounts - Stage 3: Clear Balance		
	DB: DBCTG-msdb
*/


USE msdb  
GO  

EXEC dbo.sp_update_job  
    @job_name = N'bodb02 : Game : ResetYesterday',  
    @enabled = 0 ;  
GO  

EXEC dbo.sp_update_job  
    @job_name = N'Archive Credit Accounts - Stage 3: Clear Balance',  
    @enabled = 0 ;  
GO  

    
