/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230316@Tacy
	Task: 01. Update Saba's Status - Exists Customers
		 https://nexdev.net/issues/185168 [RedmineID: #185168]
	Database: DBCUST/CustDB
*/
USE CustDB
GO
-- BEGIN STEP 1: DEPLOY THIS SP --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	 @Custid INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
		AND dbo.f_CheckRepTable('CustProductStatus') = 1
		)
	RETURN
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)

	DECLARE @xmlStrHidden XML, @bitmapOrder TINYINT

	SET @bitmapOrder=21
	
	SET @xmlStrHidden = (
				SELECT DISTINCT
					@bitmapOrder AS '@b', 
					1 AS '@s'
				FOR XML PATH ('r'), ROOT ('root')
				)

	INSERT INTO #CustList(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.custid <= @maxcustid
	
	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustList WHERE isfinished = 0)
	BEGIN
		UPDATE TOP (@batch) #CustList 
		SET isfinished = 1
		OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
		WHERE isfinished = 0

		IF @@ROWCOUNT=0
			BREAK		
			
		UPDATE cs
		SET	bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrHidden))),
			bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrHidden))),
			bitmapHasSynced = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapHasSynced, CONVERT(VARCHAR(MAX),@xmlStrHidden)))
		FROM [dbo].CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustListTemp b ON cs.CustID = b.CustID 

		TRUNCATE TABLE #CustListTemp
	END
	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- END STEP 1: DEPLOY THIS SP --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @target VARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid <= @max_custid
		
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 
			 @custid = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	waitfor delay '00:00:0.100'
END
GO