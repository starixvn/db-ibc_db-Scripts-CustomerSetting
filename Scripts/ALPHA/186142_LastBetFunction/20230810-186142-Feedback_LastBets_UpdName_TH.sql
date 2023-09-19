/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230810@Tacy
	Task : Update Language Age_FeedbackArea
		https://nexdev.net/issues/186142
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE f
SET  f.FuncNameTH=N'เดิมพันล่าสุด (มุมมองใหม่)'
FROM Age_FeedbackFunc f WITH (ROWLOCK, UPDLOCK)
WHERE FuncID=4

UPDATE fa
SET	 AreaNameTH = CASE	WHEN AreaNameTH=N'Monitoring Page'		THEN N'หน้าการตรวจสอบ'
						WHEN AreaNameTH=N'Filter Management'	THEN N'การจัดการตัวกรอง'
						WHEN AreaNameTH=N'Filter Configuration'	THEN N'การกำหนดค่าตัวกรอง'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
WHERE FuncID=4