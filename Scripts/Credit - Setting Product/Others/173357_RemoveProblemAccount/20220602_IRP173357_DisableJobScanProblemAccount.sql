/*<info serverAlias="DBCUST-MSDB"></info>*/
/*
	Created: 20220602@Johnson
	Task:  Disable job scan ProblemAccount
	DB: DBCUST/MSDB
*/

EXEC msdb.dbo.sp_update_job @job_name='DBCUST: Scan Abnormal Member',@enabled = 0