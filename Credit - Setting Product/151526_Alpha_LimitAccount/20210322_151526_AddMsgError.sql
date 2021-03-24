/*
	Created: 20210322@Winfred
	Task : add MsgError  [redmine:#151526]
	
*/
--Step 1: add MsgError @DBCUST/CustDB
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.MsgError msg WITH(NOLOCK)
				WHERE 	msg.MsgID = 40056		
			)
	BEGIN
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
		SELECT 	
			40056
			,5
			,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
			,N'很抱歉，無法再新增帳戶。您已達每日新增帳戶數量上限(300)。'
			,N'很抱歉，无法再新增账户。您已达每日新增账户数量上限(300)。'
			,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
			,N'คุณไม่สามารถสร้างบัญชีเพิ่มได้  จำนวนสูงสุดที่สร้างได้ต่อวันคือ <300>'
			,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
			,N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'
			,N'Xin lỗi, bạn không thể tạo thêm tài khoản. Bạn chỉ có thể tạo mới tối đa <300> tài khoản mỗi ngày.'
			,1
			,'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.'	  
	END 
	ELSE
	BEGIN
	   UPDATE MsgError WITH(ROWLOCK)
	   SET	MsgNameEN = N'Sorry, you cannot create more accounts. The maximum accounts created per day is <300>.',
			MsgNameVI = N'Xin lỗi, bạn không thể tạo thêm tài khoản. Bạn chỉ có thể tạo mới tối đa <300> tài khoản mỗi ngày.',
			MsgNameCT = N'很抱歉，無法再新增帳戶。您已達每日新增帳戶數量上限(300)。',
			MsgNameCS = N'很抱歉，无法再新增账户。您已达每日新增账户数量上限(300)。',
			MsgNameTH = N'คุณไม่สามารถสร้างบัญชีเพิ่มได้  จำนวนสูงสุดที่สร้างได้ต่อวันคือ <300>'
	   WHERE MsgID = 40056
	END	
	