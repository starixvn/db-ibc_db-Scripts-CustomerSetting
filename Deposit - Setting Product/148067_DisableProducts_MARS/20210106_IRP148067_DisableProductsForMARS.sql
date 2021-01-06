/*
	Created: 20210106@Johnson
	Task: Disable RNG Keno, Lottery, Table Game, Virtual Games, Arcadia status for MARSSuperRMB
	RedmineID: #148067			
*/ 

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@custids VARCHAR(MAX)				
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	
	CREATE TABLE #MemberTemp			(CustID INT PRIMARY KEY CLUSTERED)
	
	INSERT INTO #MemberTemp(custid)
	SELECT val	
	FROM dbo.strSplit(@custids,',')
	
	--Update keno status 
	UPDATE g 
	SET isdisabled = 1
	FROM dbo.CustGameType g WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM #MemberTemp)
		AND GameTypeID = 1
	
	DECLARE @xmlStrDisabled XML
	
	SET @xmlStrDisabled = (
				SELECT (
						SELECT bitmapOrder	AS '@b'
							, 1	AS '@s'
						FROM (SELECT 6 as bitmapOrder --Lottery
						UNION SELECT 9  --Arcadia
						UNION SELECT 11 --Virtual Games
						UNION SELECT 16 --Table Game
						)t
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)
				
	UPDATE cs
	SET	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrDisabled)))	
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	WHERE custid IN (SELECT custid FROM #MemberTemp)
	
	DROP TABLE #MemberTemp	
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #tblMembers			(CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT 0)
CREATE TABLE #Dummy					(CustID INT PRIMARY KEY CLUSTERED)
	
DECLARE @max_custid INT, 
		@custids VARCHAR(MAX),
		@srecommend INT = 31607887 --MARSSuperRMB

SELECT @max_custid = xxx --input maxcustid here

-- get dummy member
INSERT INTO #Dummy(CustID)
SELECT CustID 
FROM Custinfo WITH(NOLOCK) 
WHERE srecommend=@srecommend 
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

INSERT INTO #tblMembers (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend = @srecommend 
	AND roleid = 1  
	AND custid <= @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

WHILE (1 = 1)
BEGIN
	SET @custids = ''
	
	UPDATE TOP (5000) #tblMembers
	SET isfinished = 1
		,@custids = @custids+ ',' + CAST(custid AS VARCHAR(10))
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @custids = STUFF(@custids,1,1,'')
		
	EXEC dbo.Acc_DynamicCustomerInfo_09 @custids = @custids			
			,@target = 'REPLICATED'			
END
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #tblMembers			(CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT 0)
CREATE TABLE #Dummy					(CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #SMATemp				(CustID INT PRIMARY KEY CLUSTERED)
	
DECLARE @max_custid INT, 
		@custids VARCHAR(MAX),
		@srecommend INT = 31607887 --MARSSuperRMB

SELECT @max_custid = xxx --input maxcustid here

-- get dummy member
INSERT INTO #Dummy(CustID)
SELECT CustID 
FROM Custinfo WITH(NOLOCK) 
WHERE srecommend=@srecommend 
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

INSERT INTO #SMATemp (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend = @srecommend 
	AND roleid IN (2,3,4) 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
INSERT INTO #tblMembers (CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend = @srecommend 
	AND roleid = 1  
	AND custid <= @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

--update SMA status
--Update keno status 
UPDATE g 
SET isdisabled = 1
FROM dbo.CustGameType g WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #SMATemp)
	AND GameTypeID = 1

--DCS products
DECLARE @xmlStrDisabled XML
	
SET @xmlStrDisabled = (
			SELECT (
					SELECT bitmapOrder	AS '@b'
						, 1	AS '@s'
					FROM (SELECT 6 as bitmapOrder --Lottery
						UNION SELECT 9  --Arcadia
						UNION SELECT 11 --Virtual Games
						UNION SELECT 16 --Table Game
					)t
					FOR XML PATH('r')
						, TYPE
					)
			FOR XML PATH('root')
				, TYPE
			)
		
UPDATE cs
SET	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrDisabled)))	
FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
WHERE custid IN (SELECT custid FROM #SMATemp)
	
WHILE (1 = 1)
BEGIN
	SET @custids = ''
	
	UPDATE TOP (5000) #tblMembers
	SET isfinished = 1
		,@custids = @custids+ ',' + CAST(custid AS VARCHAR(10))
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @custids = STUFF(@custids,1,1,'')
		
	EXEC dbo.Acc_DynamicCustomerInfo_09 @custids = @custids			
			,@target = 'DBCUST'			
END
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB-----
--------------------------------------------------------------------------------------

