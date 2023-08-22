/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230816@Tacy
	Task : Update AreaNameCH,AreaNameCS
		https://nexdev.net/issues/182071
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	 FuncNameCS=N'自动转账'
	,FuncNameCH=N'自動轉賬'
WHERE FuncID=5

UPDATE fa
SET	 AreaNameCS = CASE	WHEN AreaID=8		THEN N'自动转账配置'
						WHEN AreaID=9		THEN N'自动转账业务优势'
						WHEN AreaID=10		THEN N'转账进度监控'
						WHEN AreaID=11		THEN N'自动转账历史记录'
				END
	,AreaNameCH = CASE	WHEN AreaID=8		THEN N'自動轉賬配置'
						WHEN AreaID=9		THEN N'自動轉賬業務優勢'
						WHEN AreaID=10		THEN N'轉賬進度監控'
						WHEN AreaID=11		THEN N'自動轉賬歷史記錄'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
WHERE FuncID=5