/*<info serverAlias="DBCUST-msdb"></info>*/
/*
	Created: 202308014@Eden
	Task: add Delete unused job: CustDB-Chatbot-Task Member Reach Win Loss Limit
		Reason: use webs ervice instead of sql job[#RedmineID:#181595]
	DB: DBCUST-msdb
*/
USE [msdb]
GO
EXEC msdb.dbo.sp_delete_job @job_name = N'CustDB-Chatbot-Task Member Reach Win Loss Limit', @delete_unused_schedule=1


