/*	
	Created: Elodie
	Date: 2019-05-03
	Task: Clear given credit for new created SMAs
	DB: DBMSG/bodb_Message
*/

------------------------------STEP 3: Send personal message--------------------------------------------------------------
DECLARE @Content_en NVARCHAR(4000), @Content_vn NVARCHAR(4000), @Content_ch NVARCHAR(4000), @Content_cs NVARCHAR(4000), @Content_th NVARCHAR(4000)
DECLARE @MessageID INT, @MessageID1 INT, @MessageID2 INT, @Creator INT = 10278938, @CreatorName VARCHAR(50) = 'starixIT', @Max INT, @i INT, @CustID INT, @UserName VARCHAR(30)
DECLARE @PostTime DATETIME = GETDATE()
CREATE TABLE #UplineList (ID INT IDENTITY(1,1), CustId INT, username VARCHAR(30), MsgId INT)

DECLARE @Batch TINYINT = 2

--Send personal message for super
-- English
SET @Content_en = 'Dear valued agents, some of your Masters did not login to agency site within 7 days after creation. The system has already removed these unused accounts'' credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- VietNamese
SET @Content_vn = N'"Kính gửi quý khách hàng, Một số Master của bạn không đăng nhập vào trang Agency trong vòng 7 ngày sau khi tạo. Hệ thống đã thu hồi tín dụng của những tài khoản không sử dụng này. Điều này nhằm ngăn chặn bên thứ ba lợi dụng tuyến dưới không sử dụng của bạn. Trân trọng."'

-- Chinese Traditional
SET @Content_ch = N'敬愛的客戶，由於某些總代理在帳號建立後的7天內都不曾登入，系統已清除這些未曾使用帳號的餘額。這是為了防範您下線無使用的空白賬號讓第三方有機可乘。'
	
-- Chinese Simplified
SET @Content_cs = N'敬爱的客户，由于某些总代理在账号创建后的7天内都不曾登入，系统已清除这些未曾使用账号的余额。这是为了防范您下线无使用的空白账号让第三方有机可乘。'
	
-- Thai
SET @Content_th = N'"เรียน ลูกค้าที่เคารพ เนื่องจากบางบัญชีของมาสเตอร์ ที่สร้างขึ้นใหม่และไม่ได้ลงชื่อเข้าใช้เว็ปไซต์ตัวแทนภายใน7วันนับจากวันสร้างบัญชี ระบบจะล้างวงเงินเครดิตทั้งหมดออกจากบัญชี เพื่อความปลอดภัยและป้องกันบัญชีของดาวน์ไลน์ถูกใช้โดยบุคคลที่สาม ขอบพระคุณ"'	

-- Insert message
EXEC dbo.Dot_Msg_SetMessage2 
	@MessageId	= @MessageID1 OUTPUT,
	@Content_en = @Content_en,
	@Content_ch = @Content_ch,
	@Content_cs = @Content_cs,
	@Content_th = @Content_th,
	@Content_vn = @Content_vn,
	@MsgType	= 1,			 -- message to customer (personal)
	@IsSticky	= 0,			 -- Is special Message or not 
	@Creator	= @Creator,
	@CreatorName = @CreatorName,
	@IsTest		= 0,			 -- Is test or not 
	@IsBatch	= 0			 -- normal message (no need to replace the symbol @@ by transid when display)
		
-- Insert Message Target	
INSERT INTO #UplineList( CustId, username, MsgId)
SELECT DISTINCT m.srecommend, c.username, @MessageID1
FROM DBCUST.CustDB.dbo.CustomerClearCredit m
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON m.srecommend = c.custid
WHERE m.roleid = 3 AND m.Batch = @Batch

--Send personal message for master
-- English
SET @Content_en = 'Dear valued agents, some of your Agents did not login to agency site within 7 days after creation. System has already removed these unused accounts'' credit. This is to prevent your unused downlines from being taken advantage by third party. Thank you.'	

-- VietNamese
SET @Content_vn = N'"Kính gửi quý khách hàng, Một số Agent của bạn không đăng nhập vào trang Agency trong vòng 7 ngày sau khi tạo. Hệ thống đã thu hồi tín dụng của những tài khoản không sử dụng này. Điều này nhằm ngăn chặn bên thứ ba lợi dụng tuyến dưới không sử dụng của bạn. Trân trọng."'	

-- Chinese Traditional
SET @Content_ch = N'敬愛的客戶，由於某些代理在帳號建立後的7天內都不曾登入，系統已清除這些未曾使用帳號的餘額。這是為了防範您下線無使用的空白賬號讓第三方有機可乘。'	
	
-- Chinese Simplified
SET @Content_cs = N'敬爱的客户，由于某些代理在账号创建后的7天内都不曾登入，系统已清除这些未曾使用账号的余额。这是为了防范您下线无使用的空白账号让第三方有机可乘。'	
	
-- Thai
SET @Content_th = N'"เรียน ลูกค้าที่เคารพ เนื่องจากบางบัญชีของเอเย่นต์ ที่สร้างขึ้นใหม่และไม่ได้ลงชื่อเข้าใช้เว็ปไซต์ตัวแทนภายใน7วันนับจากวันสร้างบัญชี ระบบจะล้างวงเงินเครดิตทั้งหมดออกจากบัญชี เพื่อความปลอดภัยและป้องกันบัญชีของดาวน์ไลน์ถูกใช้โดยบุคคลที่สาม ขอบพระคุณ"'	

-- Insert message
EXEC dbo.Dot_Msg_SetMessage2 
	@MessageId	= @MessageID2 OUTPUT,
	@Content_en = @Content_en,
	@Content_ch = @Content_ch,
	@Content_cs = @Content_cs,
	@Content_th = @Content_th,
	@Content_vn = @Content_vn,
	@MsgType	= 1,			 -- message to customer (personal)
	@IsSticky	= 0,			 -- Is special Message or not 
	@Creator	= @Creator,
	@CreatorName = @CreatorName,
	@IsTest		= 0,			 -- Is test or not 
	@IsBatch	= 0			 -- normal message (no need to replace the symbol @@ by transid when display)
			
-- Insert Message Target	
INSERT INTO #UplineList (CustId, username, MsgId)
SELECT DISTINCT a.mrecommend, c.username, @MessageID2
FROM DBCUST.CustDB.dbo.CustomerClearCredit a
	INNER JOIN bodb02.dbo.customer c WITH (NOLOCK) ON a.mrecommend = c.custid
WHERE a.roleid = 2 AND a.Batch = @Batch

--Send message for user
SET @i = 1
SELECT @Max = COUNT(ID) FROM #UplineList

WHILE @i <= @Max
BEGIN
	SELECT @CustID = custid, @UserName = username, @MessageId = MsgId FROM #UplineList WHERE ID = @i

	EXEC dbo.Dot_Msg_SetUsrMessage
	@MessageId	= @MessageId,
	@TargetId	= @CustID,
	@TargetName = @UserName,
	@PostTime	= @PostTime,
	@isRead		= 0		
		
	SELECT @i = @i + 1
END
