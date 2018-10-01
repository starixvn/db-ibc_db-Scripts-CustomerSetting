/*
	Created: Winnie
	Task: Copy Status for Esports RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20180920
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@srecommend INT			
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN

	DECLARE @Sporttype INT
	SELECT @Sporttype=43	
	DECLARE @BitOrder INT
	SELECT @BitOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	CREATE TABLE #temp (CustID INT PRIMARY KEY,DisableEsports BIT DEFAULT(1))

	INSERT INTO #temp(CustID,DisableEsports)
	SELECT ci.custid,[DisableEsports]
	FROM custInfo CI WITH (NOLOCK) 
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND ci.Enabled=1	
	
	UPDATE cs
	SET								
		 bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
		 bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,[DisableEsports])
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #temp CI WITH (NOLOCK) ON cs.CustID = ci.CustID
	---------------------------------------------------------------------------------------

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
FROM dbo.custInfo ci WITH(NOLOCK)
WHERE ci.custid NOT IN (SELECT CustID FROM Dep_CustSuper)
	AND ci.roleid=4 
	AND ci.Enabled=1

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
			
			
	waitfor delay '00:00:0.280'
END

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM dbo.custInfo ci WITH(NOLOCK)
WHERE ci.custid NOT IN (SELECT CustID FROM Dep_CustSuper)
	AND ci.roleid=4 
	AND ci.Enabled=1

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
						
	waitfor delay '00:00:0.280'
END

