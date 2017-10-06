/*
	Created: Johnson
	Date: 2017-10-06
	Task: Update enable GD status for 12bet on LRF
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT		
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductSetting') = 0 RETURN
	
	DECLARE @productID  INT
	SELECT @productID = 11
	
	INSERT INTO Dep_CustProductSetting(CustID,ProductId,IsEnabled)
	SELECT ci.Custid, @ProductId, 1
	FROM dbo.CustInfo ci WITH(NOLOCK)
		LEFT JOIN dbo.Dep_CustProductSetting cs WITH(NOLOCK) ON ci.custid = cs.custid AND cs.productID = @ProductID--GoldDeluxe ID on lrf
	WHERE ci.srecommend = @srecommend 
		AND ci.username NOT LIKE '%12bet%'+'ACC%'
		AND cs.custid IS NULL
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DB06/DBTP)-----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper  WITH(NOLOCK)
WHERE site = '12bet'
	AND currency IN  (2, 3, 4, 6, 9, 12, 15,51, 61,13)


WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK	
	
	EXEC dbo.Acc_CustSetting3rd_19 @srecommend = @srecommend			
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.280'
END
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS --------
------------------------------------------------------	

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper  WITH(NOLOCK)
WHERE site = '12bet'
	AND currency IN  (2, 3, 4, 6, 9, 12, 15,51, 61,13)


WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK	
	
	EXEC dbo.Acc_CustSetting3rd_19 @srecommend = @srecommend			
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER --------
------------------------------------------------------	
