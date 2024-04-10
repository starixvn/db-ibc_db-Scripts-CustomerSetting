/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240326@Luke
	Task: Alpha - Enhance Auto Transfer function (Phase 3) [Redmine: #195551]
	DB: DBCUST/CustDB
*/

CREATE TABLE #tmpMsgError(
	MsgID INT, 
	MsgNameEN NVARCHAR(500),
	MsgNameCS NVARCHAR(500),
	MsgNameCT NVARCHAR(500),
	MsgNameTH NVARCHAR(500)
)

DECLARE @MsgGroupID INT = 5,
		@IsActive	BIT = 1

INSERT INTO #tmpMsgError(MsgID, MsgNameEN, MsgNameCS, MsgNameCT, MsgNameTH)
	SELECT	40065, 'This account does not exist.', N'此账号不存在。', N'此帳號不存在。', N'ไม่มีบัญชีนี้'
UNION ALL
	SELECT	40066, 'This account does not belong to your downline', N'该账号不属于您的下线', N'該帳號不屬於您的下線', N'บัญชีนี้ไม่ได้เป็นของดาวน์ไลน์ของคุณ'

INSERT INTO MsgError(MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
SELECT				MsgID, @MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameEN, MsgNameTH, MsgNameEN, MsgNameEN, MsgNameEN,	@IsActive, MsgNameEN 
FROM #tmpMsgError

