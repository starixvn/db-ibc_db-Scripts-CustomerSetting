﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230418@Tacy
	Task : Update CN3 area name on tb Age_FeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE fa
SET	AreaNameCN3 = N'Nhập mức tín dụng muốn cấp'
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
WHERE AreaNameEN=N'Given Credit input'