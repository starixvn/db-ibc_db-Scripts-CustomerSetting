/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Delete data reduntdant [#221908] 
	DB: DBCust/CustDB
*/

SET NOCOUNT ON
DECLARE @__batchSize INT = 2000
	, @__redBatch INT = 50000

DROP TABLE IF EXISTS #Temp_ToDelete
CREATE TABLE #Temp_ToDelete (CustID INT)
DECLARE @Batch_Temp_ToDelete TABLE (CustID INT)
DECLARE @__custIds VARCHAR(MAX)
	, @__info VARCHAR(300)          --add param

-- Process each table sequentially

-- Table: VRCustLockStatus
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (CustID)
	SELECT DISTINCT TOP (@__redBatch) V.CustID
	FROM VRCustLockStatus V WITH (NOLOCK)
		LEFT JOIN CustInfo C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.CustID INTO @Batch_Temp_ToDelete(CustID)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @__custIds = STRING_AGG(CAST(custid AS VARCHAR(MAX)), ',')
		FROM @Batch_Temp_ToDelete

		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'VRCustLockStatus'
	END

	SET @__info = CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR(@__info, 0, 0) WITH NOWAIT;

	WAITFOR DELAY '00:00:00:100'
END