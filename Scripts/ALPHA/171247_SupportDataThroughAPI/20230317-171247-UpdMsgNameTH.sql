/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230317@Tacy
	Task: Update MsgNameTH [#171247]
		https://nexdev.net/issues/171247
	Database: DBCUST/CustDB
*/
USE CustDB
GO

--The API Key Name already exists
UPDATE MsgError WITH (ROWLOCK, UPDLOCK)
SET MsgNameTH=N'ชื่ื่อ API นี้มีอยู่แล้ว'
WHERE MsgID=90018

--The maximum number of API keys has been exceeded
UPDATE MsgError WITH (ROWLOCK, UPDLOCK)
SET MsgNameTH=N'จำนวน API Key ครบจำนวนสูงสุดที่สร้างได้แล้ว'
WHERE MsgID=90019