/*
	Created: 20210112@Johnson
	Task: new errmsg for checking auto master PT
	DB: DBCUST/CustDB
*/

INSERT INTO [CustDB].[dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT  20044, 3, N'You are not allowed to have Auto PT, please contact your upline.' , N'您不被允許使用自動占成, 請您聯系您的上線。',N'您不被允许使用自动占成, 请您联系您的上线。' ,N'You are not allowed to have Auto PT, please contact your upline.' , N'คุณไม่ได้รับอนุญาตให้ใช้การตั้งค่าแบ่งสู้อัตโนมัติ โปรดติดต่ออัพไลน์ของคุณ', N'You are not allowed to have Auto PT, please contact your upline.', N'You are not allowed to have Auto PT, please contact your upline.' ,N'Bạn không được phép dùng Auto PT, vui lòng liên hệ cấp trên để biết thêm chi tiết.', 1,N'You are not allowed to have Auto PT, please contact your upline.'

