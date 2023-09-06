/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230906
	Task: [BBIN] - Disable Bitcoin [Redmine: #193658]
	DB: DBCust/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]    
		@custlist	NVARCHAR(MAX)
        ,@target	VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only

    IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
 
	CREATE TABLE #AllUser(CustID int PRIMARY KEY, bitmapIsDisabled BINARY(32))

	INSERT INTO #AllUser(CustID, bitmapIsDisabled)
	SELECT custid, bitmapIsDisabled
	FROM OPENJSON(@custlist) WITH (
		custid INT  '$.custid',
		bitmapIsDisabled BINARY(32) '$.bitmapIsDisabled'
	)

	UPDATE c 
	SET  c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK)
		INNER JOIN #AllUser tmp ON c.CustID = tmp.CustID

	DROP TABLE #AllUser
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------        
--------------------------------------------------------------------------------------
-- BEGIN STEP 2: Run this script at DBCUST & all replicated servers----- -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE
        @target			NVARCHAR(20),
		@srecommend		INT,
		@custList		NVARCHAR(MAX),
		@max_custid		INT,
		@sporttype		SMALLINT = 175,
		@bettype		SMALLINT = 7901,
		@bitMapOrder	TINYINT	

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
        SET @target = 'DBCUST'
ELSE 
        SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

SELECT @max_custid = xxx

SELECT @bitMapOrder = bitmapOrder
FROM Dep_ProductStatusProfile WITH (NOLOCK)
WHERE Sporttype = @SportType AND Bettype = @BetType

CREATE TABLE #supers(custid int PRIMARY KEY, isfinished BIT default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK)         
        INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
        INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
        CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitMapOrder) f            
WHERE ci.username NOT LIKE '3rdSuper%'        
        AND ci.Enabled = 1
        AND cs.site = 'Haifa'
		AND f.value = 0
		AND ci.custid <= @max_custid

CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

INSERT INTO #Dummy(CustID)
SELECT c.CustID FROM Customer c WITH (NOLOCK)        
        INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
WHERE c.roleid = 3 
		AND c.custid <= @max_custid
        AND (c.username LIKE '%Acc%' OR c.username LIKE '%LocalBank%' OR c.username LIKE '%AFF%' OR c.username LIKE 'AB88'+'CAS%')

CREATE TABLE #AllAffectedCust(custid INT PRIMARY KEY, bitmapIsDisabled BINARY(32))

CREATE TABLE #BatchAffectedCust(custid INT PRIMARY KEY, bitmapIsDisabled BINARY(32))

DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(1) FROM #supers )

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1=1)
BEGIN
	UPDATE TOP (1) s
	SET s.isfinished = 1,
		@srecommend = s.custid
	FROM #supers s 
	WHERE s.isfinished = 0

	IF @@ROWCOUNT = 0
		BREAK

	INSERT INTO #AllAffectedCust(custid, bitmapIsDisabled)
	SELECT ci.custid, dbo.f_GenerateProductStatus(s.bitmapIsDisabled, @bitMapOrder, 1) as bitmapIsDisabled
	FROM custinfo ci WITH (NOLOCK)
		INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
		CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitMapOrder) f 
	WHERE ci.Enabled = 1 
		AND ci.srecommend = @srecommend
		AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy WITH (NOLOCK))
		AND f.value = 0
		AND ci.custid <= @max_custid

	WHILE (1 = 1)
	BEGIN

		TRUNCATE TABLE #BatchAffectedCust

		DELETE TOP (5000) t 
		OUTPUT DELETED.custid, DELETED.bitmapIsDisabled
		INTO #BatchAffectedCust(custid, bitmapIsDisabled)
		FROM #AllAffectedCust t

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @custList =
					(
						SELECT custid , bitmapIsDisabled 
						FROM #BatchAffectedCust with(NOLOCK)
						FOR JSON PATH
					)
                
		EXEC  dbo.[Acc_DynamicCustSetting3rd_09] 
								@custlist = @custList
								,@target = @target
	END	

	WAITFOR DELAY '00:00:0.050'  
	SET @index +=1
	RAISERROR(@msg, 0, 1, @index, @srecommend) WITH NOWAIT
END

DROP TABLE #supers, #AllAffectedCust, #BatchAffectedCust, #Dummy
GO	

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
-- END STEP 2: Run this script at DBCUST & all replicated servers-----
----------------------------------------------------------------------