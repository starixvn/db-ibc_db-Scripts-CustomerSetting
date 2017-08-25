/*
	Created: Winnie
	Date: 2017-08-24
	Task: Insert colossus settings for deposit customers
	DB: DBCUST/CustDB
*/ 

------------------------------------------------------

ALTER PROCEDURE [dbo].Acc_CustomerInfo_Execrep_09
	@srecommend INT	
	,@target VARCHAR(30)
	,@maxcustid INT
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 			
			)
		RETURN		
	CREATE TABLE #temp (CustID INT PRIMARY KEY)

	INSERT INTO #temp(CustID)
	SELECT CustID FROM dbo.custInfo WITH(NOLOCK)		
	WHERE srecommend=@srecommend AND Enabled=1

	UPDATE c
	SET DisableColossusBet=0,HideColossusBet=0
	FROM	dbo.custInfo c WITH(ROWLOCK,UPDLOCK)	
	INNER JOIN #temp t ON c.custid=t.CustID	
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DB06/DBTP/DB05x) -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid int, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid= xxx

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.custInfo WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE custid <= @max_custid	
	AND site in ('Leon','Sungame') )	 
	AND Enabled=1
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.Acc_CustomerInfo_Execrep_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
	
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DB06/DBTP) -----
-----------------------------------------------------------------------------------

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
-------------------------------------------------
CREATE TABLE #supers (custid int, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid= xxx

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.custInfo WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE custid <= @max_custid	
	AND site in ('Leon','Sungame') )	 
	AND Enabled=1

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.Acc_CustomerInfo_Execrep_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
	
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-------------------------------------------------

