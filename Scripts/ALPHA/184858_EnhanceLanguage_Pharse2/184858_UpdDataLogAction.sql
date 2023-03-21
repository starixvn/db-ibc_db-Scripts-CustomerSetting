/*<info serverAlias="DBLOG-bodb_CustomerLog" ></info>*/
/*
	Created: Helios@20230310
	Task: Initial New Data LogActionID 95085 [RM:#181791]
	DB: DBLOG/bodb_CustomerLog

	Revisions:
		- 20230310@Helios: Initial New Data LogActionID [redmine:#184858]
*/

use bodb_CustomerLog

UPDATE LA SET [ActionNameCH] = N'更新語言顯示' , [ActionNameCS] =  N'更新语言显示' , [ActionNameTH] = N'ปรับเปลี่ยนภาษาที่ใช้แสดงผล'
FROM LogAction LA WITH (ROWLOCK ,UPDLOCK)
WHERE ActionID = 95085 