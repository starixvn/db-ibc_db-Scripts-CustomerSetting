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
SET	 FuncNameCN3=N'Tìm & Sao Chép (phiên bản mới)'
WHERE FuncNameEN=N'Search & Copy (new version)'

UPDATE fa
SET	 AreaNameCN3 = CASE	WHEN AreaNameCN3=N'Account quantity input'			THEN N'Nhập số lượng tài khoản cần tạo'
						WHEN AreaNameCN3=N'Username(s) copy after creation'	THEN N'Sao chép tên người dùng mới tạo'
						WHEN AreaNameCN3=N'Account naming convention?'		THEN N'Cách đặt tên tài khoản'
						WHEN AreaNameCN3=N'Given Credit input'				THEN N'Nhập Mức Tín Dụng Muốn Cấp'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
INNER JOIN Age_FeedbackFunc ff WITH (NOLOCK) ON ff.FuncID=fa.FuncID
WHERE FuncNameEN=N'Search & Copy (new version)'
