/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230511@Johnson
	Task: Add Error Message
	DB: DBCUST/CustDB
*/

--20231024@Update ErrMsg
;WITH T AS (
SELECT 10070 MsgID, 5 MsgGroupID, 'The Parlay Max Payout value must be a positive amount.' MsgNameEN, N'每注串关最高派彩: 单场串关的设置比上线的要高。' MsgNameCS, N'每注串關最高派彩: 單場串關的設置比上線的要高。' MsgNameCT
UNION SELECT 10071 , 5, 'Parlay Max Payout per Bet: The setting of Single Match Parlay is higher than the upline''s.',N'每注串关最高派彩: 单场串关的设置比上线的要高。',N'每注串關最高派彩: 單場串關的設置比上線的要高。'
UNION SELECT 10072 , 5, 'Parlay Max Payout per Bet: The setting of Combo 2 is higher than the upline''s.', N'每注串关最高派彩: 复选2的设置比上线的要高。', N'每注串關最高派彩: 複選2的設置比上線的要高。'
UNION SELECT 10073 , 5, 'Parlay Max Payout per Bet: The setting of Combo 3 - 5 is higher than the upline''s.', N'每注串关最高派彩: 复选3-5的设置比上线的要高。',N'每注串關最高派彩: 複選3-5的設置比上線的要高。'
UNION SELECT 10074 , 5, 'Parlay Max Payout per Bet: The setting of Combo Over 6 is higher than the upline''s.', N'每注串关最高派彩: 复选6的设置比上线的要高。',N'每注串關最高派彩: 複選6的設置比上線的要高。'
)
UPDATE msg
SET msg.MsgNameCS = t.MsgNameCS,
	msg.MsgNameCT = t.MsgNameCT
FROM MsgError msg
	INNER JOIN T ON msg.MsgID = T.MsgID
WHERE t.MsgID IN (10070,10071,10072,10073,10074)

