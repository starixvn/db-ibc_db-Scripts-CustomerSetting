/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Date: 2024-04-25
	Created: @Helios
	Task: Inital Data MsgError PT Limit  [#198960] 
	DB: DBCUST-CUSTDB
*/

IF NOT EXISTS (SELECT 1 FROM MsgError me WITH (NOLOCK) WHERE me.MsgID = 10078)
BEGIN
	INSERT INTO MsgError 
	(
		MsgID
	    , MsgGroupID
	    , MsgNameEN
	    , MsgNameCT
	    , MsgNameCS
	    , MsgNameJP
	    , MsgNameTH
	    , MsgNameKO
	    , MsgNameES
	    , MsgNameVI
	    , IsActive
	    , MsgNameCN
	    , MsgNameIN
	)
	SELECT
		10078 AS MsgID
	    , MsgGroupID
	    , MsgNameEN = CONCAT (N'RNG Casino: ' , MsgNameEN)
	    , MsgNameCT = CONCAT (N'RNG娛樂城: ' , MsgNameCT)
	    , MsgNameCS = CONCAT (N'RNG娱乐城: ' , MsgNameCS)
	    , MsgNameJP = CONCAT (N'RNG Casino: ' , MsgNameJP)
	    , MsgNameTH = CONCAT (N'RNG Casino: ' , MsgNameTH)
	    , MsgNameKO = CONCAT (N'RNG Casino: ' , MsgNameKO)
	    , MsgNameES = CONCAT (N'RNG Casino: ' , MsgNameES)
	    , MsgNameVI = N'RNG Casino: Bạn đã đạt đến giới hạn cho số lần cập nhật Position Taking trong tháng (1 lần). Vui lòng thử lại sau {0} 12:00 PM GMT+8.'
	    , IsActive
	    , MsgNameCN
	    , MsgNameIN
	FROM MsgError me WITH (NOLOCK)
	WHERE me.MsgID = 10068
END




