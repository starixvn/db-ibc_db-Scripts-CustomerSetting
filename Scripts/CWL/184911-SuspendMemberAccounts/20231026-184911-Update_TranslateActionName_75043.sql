/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231026@Tacy
	Task: Update translate - Action Name [redmine:#184911]
	DB: DBLOG.bodb_CustomerLog
*/
UPDATE LogAction WITH (ROWLOCK, UPDLOCK)
SET ActionNameEN=N'Updated to Suspended status due to reaching Company Win Limit',
	ActionNameCH=N'已達到公司贏限額，狀態更新成暫停',
	ActionNameCS=N'已达到公司赢限额，状态更新成暂停',
	ActionNameTH=N'อัปเดตสถานะเป็นถูกระงับเนื่องจากยอดชนะสะสมถึงขีดจำกัดของบริษัท',
	ActionNameVI=N'Đã cập nhật thành trạng thái Bị Đình Chỉ do vượt quá Giới Hạn Thắng Của Công Ty.',
	ActionNameJP=N'Updated to Suspended status due to reaching Company Win Limit',
	ActionNameKO=N'Updated to Suspended status due to reaching Company Win Limit'
WHERE ActionID=75043
GO