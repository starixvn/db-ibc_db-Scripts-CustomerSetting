/*
	Created: Elodie	
	Task: Initialize Product Status of Lucky3 for Credit customers
	DB: DBCUST/CustDB
	Date: 20171212
*/ 
USE CustDB
GO

SELECT custid
INTO #EnableSuperOnly
FROM custInfo WITH (NOLOCK) 
WHERE username IN ('SCHK','SCM','SCAI','SCI','SCDH','SCDK','TP','TH','TY','TF','TC','TD','TZ','EEM','EEH','EED','EEK')

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9

UPDATE cs
SET bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #EnableSuperOnly ci WITH(NOLOCK) ON cs.CustID = ci.CustID
