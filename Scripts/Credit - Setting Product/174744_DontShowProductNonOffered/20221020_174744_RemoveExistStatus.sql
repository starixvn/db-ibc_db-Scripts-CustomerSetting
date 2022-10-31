/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Update value Status [#RM:174744]
	DB: DBCUST/CustDB 
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@maxcustid INT
	,@bitmapOrder VARCHAR(100)
	,@isRNGKeno INT
	,@ProductID VARCHAR(100)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
		AND dbo.f_CheckRepTable('CustProductStatus') = 1
		AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
		AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
		)
	RETURN
	
	CREATE TABLE #bitmapOrder (bitmap INT)
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)

	INSERT INTO #bitmapOrder(bitmap)
	SELECT value AS bitmap
	FROM STRING_SPLIT(@bitmapOrder,',')
	WHERE value <> ''
	
	DECLARE @xmlStrHidden XML
	
	SET @xmlStrHidden = (
				SELECT DISTINCT
					bitmap AS '@b', 
					1 AS '@s'
				FROM #bitmapOrder vh 
				FOR XML PATH ('r'), ROOT ('root')
				)

	INSERT INTO #CustList(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.Enabled = 1
		AND ci.custid <= @maxcustid
	
	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustList WHERE isfinished = 0)
	BEGIN
		UPDATE TOP (@batch) #CustList 
		SET isfinished = 1
		OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
		WHERE isfinished = 0

		IF @@ROWCOUNT=0
			BREAK		
		
		IF @isRNGKeno = 1
		BEGIN
			--Update keno status 
			UPDATE g 
			SET HideKeno = 1
			FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustListTemp b ON g.CustID = b.CustID 
		END
		
		UPDATE cs
		SET	bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrHidden)))
		FROM [dbo].CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustListTemp b ON cs.CustID = b.CustID 

		TRUNCATE TABLE #CustListTemp
	END
	
	DROP TABLE #bitmapOrder	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, site VARCHAR(10), currency TINYINT,isfinished BIT DEFAULT(0))
CREATE TABLE #TempSite(site nvarchar(50),	currency nvarchar(50),	bitmapOrder	varchar(100),	ProductID	varchar(100), isRNGKeno	INT)

INSERT INTO #TempSite(site , currency ,	bitmapOrder , ProductID , isRNGKeno )
		  SELECT '222223' AS site, 2 AS currency ,'25,4,8'  AS bitmapOrder                                 ,'23,24,46'  AS ProductID                                                , 0   AS isRNGKeno
UNION ALL SELECT '222223'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '222223'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '611111'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '611111'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '611111'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT '611111'    , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '722222'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '722222'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '722222'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '722222'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '733333'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '733333'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '755555'    , 43 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '76666B'    , 69 ,'21,24,25,29,34,4,8'                                                    ,'23,24,42,46,47,51,66'                                                  , 0  
UNION ALL SELECT '789y'      , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '789y'      , 3  ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 6  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '789y'      , 16 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 35 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 64 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '7aa666'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT '7aa666'    , 69 ,'24,25,29,4,8'                                                          ,'23,24,46,47,51'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 3  ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 9  ,'21,22,24,25,27,29,30,31,33,34,37,38,4,8'                               ,'23,24,42,45,46,47,51,52,57,59,6,65,66,70'                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 10 ,'21,25,4,8'                                                             ,'23,24,42,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'BEST-ODDS' , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 16 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 22 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 33 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 34 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 35 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 41 ,'20,21,22,24,25,27,29,30,31,33,34,37,38,4,8'                            ,'23,24,39,42,45,46,47,51,52,57,59,6,65,66,70'                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,4,6,8'     ,'21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'    , 1  
UNION ALL SELECT 'BEST-ODDS' , 43 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'IBCIndo'   , 22 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 33 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 34 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IMBC'      , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'indo'      , 15 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 22 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 33 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 34 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 47 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'KORIBC'    , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'XYZBET'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'XYZBET'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'XYZBET'    , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'XYZBET'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  


DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @max_custid INT, @srecommend INT , @currency TINYINT , @site VARCHAR(10), @bitmapOrder varchar(100), @ProductID varchar(100), @isRNGKeno INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid, site,currency)
SELECT ci.custid, ci.site,ci.currency
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND (  ( ci.Site IN ('222223') AND ci.currency IN (2,5,67))
			OR ( ci.Site IN ('611111') AND ci.currency IN (13,2,42,5))
			OR ( ci.Site IN ('722222') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('733333') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('755555') AND ci.currency IN (43))
			OR ( ci.Site IN ('76666B') AND ci.currency IN (69))
			OR ( ci.Site IN ('789y') AND ci.currency IN (16,2,3,35,6,64))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2,69))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (10,12,13,15,16,2,22,3,33,34,35,41,42,43,45,5,6,9))
			OR ( ci.Site IN ('IBCIndo') AND ci.currency IN (22,33,34))
			OR ( ci.Site IN ('IMBC') AND ci.currency IN (13))
			OR ( ci.Site IN ('indo') AND ci.currency IN (15,22,33,34,47))
			OR ( ci.Site IN ('KORIBC') AND ci.currency IN (45))
			OR ( ci.Site IN ('XYZBET') AND ci.currency IN (12,13,15,2,5,6)))
		
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency = currency 
		,@site  = site
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SELECT 
		@bitmapOrder = bitmapOrder,
		@isRNGKeno  = isRNGKeno	  ,
		@ProductID	= ProductID
	FROM #TempSite 
	WHERE Site = @site AND currency = @currency

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@maxcustid = @max_custid
			,@bitmapOrder = @bitmapOrder
			,@isRNGKeno = @isRNGKeno
			,@ProductID = @ProductID
			,@target = @target
			
	waitfor delay '00:00:0.100'
END

DROP TABLE #TempSite

GO