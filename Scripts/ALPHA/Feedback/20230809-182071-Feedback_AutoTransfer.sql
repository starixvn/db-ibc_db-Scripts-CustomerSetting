/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230809@Tacy
	Task : Init data into Age_FeedbackFunc & Age_FeedbackArea
		https://nexdev.net/issues/182071
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

DECLARE @FuncID INT

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCH,FuncNameCS,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 1,'Auto Transfer',N'Chuyển Khoản Tự Động',N'自动转账',N'自動轉賬',N'โอนอัตโนมัติ',N'Auto Transfer',N'Auto Transfer'

SELECT @FuncID=@@IDENTITY

INSERT INTO Age_FeedbackArea (FuncID,AreaNameEN,AreaNameCN3,AreaNameCH,AreaNameCS,AreaNameTH,AreaNameJP,AreaNameKO)
SELECT @FuncID,'Auto Transfer Configuration',N'Cài Đặt Chuyển Khoản Tự Động',N'自动转账配置',N'自動轉賬配置',N'การกำหนดค่าของระบบโอนอัตโนมัติ',N'Auto Transfer Configuration',N'Auto Transfer Configuration'
UNION ALL 
SELECT @FuncID,'Auto Transfer Business Benefits',N'Lợi Ích & Giá Trị Mang Lại',N'自动转账业务优势',N'自動轉賬業務優勢',N'ประโยชน์ต่อธุรกิจของคุณจากระบบโอนอัตโนมัติ',N'Auto Transfer Business Benefits',N'Auto Transfer Business Benefits'
UNION ALL 
SELECT @FuncID,'Transfer Progress Monitoring',N'Theo Dõi Quá Trình Chuyển Khoản',N'转账进度监控',N'轉賬進度監控',N'การตรวจสอบความคืบหน้าของการโอน',N'Transfer Progress Monitoring',N'Transfer Progress Monitoring'
UNION ALL 
SELECT @FuncID,'Auto Transfer History',N'Lịch Sử Chuyển Khoản Tự Động',N'自动转账历史记录',N'自動轉賬歷史記錄',N'ประวัติการโอนอัตโนมัติ',N'Auto Transfer History',N'Auto Transfer History'
GO