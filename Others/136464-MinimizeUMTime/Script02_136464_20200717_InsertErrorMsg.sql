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
,N'<Product> is under maintennance for Customer Settings from <FromTime> (GMT+8) to <ToTime> (GMT+8): Update failed'
,N'<Product> is under maintennance for Customer Settings from <FromTime> (GMT+8) to <ToTime> (GMT+8): Update failed'
,N'<Product> is under maintennance for Customer Settings from <FromTime> (GMT+8) to <ToTime> (GMT+8): Update failed'
,N'<Product> is under maintennance for Customer Settings from <FromTime> (GMT+8) to <ToTime> (GMT+8): Update failed'
,N'<Product> is under maintennance for Customer Settings from <FromTime> (GMT+8) to <ToTime> (GMT+8): Update failed'

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