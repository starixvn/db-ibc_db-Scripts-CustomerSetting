/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250528@Tacy
	Task : add MsgError  [redmine:#227673]
	
*/
USE CustDB
GO

INSERT INTO [dbo].[MsgError]
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
           ,[MsgNameCN]
           ,[MsgNameIN]
		   ,[RepUpdateTime])
VALUES
 (200052, 11, 
	N'This event has already been added to the monitoring list.', 
	N'该赛事已被添加到监控列表。', 
	N'该赛事已被添加到监控列表。', 
	N'This event has already been added to the monitoring list.', 
	N'รายการนี้ได้ถูกเพิ่มลงในรายการเฝ้าระวังแล้ว', 
	N'This event has already been added to the monitoring list.', 
	N'This event has already been added to the monitoring list.', 
	N'Sự kiện này đã được thêm vào danh sách theo dõi.', 
	1, 
	N'This event has already been added to the monitoring list.', 
	N'Event ini sudah ditambahkan ke daftar pemantauan.',
	dbo.f_GetDateTime2())
,(200053, 11, 
	N'Invalid values in BetRatio rule: Ratio must be between 0 and 100.', 
	N'投注比例规则中的数值无效：比例必须介于 0 到 100 之间。', 
	N'投注比例规则中的数值无效：比例必须介于 0 到 100 之间。', 
	N'Invalid values in BetRatio rule: Ratio must be between 0 and 100.', 
	N'ค่าที่ป้อนไม่ถูกต้องในกฎ BetRatio: อัตราส่วนต้องอยู่ระหว่าง 0 ถึง 100', 
	N'Invalid values in BetRatio rule: Ratio must be between 0 and 100.', 
	N'Invalid values in BetRatio rule: Ratio must be between 0 and 100.', 
	N'Giá trị không hợp lệ trong quy tắc Tỷ Lệ Cược: Tỷ lệ phải nằm trong khoảng từ 0 đến 100.', 
	1, 
	N'Invalid values in BetRatio rule: Ratio must be between 0 and 100.', 
	N'Nilai tidak valid pada aturan BetRatio: Rasio harus antara 0 dan 100.',
	dbo.f_GetDateTime2())
,(200054, 11, 
	N'Setting name already exists for this monitoring.', 
	N'该监控已存在相同名称的设定。', 
	N'该监控已存在相同名称的设定。', 
	N'Setting name already exists for this monitoring.', 
	N'ชื่อตั้งค่าดังกล่าวมีอยู่แล้วสำหรับการติดตามนี้', 
	N'Setting name already exists for this monitoring.', 
	N'Setting name already exists for this monitoring.', 
	N'Tên cài đặt này đã tồn tại trong danh sách theo dõi.', 
	1, 
	N'Setting name already exists for this monitoring.', 
	N'Nama pengaturan sudah ada untuk pemantauan ini.',
	dbo.f_GetDateTime2())
,(200055, 11, 
	N'Notification Interval must be greater than 0.', 
	N'通知间隔必须大于 0。', 
	N'通知间隔必须大于 0。', 
	N'Notification Interval must be greater than 0.', 
	N'ช่วงเวลาการแจ้งเตือนต้องมากกว่า 0', 
	N'Notification Interval must be greater than 0.', 
	N'Notification Interval must be greater than 0.', 
	N'Khoảng thời gian gửi thông báo phải lớn hơn 0.', 
	1, 
	N'Notification Interval must be greater than 0.', 
	N'Interval Notifikasi harus lebih besar dari 0.',
	dbo.f_GetDateTime2())
,(200056, 11, 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	N'This setting is already existed.', 
	1, 
	N'This setting is already existed.', 
	N'This setting is already existed.',
	dbo.f_GetDateTime2())