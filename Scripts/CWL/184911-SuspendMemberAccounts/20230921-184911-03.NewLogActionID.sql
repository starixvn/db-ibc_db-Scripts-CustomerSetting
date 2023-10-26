/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230921@Tacy
	Task: insert into table LogAction [redmine:#184911]
	DB: DBLOG.bodb_CustomerLog
*/
INSERT INTO LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
VALUES	 (75043,5,
		N'Acc_CustomerUpdSuspended',
		N'Updated to Suspended status due to reaching Company Win Loss Limit',
		N'已達到公司輸贏限額，狀態更新成暫停',
		N'已达到公司输赢限额，状态更新成暂停',
		N'Updated to Suspended status due to reaching Company Win Loss Limit',
		N'อัปเดตสถานะถูกระงับเนื่องจากยอดสะสมแพ้ชนะถึงขีดจำกัดของบริษัท',
		N'Updated to Suspended status due to reaching Company Win Loss Limit',
		0,
		N'Đã cập nhật thành trạng thái Bị Đình Chỉ do vượt quá Giới Hạn Thắng Thua Của Công Ty.')
GO