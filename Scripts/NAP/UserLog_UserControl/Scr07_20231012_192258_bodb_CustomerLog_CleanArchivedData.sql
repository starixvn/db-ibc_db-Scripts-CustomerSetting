/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Tacy@20231012
	Task: Archive table UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DECLARE @MaxLogId BIGINT, @Batch INT = 5000, @TotalBatch INT

SELECT @MaxLogId = xxx

--GET: TotalBatch
SELECT @TotalBatch = CAST(COUNT(1)/@Batch AS INT) + CASE WHEN COUNT(1)%@Batch <> 0 THEN 1 ELSE 0 END --MOD
FROM UserLog_UserControl WITH (ROWLOCK)
WHERE LogId <= @MaxLogId  

DECLARE @msg NVARCHAR(200) = 'Currently at batch %d' + '/' + CAST(@TotalBatch AS varchar)

DECLARE @i INT = 1

WHILE (1=1)
BEGIN
	DELETE TOP (@Batch) ul
	FROM UserLog_UserControl ul WITH (ROWLOCK)
	WHERE LogId <= @MaxLogId 

	IF @@ROWCOUNT=0
		BREAK

	RAISERROR (@msg, 0, 1, @i) WITH NOWAIT
	
	SELECT @i = @i + 1

	WAITFOR DELAY '00:00:00:50'
END
GO