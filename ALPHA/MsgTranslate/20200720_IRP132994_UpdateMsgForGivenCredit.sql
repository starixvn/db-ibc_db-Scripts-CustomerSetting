/*
	Created: 20200720@Johnson
	Task: Update msg for given credit
	DB: DBCUST/CUSTDB
*/

UPDATE MsgError
SET MsgNameEN = 'The new bet credit is out of the available range.',
	MsgNameCT = N'新設定的投注額度超出允許範圍。',
	MsgNameCS = N'新设定的投注额度超出允许范围。',
	MsgNameTH = N'ยอดใหม่ของเครดิตสำหรับการวางเดิมพันอยู่นอกช่วงที่ใช้งานได้',
	MsgNameJP = N'The new bet credit is out of the available range.',
	MsgNameKO = N'The new bet credit is out of the available range.',
	MsgNameES = N'The new bet credit is out of the available range.',
	MsgNameVI = N'Hạn mức khả dụng mới vượt quá mức cho phép.'
WHERE MsgID = 70006