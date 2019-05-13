/*
	Created: Winnie
	Date: 2019-05-13
	Task: Insert colossus settings for deposit customers RedmineID: #113299
	DB: DBCUST/CustDB
*/ 

------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT	
	,@target VARCHAR(30)
	,@maxcustid INT
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
			AND dbo.f_CheckRepTable('Dep_AgentCommRate') = 1
			AND dbo.f_CheckRepTable('Dep_CustCommRate') = 1
			)
		RETURN		
	
	CREATE TABLE #tempAgent (CustID INT PRIMARY KEY)
	CREATE TABLE #tempMem (CustID INT PRIMARY KEY)
	CREATE TABLE #tempBettype(bettype INT, Rate DECIMAL(9,8))
	DECLARE @Sporttype SMALLINT

	SELECT @Sporttype = 204

	INSERT INTO #tempBettype(bettype,Rate)
	VALUES (18001,0.1215)
	INSERT INTO #tempBettype(bettype,Rate)
	VALUES (18002,0.45)
	 
	INSERT INTO #tempAgent(CustID)
	SELECT a.Custid
	FROM dbo.custInfo a WITH(NOLOCK) 
	WHERE a.srecommend = @srecommend AND  a.custid <= @maxcustid AND a.roleid IN(2,3,4) AND Enabled = 1

	INSERT INTO #tempMem(CustID)
	SELECT a.Custid
	FROM dbo.custInfo a WITH(NOLOCK) 
	WHERE a.srecommend = @srecommend AND  a.custid <= @maxcustid AND a.roleid = 1 AND Enabled = 1
		
	INSERT INTO dbo.Dep_AgentCommRate 
			   ([CustID]
			   ,[SportType]
			   ,[BetType]
			   ,[CommRate])
	SELECT  custid,@Sporttype,bettype,Rate
	FROM #tempAgent
		CROSS APPLY #tempBettype
	
	INSERT INTO dbo.[Dep_CustCommRate]
			   ([CustId]
			   ,[Sporttype]
			   ,[Bettype]
			   ,[sdiscount]
			   ,[adiscount]
			   ,[discount]
			   ,[playerdiscount])    
	SELECT  custid,@Sporttype,bettype,Rate,Rate,Rate,0
	FROM #tempMem
		CROSS APPLY #tempBettype
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (DB06/DBTP) -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid int, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.custInfo WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE custid <= @max_custid AND site ='WKCUR'  AND currency IN (4,13,20,51))	 
	AND Enabled=1

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend
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

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT custid
FROM dbo.custInfo WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE custid <= @max_custid AND site ='WKCUR'  AND currency IN (4,13,20,51))	 
	AND Enabled=1

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
	
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-------------------------------------------------

