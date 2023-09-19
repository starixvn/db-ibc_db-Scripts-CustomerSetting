/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230818@Tacy
	Task: Update Language - error message [#186142]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE MsgError WITH (ROWLOCK, UPDLOCK)
SET  MsgNameTH=CASE WHEN MsgID=90020 THEN N'มีชื่อตัวกรองนี้อยู่แล้ว'
					WHEN MsgID=90021 THEN N'กรุณาป้อนชื่อหรือกดเลือกสมาชิก'
					WHEN MsgID=90022 THEN N'กรุณาเลือกประเภทกีฬา'
					WHEN MsgID=90023 THEN N'โปรดป้อนชื่อตัวกรอง'
					WHEN MsgID=90024 THEN N'กรุณาเลือกประเภทการเดิมพัน'
					WHEN MsgID=90025 THEN N'กรุณาใส่ค่าเงินเดิมพัน'
					WHEN MsgID=90026 THEN N'ตัวกรองนี้ไม่พร้อมใช้งาน'
				END
WHERE MsgID BETWEEN 90020 AND 90026
GO
