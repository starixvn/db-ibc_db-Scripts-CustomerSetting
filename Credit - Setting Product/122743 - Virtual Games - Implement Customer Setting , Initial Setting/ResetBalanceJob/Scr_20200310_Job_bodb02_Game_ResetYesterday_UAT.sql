/*
	Created: Eden
	Date: 20200310
	Task: Alter job bodb02 : Game : ResetYesterday  for UAT
	DB: DBTXN
*/
USE [msdb]
GO
BEGIN TRANSACTION
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'bodb02 : Game : ResetYesterday')
	EXEC sp_delete_job @job_name = N'bodb02 : Game : ResetYesterday' , @delete_unused_schedule=1

DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'bodb02 : Game : ResetYesterday', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Reset]    Script Date: 3/9/2020 5:39:59 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Reset', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 162, @bettype = 1101
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 255, @bettype = 1701
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 208, @bettype = 2101
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 212, @bettype = 4001
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 211, @bettype = 2401
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 219, @bettype = 1011
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 220, @bettype = 1021
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 207, @bettype = 1004
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 180, @bettype = 1201
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 163, @bettype = 1401
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = 245, @bettype = 4601', 
		@database_name=N'bodb02', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Reset data for CWL]    Script Date: 3/9/2020 5:39:59 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Reset data for CWL', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @WinlostDate SMALLDATETIME
SET @WinlostDate = CAST(GETDATE() AS DATE)
EXEC dbo.Task_Winlimit_ResetData @WinlostDate = @WinlostDate', 
		@database_name=N'bodb02', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'2 times', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20121023, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=25959, 
		@schedule_uid=N'81cfc642-1f60-4bca-a304-4a51e770e8f2'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


