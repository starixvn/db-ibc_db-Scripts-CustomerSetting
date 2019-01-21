/*
	Created: Johnson
	Date: 2019-01-21
	Task: adjust virtual rate 
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT	
	,@max_custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustVirtualSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('ProfileVirtualSetting') = 0 RETURN	

	CREATE TABLE #tblCust (CustID INT, seqNo TINYINT, virtualXML VARCHAR(MAX), ID INT IDENTITY(1,1))	
	DECLARE @tmpCust TABLE(CustID INT, seqNo TINYINT, virtualXML VARCHAR(MAX))
		
	INSERT INTO #tblCust(custid, seqNo, virtualXML)	
	SELECT ci.custid, pvs.seqNo, p.virtualXML
	FROM custinfo ci WITH(NOLOCK)
	CROSS APPLY
	 (
				SELECT	DISTINCT seqNo
				FROM	ProfileVirtualSetting WITH (NOLOCK)
			) pvs
	CROSS APPLY (
			SELECT		
				(SELECT pvs1.profileID as '@p', 0.15 as '@v'--new value -85%
					FROM CustVirtualSetting cs WITH(NOLOCK) 
						INNER JOIN ProfileVirtualSetting pvs1 WITH(NOLOCK) ON cs.seqNo = pvs1.seqNo	
					WHERE cs.custid = ci.custid						
						AND dbo.f_GetVirtualSetting(cs.bitmapVirtual, pvs1.profileID) = 0.2 --VR = -80%
						AND pvs1.seqNo = pvs.seqNo
						FOR XML PATH ('r')
						,ROOT('root')	
				) AS virtualXML
	) p
	WHERE srecommend = @srecommend
		AND ci.custid <= @max_custid
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND virtualXML IS NOT NULL
	ORDER BY ci.custid	
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID, DELETED.seqNo, DELETED.virtualXML
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID
		
		IF @@rowcount = 0 
			BREAK;
		
		UPDATE cs
		SET cs.bitmapVirtual = bm.bitmap
		FROM	@tmpCust t
			INNER JOIN CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK) ON t.custID = cs.custID
																	AND t.seqNo = cs.seqNo
			CROSS APPLY dbo.f_GenerateVirtualSetting_inline(cs.bitmapVirtual, t.virtualXML) AS bm
		
		WAITFOR DELAY '00:00:00.1'
	END
END	
GO

-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency = 64 --UT currency
	AND ci.custid <= @max_custid
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION 
--get list supers for licensees
SELECT ci.custid
FROM Dep_CustSuper ci WITH(NOLOCK)	


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO	

-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------	

CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency = 64 --UT currency
	AND ci.custid <= @max_custid
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION 
--get list supers for licensees
SELECT ci.custid
FROM Dep_CustSuper ci WITH(NOLOCK)	


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,			
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO

-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------		
	
	
	
	
	
	
	
	
	
	
	
	