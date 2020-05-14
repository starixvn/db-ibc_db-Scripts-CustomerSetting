/*
	Created: Tiara
	Task: Update Danger2 = 27 for provided list [Redmine: #134161]
	DB: DBCUST/CustDB
	Date: 20200514
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_19]
	@custidlist VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	INSERT INTO @tmpCust
	SELECT val as custid	
	FROM dbo.strSplit(@custidlist,',')
		
	UPDATE C 
	SET danger2 = 27
	FROM Custinfo c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN @tmpCust t ON t.custid = c.custid
			
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST.CustDB only -----
--------------------------------------------------------------------------------------
DECLARE @custidlist VARCHAR(MAX) = '',
		@cnt INT

SELECT c.custid, 0 AS isfinished
INTO #Users
FROM custInfo C  WITH (NOLOCK)
WHERE C.username IN ('TP0121111', 'TP0121111100', 'TP0121111110', 'TP0121111111', 'TP0121114', 'TP0121114200', 'TP0127201', 'TP0127201000', 'TP0127201001', 'TP0127201002', 'TP0127201003', 'TP0127201004', 'TP0127201005', 'TP021Z801', 'TP021Z801000', 'TP022AW11001', 'TP0230541000', 'TP0280000', 'TP0280000111', 'TP0280100000', 'TP0280533', 'TP0280533123', 'TP0280533600', 'TP0280533888', 'TP0281011', 'TP0281011100', 'TP0281100', 'TP0281100000', 'TP0281100001', 'TP0281100002', 'TP0281100003', 'TP0281100004', 'TP0281100500', 'TP0281111', 'TP0281111111', 'TP0281111122', 'TP0281111900', 'TP04301A8', 'TP04301A8010', 'TP04301A8888', 'TP04301CA', 'TP04301CA077', 'TP04301CA123', 'TP04301CA661', 'TP0472110', 'TP0472110522', 'TP0472110A00', 'TP059W011', 'TP059W011000', 'TP059W157', 'TP059W157100', 'TP059W277', 'TP059W277070', 'TP059W370', 'TP059W370510', 'TP0670203888', 'TP0960318188', 'TP0960318PPP', 'TP09603FF000', 'TP0991122', 'TP0991122333', 'TP1331002', 'TP1331002000', 'TP1333300', 'TP1333300000', 'TP1333300111', 'TP1333300FFF', 'TP1610701', 'TP1610701001', 'TP1610701002')
WHILE(1=1)
BEGIN
	SET @custidlist = ''
	
	UPDATE TOP(2500) t
	SET @custidlist = @custidlist+ CAST(custid AS VARCHAR(10)) +',',
		isFinished = 1
	FROM #Users t 
	WHERE isFinished = 0
	
	SELECT @cnt = @@ROWCOUNT
	
	EXEC Acc_CustomerInfo_Execrep_19 @custidlist = @custidlist

	IF @cnt < 2500 
		BREAK
	
	WAITFOR DELAY '00:00:00.28'
END

---------------------------------------------------------
--END STEP 2: Run this SP at DBCUST.CustDB only -----
-------------------------------------------------------------------
