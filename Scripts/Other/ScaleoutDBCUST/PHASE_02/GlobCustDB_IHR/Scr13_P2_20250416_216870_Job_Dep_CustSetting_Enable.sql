/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Tacy@20250122
	Task: Enable - Job: 'CustDB: Initial Setting Process - Deposit' [Redmine: #216870]   
	DB: DBCUST-CUSTDB
*/

USE msdb ;  
GO  

-- Enable job
EXEC dbo.sp_update_job  
    @job_name = N'CustDB: Initial Setting Process - Deposit',  
    @enabled = 1 ;  
GO