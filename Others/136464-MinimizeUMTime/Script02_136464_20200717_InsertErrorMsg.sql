/*
    Created: Eden
    Date: 20200717
    Task: Add New MsgError for Minimize UM Time - Edit Function [#136464]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID = 90014

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
SELECT 90014
,10
,N'System is under maintenance (GMT+8) </br> <Product>: Customer Settings from <FromTime> to <ToTime>: Update failed'
,N'系統正在維護中 (GMT+8) </br> <Product>: 客戶設定從 <FromTime> 至 <ToTime>: 更新失敗'
,N'系统正在维护中 (GMT+8) </br> <Product>: 客户设定从 <FromTime> 至 <ToTime>: 更新失败'
,N'ระบบอยู่ระหว่างการบำรุงรักษา (GMT+8) </br> <Product>: การตั้งค่าของลูกค้าตั้งแต่ <FromTime> ถึง <ToTime>: การอัปเดตล้มเหลว'
,N'System is under maintenance (GMT+8) </br> <Product>: Customer Settings from <FromTime> to <ToTime>: Update failed'

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

SELECT * FROM MsgError WTTH(NOLOCK) WHERE MsgID = 90014