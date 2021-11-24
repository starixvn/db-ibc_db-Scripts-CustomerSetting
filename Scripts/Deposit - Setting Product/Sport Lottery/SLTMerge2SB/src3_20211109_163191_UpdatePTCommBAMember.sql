/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:Winfred
	Date:	20211116
	Task:	Update PT and Comm for BA Member IN Sports Lottery under Sportsbook - deposit RedmineID:#163191
	DB:		DBCUST/CustDB
	
	P/s : Step 1 Insert PT and Betlimit all Licensee Deposit UUS
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('dep_custsetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY
							,recommend INT
							,mrecommend INT
							,v2apositiontaking_2 SMALLMONEY
							,v2mpositiontaking_2 SMALLMONEY
							,v2mapositiontaking_2_max SMALLMONEY
							,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY,v2apositiontaking_2 SMALLMONEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT val
	FROM dbo.strSplit(@CustIDs,',')
		
	UPDATE cl WITH (ROWLOCK, UPDLOCK)  
	SET cl.recommend = ci.recommend,
		cl.mrecommend = ci.mrecommend,
		cl.v2apositiontaking_2 = csr.apositiontaking,
		cl.v2mpositiontaking_2 =cs.mpositiontaking,
		cl.v2mapositiontaking_2_max = csm.mpositiontaking
	FROM #CustList cl 
	INNER JOIN custInfo ci WITH(NOLOCK) ON cl.CustID = ci.custid
	INNER JOIN dep_CustSetting AS cs WITH (NOLOCK) on ci.CustID = cs.custid AND cs.sporttype = 2 AND cs.bettype = 2
	INNER JOIN dep_CustSetting AS csr WITH (NOLOCK) on ci.recommend = csr.custid AND csr.sporttype = 2 AND csr.bettype = 2
	INNER JOIN dep_CustSetting AS csm WITH (NOLOCK) on ci.mrecommend = csm.custid AND csm.sporttype = 2 AND csm.bettype = 2
	WHERE ci.roleid = 1
	--a1=min(a1,m3)  
	UPDATE cl WITH (ROWLOCK, UPDLOCK)  
	SET cl.v2apositiontaking_2 = CASE WHEN cl.v2apositiontaking_2>cl.v2mapositiontaking_2_max THEN cl.v2mapositiontaking_2_max ELSE cl.v2apositiontaking_2 END
	FROM #CustList cl 
	--a1=if(!im)if(m1+a1>m3,m3-m1)  
	UPDATE cl WITH (ROWLOCK, UPDLOCK)  
	SET cl.v2apositiontaking_2 = CASE WHEN cl.v2apositiontaking_2+cl.v2mpositiontaking_2>cl.v2mapositiontaking_2_max THEN cl.v2mapositiontaking_2_max-cl.v2mpositiontaking_2 ELSE cl.v2apositiontaking_2 END
	FROM #CustList cl 
	
	UPDATE cl WITH (ROWLOCK, UPDLOCK)  
	SET cl.v2apositiontaking_2 =  CASE WHEN cl.v2apositiontaking_2<0 THEN 0 ELSE cl.v2apositiontaking_2 END
	FROM #CustList cl 
	
	DECLARE @batch SMALLINT = 2500

	WHILE(1 = 1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.v2apositiontaking_2 INTO #CustListTemp(CustID,v2apositiontaking_2)
		FROM #CustList c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------PT & Comm Setting-----------------------------------------------
		UPDATE d 
		SET  
		 d.apositiontaking = c.v2apositiontaking_2,
		 d.discount = 0,
		 d.adiscount = 0,
		 d.sdiscount = 0
		FROM dep_custsetting d WITH (ROWLOCK, UPDLOCK)  
		  INNER JOIN  #CustListTemp c on d.custid = c.CustID
		WHERE d.sporttype = 2 AND d.bettype = 2
	
		TRUNCATE TABLE #CustListTemp
	END 	
	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #tmpCust(CustID)
SELECT ci.CustID
FROM custInfo ci WITH(NOLOCK)
INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.srecommend = cs.custid
INNER JOIN Dep_CustBAActive ba WITH (NOLOCK) ON ci.custid = ba.CustId
WHERE ci.custid<=@max_custid AND roleid = 1 AND ci.Enabled=1 	
		AND (cs.site NOT IN('spondemo','Athena000')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))

DECLARE @Member_cnt INT,@Member_batch INT, @index INT = 0 
SET @Member_cnt = (SELECT COUNT(*) FROM #tmpCust )
DECLARE @msg nvarchar(200) = 'Currently at order %d, Total affected: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of Member: %d.'
RAISERROR (@msg_total, 0, 1, @Member_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
    UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
	FROM #tmpCust a	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	SET @Member_batch = (SELECT COUNT(*) FROM #tmpCustTemp )
	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpCustTemp
	SET @index = @index + @Member_batch
	RAISERROR (@msg, 0, 1,@Member_batch, @Member_batch) WITH NOWAIT

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @target = 'REPLICATED' 	

	TRUNCATE TABLE #tmpCustTemp
	WAITFOR DELAY '00:00:00.280'
END	

DROP TABLE #tmpCust
DROP TABLE #tmpCustTemp
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- BEGIN STEP 1: RUN THIS SCRIPT AT DBCUST -----
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #tmpCust(CustID)
SELECT ci.CustID
FROM custInfo ci WITH(NOLOCK)
INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.srecommend = cs.custid
INNER JOIN Dep_CustBAActive ba WITH (NOLOCK) ON ci.custid = ba.CustId
WHERE ci.custid<=@max_custid AND roleid = 1 AND ci.Enabled=1
		AND (cs.site NOT IN('spondemo','Athena000')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))

DECLARE @Member_cnt INT,@Member_batch INT, @index INT = 0 
SET @Member_cnt = (SELECT COUNT(*) FROM #tmpCust )
DECLARE @msg nvarchar(200) = 'Currently at order %d, Total affected: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of Member: %d.'
RAISERROR (@msg_total, 0, 1, @Member_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
    UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
	FROM #tmpCust a	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	SET @Member_batch = (SELECT COUNT(*) FROM #tmpCustTemp )
	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpCustTemp
	SET @index = @index + @Member_batch
	RAISERROR (@msg, 0, 1,@Member_batch, @Member_batch) WITH NOWAIT

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @target = 'DBCUST' 	

	TRUNCATE TABLE #tmpCustTemp
	WAITFOR DELAY '00:00:00.280'
END	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 