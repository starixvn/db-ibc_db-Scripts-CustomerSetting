/*
	Created: 20210301@Johnson
	Task: update msg translate for suspend status
	DB: DBLOG/bodb_CustomerLog
*/

update LogAction WITH(UPDLOCK,ROWLOCK)
set ActionNameTH = N'อัพเดทสถานะเป็นระงับ'
where ActionID = 1104