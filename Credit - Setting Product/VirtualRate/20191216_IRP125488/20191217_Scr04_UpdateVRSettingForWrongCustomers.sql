/*
	Created: Johnson
	Date: 2019-12-17
	Task: adjust virtual rate for UT/YEN currency for credit & All licensees
	DB: DBCUST/CUSTDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@custidlist VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustVirtualSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	DECLARE @bitmapVirtual_tmp BINARY(64),
			@bitmapVirtual_tmp2 BINARY(64)
	
	INSERT INTO @tmpCust
	SELECT custid	
	FROM dbo.strSplit(@custidlist,',')
		
	UPDATE cs
	SET 
		--OU/1H OU
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,5,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 5, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,			
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,6,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 6, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 9, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,10,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 10, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,17,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 17, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,18,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 18, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,21,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 21, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,22,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 22, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,29,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 29, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,30,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 30, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,33,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 33, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,34,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 34, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,41,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 41, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,42,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 42, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,49,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 49, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,50,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 50, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,59,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 59, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,			
		@bitmapVirtual_tmp = CASE WHEN seqNo = 1 AND SUBSTRING(cs.bitmapVirtual,60,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp, 60, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp END,
		
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,3,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(bitmapVirtual, 3, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE bitmapVirtual END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,4,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 4, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 9, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,10,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 10, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,13,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 13, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,14,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 14, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,23,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 23, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,24,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 24, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,31,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 31, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,32,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 32, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,39,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 39, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,40,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 40, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,47,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 47, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,48,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 48, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,51,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 51, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
		@bitmapVirtual_tmp2 = CASE WHEN seqNo = 2 AND SUBSTRING(cs.bitmapVirtual,52,1) = CAST(10 AS BINARY(1)) THEN CONVERT(BINARY(64),STUFF(@bitmapVirtual_tmp2, 52, 1, CAST(CAST(15 AS BINARY(1)) AS VARCHAR))) ELSE @bitmapVirtual_tmp2 END,
					
		bitmapVirtual = CASE WHEN seqNo = 1 THEN @bitmapVirtual_tmp 
							WHEN seqNo = 2 THEN @bitmapVirtual_tmp2 
							ELSE bitmapVirtual END
	FROM dbo.CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK)
	WHERE ((cs.seqNo = 1
			AND (
				--OU/1H OU
				SUBSTRING(cs.bitmapVirtual,5,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,6,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,18,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,22,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,30,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,34,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,42,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,60,1) = CAST(10 AS BINARY(1))				
				)		
			)
			OR
			( cs.seqNo = 2
			AND 
				(SUBSTRING(cs.bitmapVirtual,3,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,4,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,24,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(10 AS BINARY(1))					
				OR SUBSTRING(cs.bitmapVirtual,40,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,48,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(10 AS BINARY(1))
				OR SUBSTRING(cs.bitmapVirtual,52,1) = CAST(10 AS BINARY(1))									
				)
			)
		)
		AND cs.custid IN (SELECT custid FROM @tmpCust)
			
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST.CustDB only -----
--------------------------------------------------------------------------------------
DECLARE @custidlist VARCHAR(MAX) = '',
		@cnt INT

WHILE(1=1)
BEGIN
	SET @custidlist = ''
	
	UPDATE TOP(2500) t
	SET @custidlist = @custidlist+ CAST(custid AS VARCHAR(10)) +',',
		isFinished = 1
	FROM DBSPARE.custdb_tmp2.dbo.Tmp_CustVirtual t WITH(UPDLOCK)
	WHERE isFinished = 0
	
	SELECT @cnt = @@ROWCOUNT
	
	IF @cnt = 0 
		BREAK;
		
	EXEC Acc_CustSetting3rd_19 	@custidlist = @custidlist
	
	WAITFOR DELAY '00:00:00.28'
END

---------------------------------------------------------
--END STEP 2: Run this SP at DBCUST.CustDB only -----
-------------------------------------------------------------------