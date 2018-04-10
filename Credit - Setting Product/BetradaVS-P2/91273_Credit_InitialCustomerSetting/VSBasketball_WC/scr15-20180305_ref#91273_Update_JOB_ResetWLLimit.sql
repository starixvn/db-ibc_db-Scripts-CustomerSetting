/*
    Created: 20180320@Vicky 
    Task: Update JOB - Reset WL Limit
    DB: DBTXN/msdb
*/ 
USE msdb
GO

DECLARE @var_sporttype SMALLINT = 180,
        @var_bettype   SMALLINT = 1201
        
        
--------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @var_job_name NVARCHAR(100) = 'bodb02 : Game : ResetYesterday',
        @var_step_id INT            =  1,
        @var_step_name VARCHAR(100) = 'Reset'
DECLARE @var_old_command VARCHAR(MAX), @var_job_id VARCHAR(MAX)


--------------------------------------------------------------------------------------------------------------------------------------------
SELECT @var_job_id = job_id
FROM sysjobs
WHERE name = @var_job_name

SELECT @var_old_command = command 
FROM sysjobsteps
WHERE step_id = @var_step_id AND step_name = @var_step_name AND job_id = @var_job_id

SELECT @var_old_command = @var_old_command + ' 
EXEC dbo.Task_BalanceGameResetYesterday @sporttype = ' + CONVERT(VARCHAR(10), @var_sporttype) 
                                   + ', @bettype = ' + CONVERT(VARCHAR(10), @var_bettype)

EXEC sp_update_jobstep @job_id  = @var_job_id, 
                       @step_id = @var_step_id, 
                       @command = @var_old_command
