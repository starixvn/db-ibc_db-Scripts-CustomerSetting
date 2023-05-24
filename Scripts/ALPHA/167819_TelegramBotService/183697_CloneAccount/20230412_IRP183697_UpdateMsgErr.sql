/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230412@Johnson
	Task: update translation for MsgError [#RedmineID:#183697]
	DB: DBCUST/CustDB
*/

WITH T AS (
	SELECT 70010 MsgID, 'You have exceeded your credit limit.' MsgNameEN, N'您已超出了您的信用额度 。' MsgNameCS, N'您已超出了您的信用額度。' MsgNameCT, N'เกินวงเงินเครดิตของคุณแล้ว' MsgNameTH, N'Hạn mức của bạn không đủ để cấp.' MsgNameVI
	UNION SELECT 70009, 'Member max credit has been exceeded.', N'已超过会员最高信用额。', N'已超過會員最高信用額 。', N'เกินเครดิตสูงสุดของสมาชิกแล้ว', N'Bạn đã vượt quá hạn mức tối đa được cấp cho Member.'
)
UPDATE msg
SET
	MsgNameEN = t.MsgNameEN,
	MsgNameCT = t.MsgNameCT,
	MsgNameCS = t.MsgNameCS,
	MsgNameJP = t.MsgNameEN,
	MsgNameTH = t.MsgNameTH,
	MsgNameKO = t.MsgNameEN,
	MsgNameES = t.MsgNameEN,
	MsgNameVI = t.MsgNameVI
FROM  MsgError msg WITH (UPDLOCK)
	INNER JOIN T ON msg.MsgID = t.MsgID
	
