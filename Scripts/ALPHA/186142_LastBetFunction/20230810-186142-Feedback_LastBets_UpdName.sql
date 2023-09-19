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
SET  f.FuncNameCS=N'最后投注 (新版本)'
	,f.FuncNameCH=N'最後投注 (新版本)'
	,f.FuncNameCN3=N'Cược Gần Nhất (phiên bản mới)'
FROM Age_FeedbackFunc f WITH (ROWLOCK, UPDLOCK)
WHERE FuncID=4

UPDATE fa
SET	 AreaNameCN3 = CASE	WHEN AreaNameCN3=N'Monitoring Page'			THEN N'Trang Theo Dõi'
						WHEN AreaNameCN3=N'Filter Management'		THEN N'Quản Lý Bộ Lọc'
						WHEN AreaNameCN3=N'Filter Configuration'	THEN N'Cài Đặt Bộ Lọc'
				END
	,AreaNameCH = CASE	WHEN AreaNameCH=N'Monitoring Page'			THEN N'監控頁面'
						WHEN AreaNameCH=N'Filter Management'		THEN N'篩選管理'
						WHEN AreaNameCH=N'Filter Configuration'		THEN N'篩選配置'
				END
	,AreaNameCS = CASE	WHEN AreaNameCS=N'Monitoring Page'			THEN N'监控页面'
						WHEN AreaNameCS=N'Filter Management'		THEN N'筛选管理'
						WHEN AreaNameCS=N'Filter Configuration'		THEN N'筛选配置'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
WHERE FuncID=4
