﻿/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231024@Tacy
	Task: Update translate - Action Name on SIT [redmine:#184911]
	DB: DBLOG.bodb_CustomerLog
*/
UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET ActionNameCH=N'更新暫停狀態',
	ActionNameCS=N'更新暂停状态',
	ActionNameTH=N'อัพเดทสถานะเป็นระงับ',
	ActionNameVI=N'Cập nhật trạng thái bị đình chỉ'
WHERE ActionID=1104
GO
