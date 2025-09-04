/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250826@Eden
	Task : Remove step GlobCustDB [#236237]
	DB: DBCUST-CustDB
*/
USE [msdb]
GO
IF EXISTS(
	SELECT 1
	FROM msdb.dbo.sysjobs j WITH(NOLOCK)
		INNER JOIN msdb.dbo.sysjobsteps js WITH(NOLOCK) ON j.job_id = js.job_id
	WHERE j.name = N'RepInhouse - Clear data marked deleted'
		AND js.step_id = 2 
		AND js.step_name = N'Call SP - GlobCustDB'
)
BEGIN
	EXEC msdb.dbo.sp_delete_jobstep @job_name=N'RepInhouse - Clear data marked deleted', @step_id=2

	EXEC msdb.dbo.sp_update_jobstep @job_name=N'RepInhouse - Clear data marked deleted', @step_id=1 ,
			@on_success_action=1,
			@database_name=N'CustDB'
END
GO