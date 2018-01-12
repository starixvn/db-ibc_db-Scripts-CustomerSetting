/*
	Created: 20180110@Vicky
	Task: Initiate Bet List permission value for sub account
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
AS
BEGIN
	IF dbo.f_CheckRepTable('custSub') = 0 RETURN
	
	CREATE TABLE #Selected (subaccid INTEGER PRIMARY KEY)
	CREATE TABLE #Batch (subaccid INTEGER PRIMARY KEY)

	INSERT #Selected (subaccid)
	SELECT subaccid
	FROM dbo.custSub WITH (NOLOCK)
	WHERE PageAccess LIKE '%[E]%' OR PageAccess LIKE '%[D]%'

	WHILE 1 = 1
	BEGIN

		DELETE TOP (5000) #Selected
		OUTPUT DELETED.subaccid INTO #Batch

		IF @@ROWCOUNT = 0 BREAK

		UPDATE dbo.custSub WITH (ROWLOCK)
		SET PageAccess = PageAccess + '[L]'
		WHERE subaccid IN (SELECT b.subaccid FROM #Batch AS b)

		TRUNCATE TABLE #Batch
	END
END


