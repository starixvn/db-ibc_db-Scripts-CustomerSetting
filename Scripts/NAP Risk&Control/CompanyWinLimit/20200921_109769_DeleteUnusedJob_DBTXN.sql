/*
	Created: Elodie
	Date: 20200921
	Task:  Delete unused job RedmineID:#109769
	DB: DBTXN
*/

USE [msdb]
GO

EXEC dbo.sp_delete_job @job_name =N'bodb02 - Winlimit Game - Task_block_member', @delete_unused_schedule=1
GO