/*
;WITH T AS (
SELECT 20045 MsgID,3 MsgGroupID, 'Template Name already exists.' MsgNameEN, N'มีชื่อเทมเพลตนี้อยู่แล้ว' MsgNameTH, N'Tên Mẫu đã tồn tại.' MsgNameVI, N'模板名称已存在。' MsgNameCS, N'模板名稱已存在。' MsgNameCT
UNION SELECT 20047 , 3, 'This Template does not exist.', N'ไม่มีเทมเพลตนี้', N'Mẫu này không tồn tại.', N'该模板不存在。', N'該模板不存在。'
UNION SELECT 10069 , 5, 'Max Per Number must be equal to or less than Upline''s Max Per Number', N'ค่าสูงสุดต่อหมายเลข จะต้องเท่ากับหรือน้อยกว่า ค่าสูงสุดต่อหมายเลขของอัพไลน์', N'Tiền Cược Tối Đa Cho Mỗi Số phải nhỏ hơn hoặc bằng Tiền Cược Tối Đa Cho Mỗi Số của cấp trên', N'单个号码必须等于或小于上线的单个号码', N'單個號碼必須等於或小於上線的單個號碼'
--UNION SELECT 10070 , 5, 'The Parlay Max Payout value must be a positive amount.', NULL, NULL
UNION SELECT 10071 , 5, 'Parlay Max Payout per Bet: The setting of Single Match Parlay is higher than the upline''s.',N'การจ่ายเงินพาร์เลย์สูงสุดต่อการเดิมพัน: ค่าของพาร์เลย์แมตช์เดี่ยวที่ตั้งไว้ สูงกว่าอัพไลน์',N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Cược Xiên Một Trận đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 单场串关的设置比上线的要高。', N'串關最高派彩: 單場串關的設置比上線的要高。'
UNION SELECT 10072 , 5, 'Parlay Max Payout per Bet: The setting of Combo 2 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุดต่อการเดิมพัน: ค่าของคอมโบ 2 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo 2 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选2的设置比上线的要高。', N'串關最高派彩: 複選2的設置比上線的要高。'
UNION SELECT 10073 , 5, 'Parlay Max Payout per Bet: The setting of Combo 3 - 5 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุดต่อการเดิมพัน: ค่าของคอมโบ 3 - 5 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo 3 - 5 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选3-5的设置比上线的要高。', N'串關最高派彩: 複選3-5的設置比上線的要高。'
UNION SELECT 10074 , 5, 'Parlay Max Payout per Bet: The setting of Combo Over 6 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุดต่อการเดิมพัน: ค่าของคอมโบมากกว่า 6 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo Over 6 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选6的设置比上线的要高。', N'串關最高派彩: 複選6的設置比上線的要高。'
)
UPDATE msg
SET msg.MsgNameTH = t.MsgNameTH
FROM MsgError msg
	INNER JOIN T ON msg.MsgID = T.MsgID
WHERE t.MsgID IN (20045,10071,10072,10073,10074)


DELETE MsgError WHERE MsgID IN (20045,20047,10069,10071,10072,10073,10074)
GO

;WITH T AS (
SELECT 20045 MsgID,3 MsgGroupID, 'Template Name already exists.' MsgNameEN, NULL MsgNameTH, N'Tên Mẫu đã tồn tại.' MsgNameVI, N'模板名称已存在。' MsgNameCS, N'模板名稱已存在。' MsgNameCT
UNION SELECT 20047 , 3, 'This Template does not exist.', N'ไม่มีเทมเพลตนี้', N'Mẫu này không tồn tại.', N'该模板不存在。', N'該模板不存在。'
UNION SELECT 10069 , 5, 'Max Per Number must be equal to or less than Upline''s Max Per Number', N'ค่าสูงสุดต่อหมายเลข จะต้องเท่ากับหรือน้อยกว่า ค่าสูงสุดต่อหมายเลขของอัพไลน์', N'Tiền Cược Tối Đa Cho Mỗi Số phải nhỏ hơn hoặc bằng Tiền Cược Tối Đa Cho Mỗi Số của cấp trên', N'单个号码必须等于或小于上线的单个号码', N'單個號碼必須等於或小於上線的單個號碼'
--UNION SELECT 10070 , 5, 'The Parlay Max Payout value must be a positive amount.', NULL, NULL
UNION SELECT 10071 , 5, 'Parlay Max Payout per Bet: The setting of Single Match Parlay is higher than the upline''s.',N'การจ่ายเงินพาร์เลย์สูงสุด: ค่าของพาร์เลย์แมตช์เดี่ยวที่ตั้งไว้ สูงกว่าอัพไลน์',N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Cược Xiên Một Trận đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 单场串关的设置比上线的要高。', N'串關最高派彩: 單場串關的設置比上線的要高。'
UNION SELECT 10072 , 5, 'Parlay Max Payout per Bet: The setting of Combo 2 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุด: ค่าของคอมโบ 2 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo 2 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选2的设置比上线的要高。', N'串關最高派彩: 複選2的設置比上線的要高。'
UNION SELECT 10073 , 5, 'Parlay Max Payout per Bet: The setting of Combo 3 - 5 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุด: ค่าของคอมโบ 3 - 5 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo 3 - 5 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选3-5的设置比上线的要高。', N'串關最高派彩: 複選3-5的設置比上線的要高。'
UNION SELECT 10074 , 5, 'Parlay Max Payout per Bet: The setting of Combo Over 6 is higher than the upline''s.', N'การจ่ายเงินพาร์เลย์สูงสุด: ค่าของคอมโบมากกว่า 6 ที่ตั้งไว้ สูงกว่าอัพไลน์', N'Thanh Toán Tối Đa Cho Mỗi Cược Xiên: Cài đặt cho Combo Over 6 đang cao hơn giới hạn cược của cấp trên.', N'串关最高派彩: 复选6的设置比上线的要高。', N'串關最高派彩: 複選6的設置比上線的要高。'

)
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
           ,[MsgNameCN])
SELECT[MsgID],[MsgGroupID],[MsgNameEN],MsgNameCT,MsgNameCS,MsgNameEN,ISNULL(MsgNameTH,MsgNameEN),MsgNameEN,MsgNameEN,ISNULL(MsgNameVI,MsgNameEN),1 as IsActive,MsgNameEN
FROM T
*/
