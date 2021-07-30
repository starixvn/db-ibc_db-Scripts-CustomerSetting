/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20210730@Tina
	Task: remove config for job to check suspend info [redmineid: 148600]
	DB: DBCHECK/CheckResultDB
*/


DELETE vnDBA_CheckSetting_RunningScripts WHERE Command LIKE '%EXECUTE DBA_CheckSuspendInfoStatus_Credit%'

/*

SELECT *
FROM vnDBA_CheckSetting_RunningScripts
WHERE Command LIKE '%EXECUTE DBA_CheckSuspendInfoStatus_Credit%'

*/
