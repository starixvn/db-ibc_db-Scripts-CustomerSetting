/*
	Created: Elodie	
	Task: Initialize Product Status of Lottery for Credit customers
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
USE CustDB
GO

SELECT custid
INTO #EnableSuperOnly
FROM custInfo WITH (NOLOCK) 
WHERE username IN ('SCS','SCSM','SCH','SCAH','SCBH','SCHI','SBRR','WPR')

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 11

UPDATE cs
SET bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #EnableSuperOnly ci WITH(NOLOCK) ON cs.CustID = ci.CustID
