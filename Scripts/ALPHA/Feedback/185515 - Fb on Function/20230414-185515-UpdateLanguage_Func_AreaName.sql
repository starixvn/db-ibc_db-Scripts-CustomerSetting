/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230414@Tacy
	Task : Update function & area language
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	 FuncNameCH=N'搜索與復制（新版本）'
	,FuncNameCS=N'搜索与复制（新版本）'
	,FuncNameTH=N'ค้นหาและคัดลอก (เวอร์ชั่นใหม่)'
WHERE FuncNameEN=N'Search & Copy (new version)'

UPDATE fa
SET	 AreaNameCH = CASE	WHEN AreaNameCH=N'Account quantity input'			THEN N'輸入賬號數量'
						WHEN AreaNameCH=N'Username(s) copy after creation'	THEN N'複製創建後的用戶名'
						WHEN AreaNameCH=N'Account naming convention?'		THEN N'賬號命名常規?'
						WHEN AreaNameCH=N'Given Credit input'				THEN N'輸入信用額度'
				END
	,AreaNameCS = CASE	WHEN AreaNameCS=N'Account quantity input'			THEN N'输入账号数量'
						WHEN AreaNameCS=N'Username(s) copy after creation'	THEN N'复制创建后的用户名'
						WHEN AreaNameCS=N'Account naming convention?'		THEN N'账号命名常规?'
						WHEN AreaNameCS=N'Given Credit input'				THEN N'输入信用额度'
				END
	,AreaNameTH = CASE	WHEN AreaNameTH=N'Account quantity input'			THEN N'ใส่จำนวนบัญชี'
						WHEN AreaNameTH=N'Username(s) copy after creation'	THEN N'คัดลอกรายชื่อบัญชีหลังสร้างเสร็จ'
						WHEN AreaNameTH=N'Account naming convention?'		THEN N'รูปแบบการตั้งชื่อบัญชี'
						WHEN AreaNameTH=N'Given Credit input'				THEN N'ใส่ยอดวงเงินเครดิต'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
INNER JOIN Age_FeedbackFunc ff WITH (NOLOCK) ON ff.FuncID=fa.FuncID
WHERE FuncNameEN=N'Search & Copy (new version)'