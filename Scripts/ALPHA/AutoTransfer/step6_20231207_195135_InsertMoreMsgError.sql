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
	SELECT 50038, 'The Auto Transfer has been enabled for this account. However, this process is taking place, and the account will be queued for Auto Transfer at the next scheduled time based on its Auto Transfer Schedule. ', N'该帐户已启用自动转账。但是，转账过程正在进行中，所以该帐户将根据其自动转账日程表在下一个时间段队列中等待自动转账。', N'該帳戶已啟用自動轉帳。但是，轉帳過程正在進行中，所以該帳戶將根據其自動轉帳日程表在下一個時間段隊列中等待自動轉帳。', N'การโอนอัตโนมัติสำหรับบัญชีนี้ได้เปิดใช้งานแล้ว อย่างไรก็ตาม ระบบกำลังดำเนินการอยู่ในขณะนี้ บัญชีนี้จะถูกจัดคิวสำหรับการโอนอัตโนมัติในครั้งถัดไปตามกำหนดการของการโอนอัตโนมัติ'
IF EXISTS(
	SELECT TOP 1 1
	FROM MsgError WITH (NOLOCK)
	WHERE MsgID IN (50038)
)
	RAISERROR('This MsgID has been used.', 16, 1)
ELSE
	INSERT INTO MsgError(MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
	SELECT				MsgID, @MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameEN, MsgNameTH, MsgNameEN, MsgNameEN, MsgNameEN,	@IsActive, MsgNameEN 
	FROM #tmpMsgError
