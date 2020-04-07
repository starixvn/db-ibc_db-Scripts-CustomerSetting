/*
    Created: Eden
    Date: 20200407
    Task: Add New MsgError for block add new cust [#131758]
    DB: DBCUST/CustDB
*/ 
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
SELECT 90013
,10
,N'We are in processing for new product offering, please try to create downline account after <UnblockTime>. Please contact your upline or CSD for further information.'
,N'系統正在進行提供新產品的調整，請於下午<UnblockTime>後再重試創建下線帳戶。請聯繫您的上線或客服了解詳情。'
,N'系统正在进行提供新产品的调整，请于下午<UnblockTime>后再重试进行创建下线账户。请联系您的上线或客服了解详情。'
,N'เรากำลังดำเนินการเตรียมนำเสนอโปรดักใหม่ กรุณาลองสร้างดาวไลน์อีกครั้งหลัง  <UnblockTime>  โปรดติดต่ออัพไลน์ของคุณหรือฝ่ายลูกค้าสัมพันธ์เพื่อสอบถามข้อมูลเพิ่มเติม'
,N'Chúng tôi đang xử lý việc ra mắt sản phẩm mới, vui lòng tạo tài khoản cấp dưới sau <UnblockTime>. Vui lòng liên hệ với cấp trên hoặc bộ phận Chăm Sóc Khách Hàng để biết thêm thông tin.'

--SELECT * FROM MsgError WHERE MsgID = 90013

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