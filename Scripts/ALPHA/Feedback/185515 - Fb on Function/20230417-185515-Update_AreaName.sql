/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230417@Tacy
	Task : Update area name on tb Age_FeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE fa
SET	 AreaNameEN = N'Multiple usernames suggestion'
	,AreaNameCN3 = N'Đề xuất đồng loạt tên người dùng'
	,AreaNameCH = N'多組用戶名建議'
	,AreaNameCS = N'多组用户名建议'
	,AreaNameTH = N'รูปแบบการตั้งชื่อบัญชี'
	,AreaNameJP = N'Multiple usernames suggestion'
	,AreaNameKO = N'Multiple usernames suggestion'
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
WHERE AreaNameEN=N'Account naming convention?'