/*
	Created: 20171106@Winnie
	Task: insert the Setting of Exchange of new licensees into the DCS database.
	Redmine: https://redmine.nexcel.vn/issues/82408
	DB: DBCUST/CUSTDB
*/ 
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT
	, @currency INT
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	
	IF (dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 		
		OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0 
	   )
		RETURN

	CREATE TABLE #tblCust (custid INT, roleid INT)
	DECLARE @SportType SMALLINT = 221 -- just for get bitmapOrder for ProductStatus
	DECLARE @ProductProfileList VARCHAR(200) = '19,20'
	, @ProductID INT = 31 
	-- For ProductStatus param
	, @bitmapOrder INT=0

	SET @bitmapOrder = (SELECT bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE Sporttype =  @SportType )	

	INSERT INTO #tblCust (custid,roleid)			
	SELECT custid,roleid
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend =@srecommend
		AND mrecommend NOT IN (SELECT custid FROM custinfo WITH(NOLOCK)
							   WHERE srecommend=@srecommend and username like '%Acc%' and roleid=3)
		AND custid <= @max_custid	

	-- Status Process
	UPDATE T 
			SET bitmapIsDisabled = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsDisabled, @bitmapOrder,0))
			, bitmapIsHidden = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsHidden, @bitmapOrder,0))		
				
	FROM [dbo].[Dep_CustProductStatus] T (ROWLOCK)
		INNER JOIN #tblCust C ON C.custid = T.custid

	INSERT INTO [dbo].[Dep_CustDiscountSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
	SELECT c.custid,221,8001,0.05
	FROM #tblCust c WITH(NOLOCK)
	WHERE c.roleid IN(2,3,4)

		-- Licensee profile list
	IF NOT EXISTS (SELECT 1 
				   FROM Dep_LicenseeProductSetting lps WITH (NOLOCK)
						INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON lps.ProductSettingID = ps.ProductSettingID
				   WHERE CustID = @srecommend AND ps.ProductID= @ProductID)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting (CustID,ProductSettingID)
		SELECT @srecommend, t.val
		FROM dbo.strSplit(@ProductProfileList,',') t
	END	

END	

GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT, @site VARCHAR (50), @currency INT 
SELECT  @max_custid= xxx ---input maxcustid
DECLARE @ProductID INT = 31
CREATE TABLE #Supers_Offered (custid INT)
INSERT INTO #Supers_Offered (custid)
SELECT DISTINCT lds.CustID
FROM Dep_LicenseeProductSetting lds WITH (NOLOCK)
	INNER JOIN Dep_CustSuper c WITH (NOLOCK) on c.custid = lds.CustID 
	INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON lds.ProductSettingID = PS.ProductSettingID AND ps.ProductID= @ProductID
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.ProductSettingID = ps.ProductSettingID
WHERE PSD.SportType = 221

INSERT INTO #supers(custid,currency)
SELECT custid,currency
FROM  Dep_CustSuper with(nolock) 
WHERE site in ('alog','12bet','spondemo')
	AND custid <= @max_custid
	AND currency IN (3,20,61)
	AND custid NOT IN (SELECT custid FROM #Supers_Offered)
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency=currency			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @currency=@currency, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	
DROP TABLE #supers

GO		

-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------

 
CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT, @site VARCHAR (50), @currency INT 
SELECT  @max_custid= xxx ---input maxcustid

DECLARE @ProductID INT = 31
CREATE TABLE #Supers_Offered (custid INT)
INSERT INTO #Supers_Offered (custid)
SELECT DISTINCT lds.CustID
FROM Dep_LicenseeProductSetting lds WITH (NOLOCK)
	INNER JOIN Dep_CustSuper c WITH (NOLOCK) on c.custid = lds.CustID 
	INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON lds.ProductSettingID = PS.ProductSettingID AND ps.ProductID= @ProductID
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.ProductSettingID = ps.ProductSettingID
WHERE PSD.SportType = 221

INSERT INTO #supers(custid,currency)
SELECT custid,currency
FROM  Dep_CustSuper with(nolock) 
WHERE  site in ('alog','12bet','spondemo')
	AND custid <= @max_custid
	AND currency IN (3,20,61) -- Currency H - it is just test currency, used once in a while 
	AND custid NOT IN (SELECT custid FROM #Supers_Offered)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency=currency			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @currency=@currency, @max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers	

GO		


-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------

