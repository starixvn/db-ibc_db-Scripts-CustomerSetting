/*<info serverAlias="DBSIC-msdb"></info>*/
/*
	Created: 202308014@Eden
	Task: Enable Job on SiteDB03 : [#RedmineID:#181595]
		bodb02 : Game : Task_BalanceUpd 
		bodb02 : Game : ResetYesterday
							
	DB: DBSIC-msdb
*/


USE msdb ;  
GO  

EXEC dbo.sp_update_job  
    @job_name = N'bodb02 : Game : ResetYesterday',  
    @new_name = N'bodb02 : Game : ResetYesterday',  
    @description = N'No description available.',  
    @enabled = 1 ;  
GO  

EXEC dbo.sp_update_job  
    @job_name = N'bodb02 : Game : Task_BalanceUpd',  
    @new_name = N'bodb02 : Game : Task_BalanceUpd',  
    @description = N'No description available.',  
    @enabled = 1 ;  
GO  
