/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden
    Date: 20200717
    Task: Add New MsgError for Minimize UM Time - Edit Function [#136464]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID IN( 90014,90017)

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
,N'Unable to Update because of the maintenance of the settings below (GMT +8):<br/>- <Product>: Customer Settings (<FromTime> to <ToTime>)'
,N'由于以下设定正在维护中，因此无法更新 (GMT+8)：<br/>- <Product>：客戶設定 (<FromTime> 至 <ToTime>)'
,N'由於以下設定正在維護中，因此無法更新 (GMT+8)：<br/>- <Product>：客户设定 (<FromTime> 至 <ToTime>)'
,N'เนื่องจากอยู่ในระหว่างการปรับปรุง ดังนั้นในช่วงเวลาดังกล่าวจึงไม่สามารถอัพเดทได้ (GMT+8):<br/>- <Product>: การตั้งค่าของลูกค้า (<FromTime> ถึง <ToTime>)'
,N'Không thể cập nhật do hệ thống đang bảo trì các thiết lập sau (GMT +8):<br/>- <Product>: Thiết lập khách hàng (<FromTime> đến <ToTime>)'
UNION ALL
SELECT 90017
,10
,N'Do nothing'
,NULL
,NULL
,NULL
,NULL

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

SELECT * FROM MsgError WTTH(NOLOCK) WHERE MsgID IN( 90014,90017)
