/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240223@Luke
	Task: Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBCUST/CustDB
*/
IF EXISTS (SELECT 1 FROM dbo.MsgError WITH (NOLOCK) WHERE MsgID = 90027)
	RAISERROR ('This MsgID has been chosen.', 16, 1)
ELSE
	INSERT INTO MsgError(MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameTH, IsActive)
		SELECT 90027 AS MsgID, 
				10 AS MsgGroupID, 
				'The number of notification filters has exceeded the maximum limit of 3.' AS MsgNameEN, 
				N'篩選通知的數量已超過最大限制3' AS MsgNameCT,
				N'筛选通知的数量已超过最大限制 3。' AS MsgNameCS,
				N'จำนวนตัวกรองสำหรับการแจ้งเตือนเกินจากขีดจำกัดสูงสุดที่กำหนดคือ 3 ตัว' AS MsgNameTH,
				1 AS IsActive 