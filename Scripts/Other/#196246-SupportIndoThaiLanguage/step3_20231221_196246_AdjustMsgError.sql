/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231124@Luke
	Task: LAP - Support Indonesian & Thai language [Redmine: #196246]
	DB: DBCUST/CustDB
*/

--Update Indo & Thai Msg
CREATE TABLE #tmpMsgError(
	MsgID INT, 
	MsgNameEN NVARCHAR(500), 
	MsgNameIN NVARCHAR(500),
	MsgNameTH NVARCHAR(500)
)

INSERT INTO #tmpMsgError(MsgID, MsgNameEN, MsgNameIN, MsgNameTH) VALUES
(200017, N'This is the default group. Do you want to proceed?', N'Ini adalah grup default. Apakah Anda ingin melanjutkan?', N'นี่คือกลุ่มเริ่มต้น คุณต้องการดำเนินการต่อหรือไม่')

UPDATE m
SET m.MsgNameIN = t.MsgNameIN, m.MsgNameTH = t.MsgNameTH
FROM MsgError m WITH (ROWLOCK)
	INNER JOIN #tmpMsgError t ON m.MsgID = t.MsgID

