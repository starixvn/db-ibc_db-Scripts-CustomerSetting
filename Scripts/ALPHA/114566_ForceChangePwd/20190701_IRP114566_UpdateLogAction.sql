/*
	Created: 20190701@Johnson
	DB: DBLOG/bodb_CustomerLog
	Task: update translate msg for log action
*/

UPDATE l
SET ActionNameCH = N'遭踢出會員',
	ActionNameCS = N'遭踢出会员',
	ActionNameTH = N'ขับไล่สมาชิก',
	ActionNameVI = N'Buộc đăng xuất Member'
FROM LogAction l WITH(UPDLOCK,ROWLOCK)
WHERE ActionID = 1331

