/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231130@Luke
	Task: Alpha - Enhance Auto Transfer function (Phase 2) [Redmine: #195135]
	DB: DBCUST/CustDB
*/

CREATE TABLE #tmpMsgError(
	MsgID INT, 
	MsgNameEN NVARCHAR(500),
	MsgNameCS NVARCHAR(500),
	MsgNameCT NVARCHAR(500),
	MsgNameTH NVARCHAR(500)
)

DECLARE @MsgGroupID INT = 6,
		@IsActive	BIT = 1

INSERT INTO #tmpMsgError(MsgID, MsgNameEN, MsgNameCS, MsgNameCT, MsgNameTH)
	SELECT 50035, 'Your Transfer Condition was changed by upline. The page will be automatically refreshed.', N'您的转账设定已被上线更改。该页面将自动刷新。', N'您的轉賬設定已被上線更改。該頁面將自動刷新。', N'เงื่อนไขการโอนของคุณถูกเปลี่ยนแปลงโดยอัพไลน์.หน้านี้จะรีเฟรชเพื่อแสดงผลใหม่โดยอัต.'
UNION ALL
	SELECT 50036, 'Auto Transfer Schedule for account <username> has been successfully updated. However, this process is taking place, and the account will be queued for Auto Transfer at the next scheduled time based on its Auto Transfer Schedule. ', N'账号 <username> 自动转账日程表已成功更新。但是，转账过程正在进行中，所以该帐户将根据其自动转账日程表在下一个时间段队列中等待自动转账。', N'賬號 <username> 自動轉賬日程表已成功更新。但是，轉帳過程正在進行中，所以該帳戶將根據其自動轉帳日程表在下一個時間段隊列中等待自動轉帳。', N'กำหนดการโอนอัตโนมัติสำหรับบัญชี <username> ได้รับการอัปเดตเรียบร้อยแล้ว. อย่างไรก็ตาม ระบบกำลังดำเนินการอยู่ในขณะนี้ บัญชีนี้จะถูกจัดคิวสำหรับการโอนอัตโนมัติในครั้งถัดไปตามกำหนดการของการโอนอัตโนมัติ'
UNION ALL
	SELECT 50037, 'Your account has been enabled for All Day Balance Transfer. The page will be automatically refreshed.', N'您的账号已启用全天余额转账。该页面将自动刷新。', N'您的賬號已啟用全天餘額轉賬。該頁面將自動刷新。', N'บัญชีของคุณได้เปิดใช้งานการโอนยอดคงเหลือทั้งวันแล้ว การ. หน้านี้จะรีเฟรชเพื่อแสดงผลใหม่โดยอัต.'

IF EXISTS(
	SELECT TOP 1 1
	FROM MsgError WITH (NOLOCK)
	WHERE MsgID IN (50035,50036,50037)
)
	RAISERROR('This MsgID has been used.', 16, 1)
ELSE
	INSERT INTO MsgError(MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
	SELECT				MsgID, @MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameEN, MsgNameTH, MsgNameEN, MsgNameEN, MsgNameEN,	@IsActive, MsgNameEN 
	FROM #tmpMsgError
