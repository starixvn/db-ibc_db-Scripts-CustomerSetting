/*
	Created: Johnson
	Date: 2017-10-18
	Task: Insert missing data goldDeluxe for licensee [Redmine:#84476]
	DB: DBCUST/CUSTDB
*/
--step 1: Deploy this sp on DBCUST/CustDB
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT		
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_SupperProductSetting') = 0 RETURN
		
	DECLARE @ProductId INT 
	SET @ProductID = 11--GoldDeluxe
	
	SELECT custid
	INTO #tmpMaster
	FROM dbo.customer with(NOLOCK)
	WHERE srecommend = @srecommend
		AND roleid = 3
		AND username like '%ACC%'	
	
	IF NOT EXISTS (SELECT TOP 1 1 
					FROM dbo.Dep_SupperProductSetting WITH(NOLOCK) 
					WHERE custid = @srecommend
						AND productID = @productID
				)
	BEGIN			
		INSERT INTO Dep_SupperProductSetting(CustID,ProductId,IsEnabled)
		SELECT @srecommend, @productID, 1
	END
	
	INSERT INTO Dep_CustProductSetting(CustID,ProductId,IsEnabled)
	SELECT ci.Custid, @ProductId, 1
	FROM dbo.Customer ci WITH(NOLOCK)
		LEFT JOIN dbo.Dep_CustProductSetting cs WITH(NOLOCK) ON ci.custid = cs.custid AND cs.productID = 11
	WHERE ci.mrecommend NOT IN (SELECT custid FROM #tmpMaster)
		and username NOT LIKE '%cashout%'
		AND cs.custid IS NULL
		AND ci.roleid = 1
		and srecommend = @srecommend
	
	DROP TABLE #tmpMaster
END	
GO
--- END STEP 1:DEPLOY THIS SP @DBCUST.CustDB --------	
-------------------------------------------------------------------------------------

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

--supers list
INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('9bet','ABB688','Allbetclub','Aoncash','BE7','Bolanation','GooBet','HonorW','Indowin','ITCBet','Lexibet','M8bola','Macaubet','NBCbet','Q8bola','sbcbet','spondemo','Taipanbet','Unobet','Webet138')
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid					
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'REPLICATED'			
	
	waitfor delay '00:00:0.280'
END			
GO		
 
 -- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
-----------------------------------------------------------------------------------
 
 
 
---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

--supers list
INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)
WHERE site IN ('9bet','ABB688','Allbetclub','Aoncash','BE7','Bolanation','GooBet','HonorW','Indowin','ITCBet','Lexibet','M8bola','Macaubet','NBCbet','Q8bola','sbcbet','spondemo','Taipanbet','Unobet','Webet138')
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid					
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'DBCUST'			
	
	waitfor delay '00:00:0.280'
END			
GO	
 -- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
-----------------------------------------------------------------------------------
 