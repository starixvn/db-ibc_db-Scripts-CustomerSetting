/*
	Created: 20200618@Elodie
	Task: Change MaxPT = 100 [redmine:#136081]
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_09
	@Target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN	

	DECLARE @Batch INT = 5000
	CREATE TABLE #CustList (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT)
	CREATE TABLE #CustListBatch (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, IsLive BIT)

	INSERT INTO #CustList (CustId, Sporttype, Bettype, IsLive)
	SELECT CustId, Sporttype, Bettype, IsLive
	FROM CustPTSetting3rd_Agent WITH (NOLOCK)
	WHERE MaxPT <> 100

	WHILE (1=1)
	BEGIN
		DELETE TOP (@Batch) FROM #CustList OUTPUT deleted.CustId, deleted.Sporttype, deleted.Bettype, deleted.IsLive INTO #CustListBatch (CustID, Sporttype, bettype, islive)		
	
		IF @@ROWCOUNT = 0 BREAK

		UPDATE cs 
		SET MaxPT = 100
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN #CustListBatch c ON c.Custid = cs.custid AND c.sporttype = cs.sporttype AND c.bettype = cs.bettype AND c.islive = cs.islive

		DELETE FROM #CustListBatch
	END
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'
	
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'