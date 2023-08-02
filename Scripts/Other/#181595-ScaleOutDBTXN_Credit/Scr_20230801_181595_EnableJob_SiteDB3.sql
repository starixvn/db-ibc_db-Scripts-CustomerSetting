/*<info serverAlias="DBSIC-msdb"></info>*/
/*
	Created: 202308014@Eden
	Task: Enable Job : [#RedmineID:#181595]
		bodb02 : Game : Task_BalanceUpd 
		bodb02 : Game : ResetYesterday
		bodb02: Task Clear balance all downlines 
							
	DB: DBCUST-msdb
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

EXEC dbo.sp_update_job  
    @job_name = N'bodb02: Task Clear balance all downlines',  
    @new_name = N'bodb02: Task Clear balance all downlines',  
    @description = N'No description available.',  
    @enabled = 1 ;  
GO  
