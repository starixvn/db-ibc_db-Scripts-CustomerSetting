/*<info serverAlias="DBTP-msdb" executers="" selectors="" viewers="" isFunction="0" isNested="0"></info>*/
/* 
	Created:20220914@Tacy
    Task: 
    DB: DBTP/msdb
	
	Revisions:
		- 20220914@Tacy: Delete 'Task_DetectBet_SyncBetSettingHistory' job [Redmine:#177701] 
*/
USE [msdb]
GO

--Drop Sync job:
EXEC sp_delete_job 
	@job_name='bodb02: Sync history of bet setting data'
