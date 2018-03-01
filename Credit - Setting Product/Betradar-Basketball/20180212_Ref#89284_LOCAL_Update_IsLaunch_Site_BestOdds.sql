/*
    Created: 20180212@Vicky
    Task: Update IsLaunched  to test
    DB: DBCUST/CustDB
*/

DECLARE @xmlStrHidden VARCHAR(MAX)
SET @xmlStrHidden = '<root><r b="10" s="0" /></root>'

UPDATE CustProductStatus WITH (ROWLOCK,UPDLOCK)
SET bitmapIsHidden =(SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapIsHidden, @xmlStrHidden)) 
WHERE CustID IN (1176092,14307199)

UPDATE ProductLaunchedSiteCurrency 
SET IsLaunched = 1 
WHERE SiteId = 1 AND Sporttype  = 193