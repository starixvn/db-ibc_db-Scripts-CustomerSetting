/*<info serverAlias="DBCUST-msdb"></info>*/
/*
    Created: Eden@20220513
    Task: ALter job  'CustDB: Daily auto clear credit inactive accounts' to use sp DBA_ArchiveAccount_UpdateException [#172372]
    DB: DBCUST/msdb
*/ 
USE [msdb]
GO
DECLARE @jobId uniqueidentifier
SELECT @jobId = job_id
FROM msdb.dbo.sysjobs WITH(NOLOCK)
WHERE name = 'CustDB: Daily auto clear credit inactive accounts'

IF @jobId IS NULL
BEGIN
	SELECT 'Invalid Job'
	RETURN
END

BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	EXEC @ReturnCode = msdb.dbo.sp_update_jobstep @job_id=@jobId, @step_name=N'Clear credit SMAs', 
			@step_id=2, 
			@cmdexec_success_code=0, 
			@on_success_action=3, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'EXEC DBACC.bodb02.dbo.DBA_ArchiveAccount_UpdateException
	GO
	EXEC dbo.Task_ClearCredit_CustomerClearCredit', 
			@database_name=N'CustDB', 
			@flags=0

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	EXEC @ReturnCode = msdb.dbo.sp_update_jobstep @job_id=@jobId, @step_name=N'Clear credit Members', 
			@step_id=4, 
			@cmdexec_success_code=0, 
			@on_success_action=3, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'EXEC DBACC.bodb02.dbo.DBA_ArchiveAccount_UpdateException
	GO
	EXEC dbo.Task_ClearCredit_CustomerClearCredit_Member', 
			@database_name=N'CustDB', 
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
GO