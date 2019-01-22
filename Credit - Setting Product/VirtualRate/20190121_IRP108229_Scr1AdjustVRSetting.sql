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
	
	CREATE TABLE #tblCust (CustID INT, seqNo TINYINT, newBitmap BINARY(64), ID INT PRIMARY KEY IDENTITY(1,1))	
	DECLARE @tmpCust TABLE(CustID INT, seqNo TINYINT, newBitmap binary(64))
	
	INSERT INTO #tblCust(custid, seqNo, newBitmap)	
	SELECT ci.custid, cs.seqNo, (SELECT bitmap FROM dbo.f_GenerateVirtualSetting_inline(cs.bitmapVirtual, P.virtualXML)) newBitmap	
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustVirtualSetting cs WITH (NOLOCK) ON cs.custid = ci.custid 							
		CROSS APPLY (
				SELECT		
					(SELECT pvs1.profileID as '@p', 0.15 as '@v'--new value -85%
						FROM ProfileVirtualSetting pvs1 WITH(NOLOCK) 
						WHERE cs.seqNo = pvs1.seqNo													
							AND (CASE WHEN CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) > 200 THEN ((CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) - 200)*5 + 200)
									 ELSE CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) 
									 END) / 100.0 = 0.2-- VR = -80%						
							FOR XML PATH ('r')
							,ROOT('root')	
					) AS virtualXML
		) p	

	WHERE ci.srecommend = @srecommend	
		AND ci.custid <= @max_custid
		AND virtualXML IS NOT NULL
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID, DELETED.seqNo, DELETED.newBitmap
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID

		IF @@rowcount = 0 
			BREAK;
		
		UPDATE cs
		SET cs.bitmapVirtual = t.newbitmap
		FROM	@tmpCust t
			INNER JOIN CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK) ON t.custID = cs.custID
																	AND t.seqNo = cs.seqNo			
		
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;	
			
		WAITFOR DELAY '00:00:00.1'
	END
	
	DROP TABLE #tblCust
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
	
	
	
	
	
	
	
	
	
	
	
	