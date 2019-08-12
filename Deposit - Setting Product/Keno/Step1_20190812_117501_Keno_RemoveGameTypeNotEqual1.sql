/*
	Created: 20190807@Winnie
	Task : Keno Remove GameTypeID <> 1. RedmineID:#117501
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@max_custid INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN	

	--------------------------------------------------------------
		CREATE TABLE #MemberTemp
	(
		CustID		INT PRIMARY KEY CLUSTERED		
	)

		CREATE TABLE #MemberTempBatch
	(
		CustID		INT PRIMARY KEY CLUSTERED	
	)

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN(1,2,3,4)  AND custid <= @max_custid
	
	WHILE EXISTS(SELECT 1 FROM #MemberTemp)
	BEGIN
		DELETE TOP (150) #MemberTemp OUTPUT DELETED.* INTO #MemberTempBatch

		IF @@ROWCOUNT=0
			BREAK		

		DELETE g
		FROM CustGameType g WITH(ROWLOCK)
			INNER JOIN #MemberTempBatch t ON g.CustID=t.CustID
		WHERE g.GameTypeID <>1

		TRUNCATE TABLE #MemberTempBatch
	END	

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))
DECLARE @max_custid INT,@srecommend INT
SELECT @max_custid = xxx						

INSERT INTO #Super(custid)
SELECT DISTINCT ds.custid
FROM custgametype cs (nolock)
	INNER JOIN Dep_CustSuper ds (nolock) on cs.custid = ds.custid
WHERE ds.CustID<= @max_custid

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #super )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'REPLICATED'
	
	waitfor delay '00:00:0.280'
END			
GO	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	

		
CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))
DECLARE @max_custid INT	,@srecommend INT						
SELECT @max_custid = xxx

INSERT INTO #Super(custid)
SELECT DISTINCT ds.custid
FROM custgametype cs (nolock)
	INNER JOIN Dep_CustSuper ds (nolock) on cs.custid = ds.custid
WHERE ds.CustID<= @max_custid	

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #super )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Super
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend	
			,@max_custid = @max_custid
			,@target = 'DBCUST'
	
	waitfor delay '00:00:0.280'
END			
GO	
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------	