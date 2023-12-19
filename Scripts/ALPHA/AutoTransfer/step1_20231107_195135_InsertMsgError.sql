/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231107@Luke
	Task: Alpha - Enhance Auto Transfer function (Phase 2) [Redmine: #195135]
	DB: DBCUST/CustDB
*/

DECLARE @tmpMsgError TABLE(
	MsgID INT, 
	MsgNameEN NVARCHAR(500),
	MsgNameCS NVARCHAR(500),
	MsgNameCT NVARCHAR(500),
	MsgNameTH NVARCHAR(500)
)

DECLARE @MsgGroupID INT = 6,
		@IsActive	BIT = 1

IF EXISTS (
	SELECT TOP 1 1 
	FROM MsgError WITH (NOLOCK)
	WHERE MsgID IN (50033, 50034)
	)
BEGIN 
	RAISERROR('MsgID(s) has already been used.', 16, 1)
END
ELSE
BEGIN
	INSERT INTO @tmpMsgError(MsgID, MsgNameEN, MsgNameCS, MsgNameCT, MsgNameTH)
		SELECT	50033, 'This account has been disabled Auto Transfer:', N'该账号自动转账已被禁用：', N'該帳號自動轉帳已禁用：', N'บัญชีนี้ถูกปิดการใช้งาน การโอนอัตโนมัติ:'
	UNION ALL
		SELECT	50034, 'There is no change of Transfer Condition to update.', N'转账设定没有变化无需更新。', N'轉賬設定沒有變化無需更新。', N'ไม่มีการเปลี่ยนแปลงเงื่อนไขการโอนที่ต้องอัปเดต'

	INSERT INTO MsgError(MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
	SELECT				MsgID, @MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameEN, MsgNameTH, MsgNameEN, MsgNameEN, MsgNameEN,	@IsActive, MsgNameEN 
	FROM @tmpMsgError
END


