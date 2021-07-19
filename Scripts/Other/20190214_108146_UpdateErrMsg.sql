USE [CustDB]
GO
/*
	Created: Winnie
	Task: Update msg Error CheckReachDownline RedmineID: #108146
	DB: DBCUST/CustDB
	Date: 20190214
*/ 

UPDATE [MsgError] WITH(ROWLOCK,UPDLOCK)
	SET [MsgNameCT]=N'抱歉，由於下線總數已達到限制（1296），所以您無法創建更多的賬號。請聯系您的上線以獲取進一步的協助。',
	[MsgNameCS]=N'抱歉，由于下线总数已达到限制（1296），所以您无法创建更多的账号。请联系您的上线以获取进一步的协助。',
	[MsgNameTH]=N'ขออภัยคุณไม่สามารถสร้างบัญชีเพิ่ม เนื่องจากจำนวนดาวน์ไลน์ทั้งหมดถึงขีดจำกัด (1296) กรุณาติดต่ออัพไลน์ของคุณสำหรับความช่วยเหลือเพิ่มเติม',
	[MsgNameVI]=N'Xin lỗi, bạn không thể tạo thêm tài khoản vì tổng số tài khoản cấp dưới đã đạt đến giới hạn tối đa (1296). Vui lòng liên hệ với cấp trên để được hỗ trợ.'
WHERE [MsgID]=40039

UPDATE [MsgError] WITH(ROWLOCK,UPDLOCK)
	SET [MsgNameCT]=N'抱歉，由於下線總數已達到限制（46656），所以您無法創建更多的賬號。請聯系您的上線以獲取進一步的協助。',
	[MsgNameCS]=N'抱歉，由于下线总数已达到限制（46656），所以您无法创建更多的账号。请联系您的上线以获取进一步的协助。',
	[MsgNameTH]=N'ขออภัยคุณไม่สามารถสร้างบัญชีเพิ่ม เนื่องจากจำนวนดาวน์ไลน์ทั้งหมดถึงขีดจำกัด (46656) กรุณาติดต่ออัพไลน์ของคุณสำหรับความช่วยเหลือเพิ่มเติม',
	[MsgNameVI]=N'Xin lỗi, bạn không thể tạo thêm tài khoản vì tổng số tài khoản cấp dưới đã đạt đến giới hạn tối đa (46656). Vui lòng liên hệ với cấp trên để được hỗ trợ.'
WHERE [MsgID]=40040


