/*
	Created: Winnie
	Task: Copy Status for CardClub RedmineID: #115322
	DB: DBCUST/CustDB
	Date: 20190626
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT			
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN

	DECLARE @Sporttype INT
	SELECT @Sporttype=165	
	DECLARE @BitOrder INT
	SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	CREATE TABLE #temp (CustID INT PRIMARY KEY)
	CREATE TABLE #tempUpdate (CustID INT PRIMARY KEY)

	INSERT INTO #temp(CustID)
	SELECT ci.custid
	FROM custInfo CI WITH (NOLOCK) 
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND ci.Enabled=1	
	
	WHILE EXISTS(SELECT 1 FROM #temp)
	BEGIN
		DELETE TOP (3000) #temp OUTPUT DELETED.* INTO #tempUpdate

		IF @@ROWCOUNT=0
			BREAK		
		UPDATE cs
		SET								
			 bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			 bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,0)
		FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tempUpdate CI WITH (NOLOCK) ON cs.CustID = ci.CustID

		TRUNCATE TABLE #tempUpdate
	END
	---------------------------------------------------------------------------------------
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=26)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,26
	END
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('11bet','12Bet','368Cash','3star88','88Macao','9bet','9Club','9wickets','Ae88','AG','Aoncash','Arlocash','asiabet88','Athena000','Avia','BE7','Bolanation','Boma365','Brown888','Debet','DEWA','Fabet',
					'FB88','GamingSoft','Happy1668','Heaven','Hengcai88','HONBET','Hong88','HonorW','iBET','IONclub','ISC888','ITCbet','Kraton','Kudatogel','Liga','Lucky88','Luckywin88','M8bola','Macaubet','Mayfair',
					'NBCbet','Newhonbet','OLE777','One88','Q8bola','Salon365','Senibet','Sin88','spondemo',
					'Taipanbet','TLC','UN168','Unobet','Uwoniwin','Vwin','WeBet168','webet88','XTD3','Zbet','Zzun88')
			AND ci.currency=20
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_DynamicCustomerInfo_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('11bet','12Bet','368Cash','3star88','88Macao','9bet','9Club','9wickets','Ae88','AG','Aoncash','Arlocash','asiabet88','Athena000','Avia','BE7','Bolanation','Boma365','Brown888','Debet','DEWA','Fabet',
					'FB88','GamingSoft','Happy1668','Heaven','Hengcai88','HONBET','Hong88','HonorW','iBET','IONclub','ISC888','ITCbet','Kraton','Kudatogel','Liga','Lucky88','Luckywin88','M8bola','Macaubet','Mayfair',
					'NBCbet','Newhonbet','OLE777','One88','Q8bola','Salon365','Senibet','Sin88','spondemo',
					'Taipanbet','TLC','UN168','Unobet','Uwoniwin','Vwin','WeBet168','webet88','XTD3','Zbet','Zzun88')
			AND ci.currency=20
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.Acc_DynamicCustomerInfo_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

