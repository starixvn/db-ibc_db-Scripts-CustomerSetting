/*<info serverAlias="DBCUST-msdb"></info>*/
/*
	Created: Tacy@20250305
	Task: Update step - Job: 'RepInhouse - Clear data marked deleted' [Redmine: #216870]   
	DB: DBCUST-msdb
*/

USE msdb ;  
GO  

-- Update job step on CustDB:
EXEC dbo.sp_update_jobstep
	@job_name = N'RepInhouse - Clear data marked deleted', 
	@step_name=N'Call SP - CustDB', 
	@step_id=1, 
	@on_success_action=4, 
	@on_success_step_id=2
GO

-- Add job step on GlobCustDB
EXEC msdb.dbo.sp_add_jobstep 
    @job_name = N'RepInhouse - Clear data marked deleted',  
	@step_name=N'Call SP - GlobCustDB', 
	@step_id=2, 
	@cmdexec_success_code=0, 
	@on_success_action=1, 
	@on_success_step_id=0, 
	@on_fail_action=2, 
	@on_fail_step_id=0, 
	@retry_attempts=0, 
	@retry_interval=0, 
	@os_run_priority=0, @subsystem=N'TSQL', 
	@command=N'EXEC [Task_Repl_CleanDeletedData]', 
	@database_name='GlobCustDB', 
	@flags=0
GO