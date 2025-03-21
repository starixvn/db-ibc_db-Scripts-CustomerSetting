/*<info serverAlias="DBCUST-msdb"></info>*/
/*
	Created: Tacy@20250305
	Task: Disable - Job: 'RepInhouse - Clear data marked deleted' [Redmine: #216870]   
	DB: DBCUST-msdb
*/

USE msdb ;  
GO  

-- Disable job
EXEC dbo.sp_update_job  
    @job_name = N'RepInhouse - Clear data marked deleted',  
    @enabled = 0 ;  
GO