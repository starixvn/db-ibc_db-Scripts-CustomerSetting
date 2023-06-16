/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created by: Luke
    Date: 2023/06/16
	Task:  Update status for super 479603 [redmine : #186046]
	DB: DBCUST/CustDB

    Revisions: 

	Param's Explanation:  

*/
USE CustDB
GO

DECLARE @custid INT = 479603 --super

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,42,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,42,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = @custid