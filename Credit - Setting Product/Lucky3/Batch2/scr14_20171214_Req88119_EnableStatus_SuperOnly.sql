/*
	Created: Elodie	
	Task: Initialize Product Status of Lucky3 for Credit customers
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
USE CustDB
GO

SELECT custid
INTO #EnableSuperOnly
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'SCHK','SCM','SCS','SCSM','SCH','SCAH','SCAI','SCI','SCBH','SCHI','SCDH','SCDK','HIS','HIH','HIU','HAH',
					'HIM','HIK','HIW','HIT','HIF','HIJ','HIC','8000HK','8000AHK','S8T','S8R','S8U','S8KT','S8H','S8AR',
					'S8AH','S8BR','S8BH','S8CR')
	AND roleid = 4

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9

UPDATE cs
SET bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #EnableSuperOnly ci WITH(NOLOCK) ON cs.CustID = ci.CustID
