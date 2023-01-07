
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20220107@Elodie
	Task:	update IsNotified
	Database:	DBCUST.CustDB	
*/

UPDATE h
SET h.IsNotified = 0
FROM WinLimit_CustGameMonitoring_History h WITH (ROWLOCK)
WHERE logid in (108603,108602,108600)