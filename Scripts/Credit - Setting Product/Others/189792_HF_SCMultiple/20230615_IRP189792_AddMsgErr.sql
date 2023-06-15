/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20230615@189792
	Task: Add new MsgErr [#RedmineID:#189792]
	DB: DBCust/CustDB
*/


;WITH T AS (
	SELECT 40062 MsgID,'Sorry, you can only create 5 members per day, please try again tomorrow.' MsgNameEN, N'抱歉，您每天只能创建五个会员账号，请您明天再次尝试。' MsgNameCS, N'抱歉，您每天只能創建五個會員賬號，請您明天再次嘗試。' MsgNameCT, N'Xin lỗi, bạn chỉ có thể tạo mới 5 Member mỗi ngày, vui lòng thử lại vào ngày mai.' MsgNameVI
UNION SELECT 40063,	'Sorry, you can only create 3 agents per day, please try again tomorrow.',N'抱歉，您每天只能创建三个代理账号，请您明天再次尝试。', N'抱歉，您每天只能創建三個代理賬號，請您明天再次嘗試。', N'Xin lỗi, bạn chỉ có thể tạo mới 3 Agent mỗi ngày, vui lòng thử lại vào ngày mai.'
UNION SELECT 40064,	'Sorry, you can only create 3 masters per day, please try again tomorrow.',N'抱歉，您每天只能创建三个总代理账号，请您明天再次尝试。',N'抱歉，您每天只能創建三個總代理賬號，請您明天再次嘗試。',N'Xin lỗi, bạn chỉ có thể tạo mới 3 Master mỗi ngày, vui lòng thử lại vào ngày mai.'
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
SELECT MsgID, 5,MsgNameEN,MsgNameCT,[MsgNameCS],MsgNameEN,MsgNameEN,MsgNameEN,MsgNameEN,MsgNameVI,1,MsgNameEN
FROM T

