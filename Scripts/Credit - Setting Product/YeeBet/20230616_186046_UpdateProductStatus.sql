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

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,42,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,42,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,33,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,33,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,6,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,6,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,27,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,27,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,29,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,29,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,31,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,31,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,30,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,30,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,24,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,24,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,25,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,25,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,22,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,22,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603
GO

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,20,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,20,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK, UPDLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON c.custid = cs.CustID
WHERE c.srecommend = 479603