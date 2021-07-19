/*
    Created: Eden
    Date: 20200424
    Task: Add New MsgError for Limit downline member by QR code [#129373]
    DB: DBCUST/CustDB
*/ 
USE CUSTDB
GO

DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID = 40051

DECLARE @MsgError TABLE(
 MsgID	int
,MsgGroupID	int
,MsgNameEN	nvarchar(500)
,MsgNameCT	nvarchar(500)
,MsgNameCS	nvarchar(500)
,MsgNameTH	nvarchar(500)
,MsgNameVI	nvarchar(500)
)

INSERT INTO @MsgError(MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameTH
	,MsgNameVI
	)
SELECT 40051
,5
,N'You can only create up to 200 new members every day by this function.'
,N'使用此功能時，每日最多只能新建200個會員。'
,N'使用此功能时，每天最多只能创建200个新成员。'
,N'คุณสามารถสร้างสมาชิกใหม่ได้สูงสุด 200 บัญชีต่อวันด้วยฟังก์ชันนี้'
,N'Bạn chỉ có thể tạo tối đa 200 Member mới mỗi ngày bằng tính năng này.'

INSERT INTO MsgError(
	 MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameJP
	,MsgNameTH
	,MsgNameKO
	,MsgNameES
	,MsgNameVI
	,IsActive
	,MsgNameCN
	)
SELECT MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameEN
	,MsgNameTH
	,MsgNameEN
	,MsgNameEN
	,MsgNameVI
	,1
	,NULL
FROM @MsgError

SELECT * FROM MsgError WITH(NOLOCK) WHERE MsgID = 40051