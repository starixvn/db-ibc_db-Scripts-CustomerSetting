/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231023@Tacy
	Task: Update translate - Action Name on SIT [redmine:#184911]
	DB: DBLOG.bodb_CustomerLog
*/
UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET ActionNameEN=N'Updated to Suspended status due to reaching Company Win Loss Limit',
	ActionNameCH=N'已達到公司輸贏限額，狀態更新成暫停',
	ActionNameCS=N'已达到公司输赢限额，状态更新成暂停',
	ActionNameTH=N'อัปเดตสถานะถูกระงับเนื่องจากยอดสะสมแพ้ชนะถึงขีดจำกัดของบริษัท',
	ActionNameVI=N'Đã cập nhật thành trạng thái Bị Đình Chỉ do vượt quá Giới Hạn Thắng Thua Của Công Ty.',
	ActionNameJP=N'Updated to Suspended status due to reaching Company Win Loss Limit',
	ActionNameKO=N'Updated to Suspended status due to reaching Company Win Loss Limit'
WHERE ActionID=75043
GO