 /*
	Created: Eden
	Date: 2019/10/14
	Task: Update MaxPT for all dummy acc
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
AS
BEGIN
	SET NOCOUNT ON
		
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	
	
	CREATE TABLE #tmp (custID INT)
	CREATE TABLE #tmpBatch (Custid INT)
	DECLARE @Batch INT = 4000

	INSERT INTO #tmp (custID) 	
	SELECT DISTINCT cs.custid
	FROM dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK)
	WHERE sporttype IN (43)
		AND MaxPT < 85

	WHILE (1=1)
	BEGIN
		DELETE TOP (@Batch) t
		OUTPUT deleted.custid INTO #tmpBatch
		FROM #tmp t

		UPDATE cs
		SET cs.MaxPT = 85		
		FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN #tmpBatch t ON t.custID = cs.CustID
		WHERE sporttype IN (43)

		IF @@ROWCOUNT = 0
			BREAK

		TRUNCATE TABLE #tmpBatch

		WAITFOR DELAY '00:00:0.100'
	END
END    
GO

--Run on DBCUST
EXEC Acc_CustSetting3rd_19