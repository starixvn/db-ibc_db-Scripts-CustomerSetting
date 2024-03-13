/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240312@Tacy
	Task: Add Cn3 - [BotResource] [#RedmineID:#193689]
	DB: DBBOT/bodb_Chatbot
*/
USE bodb_Chatbot
GO


INSERT INTO [dbo].[BotResource] ([ResourceName], [ResourceKey], [Language], [Value])
VALUES 
 ('Function_Name','5','vi-VN',N'Thắng thua hôm qua')
,('Function_Name','6','vi-VN',N'Tin nhắn cá nhân')
,('Function_Name','7','vi-VN',N'Tài Khoản Có Vấn Đề')
,('Function_Name','9','vi-VN',N'Đổi Mật Khẩu')
,('Function_Name','10','vi-VN',N'Đổi Mã Bảo Mật')
,('Function_Name','11','vi-VN',N'Thông báo sai mật khẩu')
,('Function_Name','13','vi-VN',N'Thông báo hệ thống')
,('Function_Name','15','vi-VN',N'OTP (Mã xác thực)')
,('Function_Name','17','vi-VN',N'Cảnh Báo Rủi Ro')
,('Function_Name','20','vi-VN',N'Cảnh báo đăng nhập lạ')
,('Function_Name','22','vi-VN',N'Chuyển Khoản Tự Động')
,('Function_Name','23','vi-VN',N'Cược Gần Nhất')
,('Function_Description','5','vi-VN',N'Gửi giá trị <b>"Tổng"</b> trong Báo Cáo Thắng Thua Hôm Qua tới Telegram của bạn sau 2:00PM (GMT+8) hằng ngày.')
,('Function_Description','6','vi-VN',N'Gửi Tin Nhắn Cá Nhân tới Telegram của bạn.')
,('Function_Description','7','vi-VN',N'Thông báo trên Telegram khi có cấp dưới bị đánh dấu là Tài Khoản Có Vấn Đề.')
,('Function_Description','9','vi-VN',N'Thông báo trên Telegram khi mật khẩu của bạn bị thay đổi.')
,('Function_Description','10','vi-VN',N'Thông báo trên Telegram khi Mã Bảo Mật bị thay đổi.')
,('Function_Description','11','vi-VN',N'Thông báo trên Telegram khi mật khẩu tài khoản của bạn bị nhập sai ba lần liên tiếp.')
,('Function_Description','13','vi-VN',N'Chuyển Thông báo hệ thống qua Telegram của bạn.')
,('Function_Description','15','vi-VN',N'Nhận OTP qua Telegram Chatbot')
,('Function_Description','17','vi-VN',N'Thông báo trên Telegram khi đạt đến bất kỳ giới hạn thắng thua nào đã đặt')
,('Function_Description','20','vi-VN',N'Thông báo hoạt động đăng nhập bất thường.')
,('Function_Description','22','vi-VN',N'Nhận thông báo hằng ngày qua Telegram về trạng thái Chuyển Khoản Tự Động sau khi hoàn tất.') --AUTO TRANSFER
,('Function_Description','23','vi-VN',N'Nhận thông báo qua Telegram khi có vé cược mới khớp với bộ lọc của bạn')
GO