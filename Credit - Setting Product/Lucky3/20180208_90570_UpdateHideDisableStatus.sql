/*
	Created: Elodie	
	Task: Update Hide and Disable Status of Lucky3
	DB: DBCUST/CustDB
	Date: 20180208
*/ 
USE CustDB
GO
				
/*******************************CUST PRODUCT STATUS TABLE*******************************/		
DECLARE @BitmapOrder TINYINT

SELECT custid, ci.roleid
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.mrecommend IN (27780175,--	999HKD
						27899314,--	AH501
						27611472)--	WBRT

	AND enabled = 1
	
SELECT @BitmapOrder = 9

--2324 affected rows
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,1)),
	cs.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID

