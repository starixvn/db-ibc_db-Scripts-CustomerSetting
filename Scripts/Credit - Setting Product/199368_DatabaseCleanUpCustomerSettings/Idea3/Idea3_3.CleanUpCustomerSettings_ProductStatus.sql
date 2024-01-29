/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240110@Helios
	Task: Collect Data To Temp Table [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
	-- RUN AT ALL REPLICATED SERVERS & DBCUST --
*/

------------------------------------------------------	
-- BEGIN: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
----------------------------------------------------------------------------------------------
PRINT N'Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE	@max_custid		INT,
		@JsonData		VARCHAR(MAX),
		@BatchSize		INT = 3000,
		@ReadBatchSize	INT = 100000

SELECT @max_custid = 'xxxx'
	
CREATE TABLE #tblCust
	(
		  CustID		INT
	)

CREATE TABLE #tblCust_batch	
	(
		  CustID		INT
	)


DECLARE @__messageInfo VARCHAR(200), @__tableName VARCHAR(200)


BEGIN

	---- CustProductStatus : Remark = 13
	SET @__tableName = 'CustProductStatus'
	WHILE 1 = 1
	BEGIN
		INSERT INTO #tblCust (custid)
		SELECT TOP(@ReadBatchSize) cs.CustID
		FROM CustProductStatus cs WITH (NOLOCK) 
			INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cs.CustID = tcucs.CustID
		WHERE cs.custid <= @max_custid

		IF @@ROWCOUNT = 0
			BREAK

		--loop delete by batch
		WHILE 1 = 1
		BEGIN
			
			TRUNCATE TABLE #tblCust_batch

			DELETE TOP (@BatchSize) #tblCust
			OUTPUT deleted.CustID
			INTO #tblCust_batch (CustID)

			IF @@ROWCOUNT = 0 
				BREAK

			SELECT @JsonData=(	  SELECT	CustID
							  FROM	#tblCust_batch
							  FOR JSON PATH
							 )
	
			EXEC dbo.Acc_DynamicCustomerInfo_09 @__tableName = @__tableName
				, @JsonData = @JsonData
				, @target = @target
			

		END

		WAITFOR DELAY '00:00:00:280'
		SET @__messageInfo = 'tb: ' + CAST(@__tableName AS VARCHAR(200)) +  ' - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
		RAISERROR (@__messageInfo, 0, 1) WITH NOWAIT
	END


	DROP TABLE #tblCust
	DROP TABLE #tblCust_batch

END