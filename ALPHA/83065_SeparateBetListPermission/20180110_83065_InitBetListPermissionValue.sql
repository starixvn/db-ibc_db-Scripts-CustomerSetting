/*
	Created: 20180110@Vicky
	Task: Initiate Bet List permission value for sub account
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
AS
BEGIN
	IF dbo.f_CheckRepTable('custSub') = 0 RETURN
	DECLARE @var_max_custsub_id INT
	
	CREATE TABLE #Selected (subaccid INTEGER PRIMARY KEY)
	CREATE TABLE #Batch (subaccid INTEGER PRIMARY KEY)

	INSERT #Selected (subaccid)
	SELECT subaccid
	FROM dbo.custSub WITH (NOLOCK)
	WHERE (PageAccess LIKE '%[E]%' OR PageAccess LIKE '%[D]%') AND (PageAccess NOT LIKE '%[L]%')

	SET @var_max_custsub_id = (SELECT TOP 1 subaccid FROM #Selected ORDER BY subaccid DESC)
	
	WHILE 1 = 1
	BEGIN

		DELETE TOP (5000) #Selected
		OUTPUT DELETED.subaccid INTO #Batch

		IF @@ROWCOUNT = 0 BREAK

		UPDATE dbo.custSub WITH (ROWLOCK)
		SET PageAccess = PageAccess + '[L]'
		WHERE subaccid IN (SELECT b.subaccid FROM #Batch AS b)

		WAITFOR DELAY '00:00:00.100'
		
		TRUNCATE TABLE #Batch
	END
	
	-- check if there is any sub account is created in update processing, update again --------
	UPDATE dbo.custSub WITH (ROWLOCK)
	SET PageAccess = PageAccess + '[L]'
	WHERE   subaccid > @var_max_custsub_id AND
		 	(PageAccess LIKE '%[E]%' OR PageAccess LIKE '%[D]%')
END
GO

-- STEP 1: DEPLOY THIS SP ON @DBCUST.CustDB --------

-- STEP 2: RUN THIS SCRIPT AT DBCUST --------
EXEC dbo.Acc_CustomerInfo_Execrep_09
