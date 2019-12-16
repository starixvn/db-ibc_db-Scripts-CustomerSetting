/*
	Created: Johnson
	Date: 2019-07-29
	Task: adjust virtual rate for UT/YEN currency for credit & All licensees
	DB: DBCUST/CUSTDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

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
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	DECLARE @bitmapVirtual_tmp BINARY(64),
			@bitmapVirtual_tmp2 BINARY(64)
	
	SELECT custid
	INTO #tblCust
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
	
	WHILE (1 =1)
	BEGIN
		DELETE @tmpCust
		
		DELETE TOP (2500) t
		OUTPUT DELETED.custid
		INTO @tmpCust 
		FROM #tblCust t
		
		IF @@rowcount = 0 
			BREAK;		

		UPDATE cs
		SET 
			--LIVE HDP/1H HDP Soccer -80% to -85% 
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,2,1) = CAST(20 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 2, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 8, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
			
			--Non live FT HDP & 1H HDP Soccer -85% to -88% 
		bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
								WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
								ELSE bitmapVirtual END
		FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
		WHERE ((cs.seqNo = 1
				AND (
					--LIVE HDP/1H HDP Soccer
					SUBSTRING(cs.bitmapVirtual,2,1) = CAST(20 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,8,1) = CAST(20 AS BINARY(1))
					)
				))
			AND cs.custid IN (SELECT custid FROM @tmpCust)	
	
		WAITFOR DELAY '00:00:00.1'
	END	
	
	DROP TABLE #tblCust			