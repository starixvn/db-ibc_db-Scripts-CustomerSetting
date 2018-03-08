/*
	Created: Winnie	
	Task:  Update Disable151_AU RedmineID:#86086
	DB: DBCUST/CustDB
	Date: 20180307 
*/ 
ALTER PROCEDURE [dbo].Acc_CustomerInfo_Execrep_09
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)	
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0
		RETURN	
	DECLARE @Batch TABLE (custid INT PRIMARY KEY)
	
	SELECT ci.custid 
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.custid <= @maxcustid AND ci.srecommend=@srecommend		
		AND roleid IN (2,3,4)
		AND ci.Disable151_AU=1

	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) #CustList
		OUTPUT DELETED.custid INTO @Batch

		IF @@ROWCOUNT = 0 BREAK

		UPDATE ci
		SET	Disable151_AU=0
		FROM CustInfo ci WITH (ROWLOCK,UPDLOCK) 
			INNER JOIN @Batch b ON b.custid = ci.custid
	
		DELETE FROM @Batch
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE  @srecommend INT,@max_custid INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM custInfo c WITH(NOLOCK)	
WHERE c.roleid = 4 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_CustomerInfo_Execrep_09 
		@srecommend = @srecommend
		,@maxcustid = @max_custid
		,@target = 'REPLICATED'		
	
END

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE  @srecommend INT,@max_custid INT
SELECT @max_custid = xxx


INSERT INTO #supers(custid)
SELECT c.custid
FROM custInfo c WITH(NOLOCK)
WHERE c.roleid = 4 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.Acc_CustomerInfo_Execrep_09 
		@srecommend = @srecommend
		,@maxcustid = @max_custid
		,@target = 'DBCUST'			
	
END

