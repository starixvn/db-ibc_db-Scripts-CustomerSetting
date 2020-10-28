/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20201002
    Task: Add New MsgError for Minimize UM Time - Add new Customer Function [#142115]
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO
DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID IN( 90016)

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
SELECT 90016
,10
,N'New Account function is under maintenance from <FromTime> (GMT +8) to <ToTime> (GMT +8): Creation failed'
,N'New Account function is under maintenance from <FromTime> (GMT +8) to <ToTime> (GMT +8): Creation failed'
,N'New Account function is under maintenance from <FromTime> (GMT +8) to <ToTime> (GMT +8): Creation failed'
,N'New Account function is under maintenance from <FromTime> (GMT +8) to <ToTime> (GMT +8): Creation failed'
,N'New Account function is under maintenance from <FromTime> (GMT +8) to <ToTime> (GMT +8): Creation failed'

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

SELECT * FROM MsgError WTTH(NOLOCK) WHERE MsgID IN( 90016)
