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
CREATE TABLE #Temp_ToDelete (LogID BIGINT)
DECLARE @Batch_Temp_ToDelete TABLE (LogID BIGINT)
DECLARE @__custIds VARCHAR(MAX)
	, @__info VARCHAR(300)          --add param

-- Process each table sequentially

-- Table: WinLimit_CustGameMonitoring_History
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #Temp_ToDelete
	INSERT INTO #Temp_ToDelete (LogID)
	SELECT DISTINCT TOP (@__redBatch) V.LogID
	FROM WinLimit_CustGameMonitoring_History V WITH (NOLOCK)
		LEFT JOIN Customer C WITH (NOLOCK) ON V.CustID = C.CustID
	WHERE C.CustID IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	WHILE 1 = 1
	BEGIN
		DELETE FROM @Batch_Temp_ToDelete
		DELETE TOP(@__batchSize) #Temp_ToDelete
		OUTPUT deleted.LogID INTO @Batch_Temp_ToDelete(LogID)

		IF @@ROWCOUNT = 0
			BREAK

		SET @__custIds = CAST((SELECT LogID		as '@c'
						FROM @Batch_Temp_ToDelete
						FOR XML PATH('r'), ROOT('root')
						) AS VARCHAR(MAX))


		EXEC dbo.[Acc_DynamicCustSetting3rd_16] 
			@CustIdList = @__custIds,
			@TableName = 'WinLimit_CustGameMonitoring_History'
	END

	SET @__info = CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR(@__info, 0, 0) WITH NOWAIT;

	WAITFOR DELAY '00:00:00:100'
END