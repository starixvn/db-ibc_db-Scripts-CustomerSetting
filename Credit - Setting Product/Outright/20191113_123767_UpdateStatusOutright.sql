/*
	Created: 20191113@Winnie
	Task : Update status Outright RedmineID:#123676
	DB:  DBCUST/CustDB
*/
 
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_19]
	 @target		VARCHAR(20)	
	,@srecommend	INT
	,@maxCustID		INT
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN

	CREATE TABLE #tempCust(CustID INT PRIMARY KEY)
	CREATE TABLE #tempCustBatch(CustID INT PRIMARY KEY)

	INSERT INTO #tempCust(CustID)
	SELECT c.custid FROM Custinfo c WITH(ROWLOCK,UPDLOCK)
	WHERE srecommend = @srecommend	AND custid<=@maxCustID AND c.roleid IN(2,3,4) AND DisableOutright = 1
	WHILE EXISTS (SELECT 1 FROM #tempCust )
	BEGIN
	
		DELETE TOP (3000) #tempCust OUTPUT DELETED.* INTO #tempCustBatch
		
		IF @@ROWCOUNT=0
			BREAK		

		UPDATE TOP(3000) c
		SET DisableOutright = 0
		FROM Custinfo c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tempCustBatch t ON c.custid=t.CustID

		TRUNCATE TABLE #tempCustBatch
	END

END

GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx


INSERT INTO #Super(custid)
SELECT c.custid 
FROM dbo.customer c WITH (Nolock) 
WHERE c.username IN('SDGB','SDGD','SDGH','SDGI','SDGJ','SDGM','SDGR','SDGU','SDGV','SDGW',
'SDGY','SDP3','SDP4','SDP6','SDP7','SDP8','SDP9','SDPA','SDPB','SDPC','SDPD',
'SDPQ','SDPR','SDPS','SDPT','SJK9','TV0','TV42','TV46','TV4A','TV4B','TV4U',
'TV50','TV74','TV7D','TV7U','TV8F','TV8G','TV8H','TV8I','TV8J','TVA2U','TVA47',
'TVA5','TVA58','TVA82','TVA8A','TVA8H','TVA8Z','TVA92','TVA93','TVA98','TVBA','TVG2',
'TVS2','TVSR','TVST','TVSU','TVSV','TVSX','TVUD','TVUJ','TVUS','TVUU','TVUV',
'TVV7','TVVD','TVVM','TVVX','TVW2','TVW8','TVWK','TVWN','TVWP','TVWS','TVWU',
'TVWV','XTV1N','XTV1U','XTV1V','XTV1W','XTV1X','XTV27','XTV2A','XTV2B','XTV34','XTV37','XTV38','XTV40','XTV42')
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #super )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.[Acc_CustomerInfo_Execrep_19] @srecommend = @srecommend				
			,@target = 'REPLICATED'
			,@maxCustID=@max_custid
	waitfor delay '00:00:0.280'
END			
GO	
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @srecommend INT,
		@max_custid INT

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT c.custid 
FROM dbo.customer c WITH (Nolock) 
WHERE c.username IN('SDGB','SDGD','SDGH','SDGI','SDGJ','SDGM','SDGR','SDGU','SDGV','SDGW',
'SDGY','SDP3','SDP4','SDP6','SDP7','SDP8','SDP9','SDPA','SDPB','SDPC','SDPD',
'SDPQ','SDPR','SDPS','SDPT','SJK9','TV0','TV42','TV46','TV4A','TV4B','TV4U',
'TV50','TV74','TV7D','TV7U','TV8F','TV8G','TV8H','TV8I','TV8J','TVA2U','TVA47',
'TVA5','TVA58','TVA82','TVA8A','TVA8H','TVA8Z','TVA92','TVA93','TVA98','TVBA','TVG2',
'TVS2','TVSR','TVST','TVSU','TVSV','TVSX','TVUD','TVUJ','TVUS','TVUU','TVUV',
'TVV7','TVVD','TVVM','TVVX','TVW2','TVW8','TVWK','TVWN','TVWP','TVWS','TVWU',
'TVWV','XTV1N','XTV1U','XTV1V','XTV1W','XTV1X','XTV27','XTV2A','XTV2B','XTV34','XTV37','XTV38','XTV40','XTV42')
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #super )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.[Acc_CustomerInfo_Execrep_19] @srecommend = @srecommend	
			,@maxCustID = @max_custid
			,@target = 'DBCUST'	
	waitfor delay '00:00:0.280'
END			
GO	
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
