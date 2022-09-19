/*<info serverAlias="DBTP-msdb" executers="" selectors="" viewers="" isFunction="0" isNested="0"></info>*/
/* 
	Created:20220914@Tacy
    Task: 
    DB: DBTP/msdb
	
	Revisions:
		- 20220914@Tacy: Combine 'DBA: Task_DetectBet_TicketExceededBetLimit' job and 'Task_DetectBet_SyncBetSettingHistory' job
						to a 'DBA: Task_DetectBet_TicketExceededBetLimit' job [Redmine:#177701] 
*/
USE [msdb]
GO

DECLARE @jobId BINARY(16),
		@schedule_id TINYINT

SELECT @jobId = CONVERT(uniqueidentifier, job_id) FROM msdb.dbo.sysjobs
WHERE name = 'DBA: Task_DetectBet_TicketExceededBetLimit'

SELECT @schedule_id=schedule_id FROM sysjobschedules where job_id = @jobId

--Disable job: DetectBet
EXEC sp_update_job 
	@job_name=N'DBA: Task_DetectBet_TicketExceededBetLimit', @enabled=0

--Delete job step
EXEC sp_delete_jobstep 
	@job_name=N'DBA: Task_DetectBet_TicketExceededBetLimit', @step_id=1

EXEC sp_delete_jobstep 
	@job_name=N'DBA: Task_DetectBet_TicketExceededBetLimit', @step_id=1

--Add step to sync history:
EXEC sp_add_jobstep  
    @job_name = N'DBA: Task_DetectBet_TicketExceededBetLimit',  
    @step_name = N'Step1: Sync history data',  
    @subsystem = N'TSQL',  
    @command = N'EXEC dbo.Task_DetectBet_SyncBetSettingHistory',
	@database_name = 'bodb02',
	@on_success_action=4,
	@on_success_step_id=2;

EXEC sp_add_jobstep  
    @job_name = N'DBA: Task_DetectBet_TicketExceededBetLimit',  
    @step_name = N'Step2: DetectBet',  
    @subsystem = N'TSQL',  
    @command = N'EXEC dbo.Task_DBTP_Control_Job  @Jobname = ''DBA: Task_DetectBet_TicketExceededBetLimit''
						,@Waitfordelay = NULL',
	@database_name = 'bodb02',
	@on_success_action=4,
	@on_success_step_id=3;

EXEC sp_add_jobstep  
    @job_name = N'DBA: Task_DetectBet_TicketExceededBetLimit',  
    @step_name = N'Step3: WAIT FOR DELAY',  
    @subsystem = N'TSQL',  
    @command = N'DECLARE @Delay VARCHAR(100) = ''''
				 SET @Delay = dbo.f_Job_SetWaitforDelay () 
				 WAITFOR DELAY @Delay',
	@database_name = 'bodb02',
	@on_success_action=4,
	@on_success_step_id=1;

--Update schedule:
EXEC dbo.sp_update_schedule  
	@schedule_id = @schedule_id,
	@new_name = N'Every Minute',
    @freq_type=4, 
	@freq_interval=1, 
	@freq_subday_type=4, 
	@freq_subday_interval=1, 
	@freq_relative_interval=0, 
	@freq_recurrence_factor=0

--Enable job: DetectBet
EXEC sp_update_job 
	@job_name=N'DBA: Task_DetectBet_TicketExceededBetLimit', @enabled=1

--Drop Sync job:
EXEC sp_delete_job 
	@job_name='bodb02: Sync history of bet setting data'
