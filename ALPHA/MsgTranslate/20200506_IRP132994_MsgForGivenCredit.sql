/*
	Created: 20200506@Johnson
	Task: update translation for msgError
	DB: DBCUST/CUSTDB
*/

UPDATE MsgError WITH(UPDLOCK,ROWLOCK)
SET MsgNameTH = N'เครดิตต้องเป็นจำนวนบวก',
	MsgNameVI = N'Hạn mức cấp phải là số dương'
where MsgID =  70025