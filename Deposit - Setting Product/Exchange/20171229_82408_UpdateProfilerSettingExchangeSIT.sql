/*
	Created by: Winnie
	Date: 2017-12-29
	Task: Update profiler setting data for Exchange Product - [Redmine: #66797]
*/ 

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	


UPDATE Dep_ProductSetting WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=19
WHERE ProductSettingID=20

UPDATE Dep_ProductSetting WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=20
WHERE ProductSettingID=21


UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=19
WHERE ProductSettingID=20

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
SET ProductSettingID=20
WHERE ProductSettingID=21

DECLARE @SportType SMALLINT = 221 
DECLARE @bitmapOrder INT=0

SET @bitmapOrder = (SELECT bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE Sporttype =  @SportType )	

UPDATE T 
			SET bitmapIsDisabled = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsDisabled, @bitmapOrder,1))
			, bitmapIsHidden = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsHidden, @bitmapOrder,0))	
FROM [dbo].[Dep_CustProductStatus] T (ROWLOCK)
WHERE CustID=3233912