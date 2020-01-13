/*
	Created: Harris
	Task: Update Dangerous for robot members
	DB: DBCUST/CustDB
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
	SET danger2 = 3
	FROM Custinfo c WITH (ROWLOCK)
		INNER JOIN @tmpCust t ON t.custid = c.custid
			
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST.CustDB only -----
--------------------------------------------------------------------------------------
DECLARE @custidlist VARCHAR(MAX) = '',
		@cnt INT

SELECT r.custid custid, 0 AS isfinished
INTO #Robots 
FROM DBONUSER.ON_user.dbo.Robotusers r  WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = r.custid
WHERE ci.srecommend IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK) WHERE currency <>20)
	AND ci.currency IN (13 -- RMB
						, 66 -- YUN
						)
	AND danger2 = 0
	AND roleid = 1


WHILE(1=1)
BEGIN
	SET @custidlist = ''
	
	UPDATE TOP(2500) t
	SET @custidlist = @custidlist+ CAST(custid AS VARCHAR(10)) +',',
		isFinished = 1
	FROM #Robots t 
	WHERE isFinished = 0
	
	SELECT @cnt = @@ROWCOUNT
	
	IF @@ROWCOUNT < 2500 
		BREAK
		
	EXEC Acc_CustomerInfo_Execrep_19 @custidlist = @custidlist
	
	WAITFOR DELAY '00:00:00.28'
END

---------------------------------------------------------
--END STEP 2: Run this SP at DBCUST.CustDB only -----
-------------------------------------------------------------------