/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden
    Date: 20200812
    Task: Add New MsgError for Minimize UM Time - 1st Deposit [#136741]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID = 90016

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
	)
SELECT 90016
,10
,N'Server maintenance notice
Start Time: <FromTime> (GMT +8)
Resolution Time: <ToTime> (GMT +8)

例行維護通知
开始时间：<FromTime> (GMT +8)
预计结束时间：<ToTime> (GMT +8)'

INSERT INTO MsgError(
	 MsgID
	,MsgGroupID
	,MsgNameEN
	,IsActive
	)
SELECT MsgID
	,MsgGroupID
	,MsgNameEN
	,1
FROM @MsgError

SELECT * FROM MsgError WITH(NOLOCK) WHERE MsgID = 90016