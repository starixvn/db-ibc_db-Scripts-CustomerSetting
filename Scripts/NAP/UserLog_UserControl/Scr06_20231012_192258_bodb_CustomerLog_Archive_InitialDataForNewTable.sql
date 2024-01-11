/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20231012
	Task: Archive table UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

DECLARE @__archiveDate DATETIME, @__archiveDate3y DATETIME, @MinLogId BIGINT, @NextLogId BIGINT,  @MaxLogId BIGINT, @Batch INT = 5000, @TotalBatch INT

SELECT @__archiveDate = DATEADD(DAY, 1, bodb_CustomerLog.dbo.f_CustomerLog_GetArchiveDate())

SELECT @__archiveDate3y  = DATEADD(YEAR, -3, @__archiveDate)

SELECT @MinLogId = MIN(LogId) FROM bodb_CustomerLog.dbo.UserLog_UserControl WITH (NOLOCK) WHERE LogDate >= @__archiveDate3y AND LogDate < @__archiveDate
SELECT @MaxLogId = MAX(LogId) FROM bodb_CustomerLog.dbo.UserLog_UserControl WITH (NOLOCK) WHERE LogDate < @__archiveDate

--output MinLogId, MaxLogID
SELECT @MinLogId AS MinLogId, @MaxLogId AS MaxLogId

--GET: TotalBatch
SET @TotalBatch = CAST((@MaxLogId - @MinLogId + 1)/@Batch AS INT) + CASE WHEN (@MaxLogId - @MinLogId + 1)%@Batch <> 0 THEN 1 ELSE 0 END --MOD

DECLARE @msg NVARCHAR(200) = 'Currently at batch %d' + '/' + CAST(@TotalBatch AS varchar)

DECLARE @i INT = 1

WHILE (@MinLogID <= @MaxLogId)
BEGIN
	SELECT @NextLogId = @MinLogId + @Batch

	INSERT INTO UserLog_UserControl ([LogID], [CustID], [LogDate], [UserID], [TypeID], [ActionID], [Duration], [Doing])
	SELECT [LogID], [CustID], [LogDate], [UserID], [TypeID], [ActionID], [Duration], [Doing]
	FROM bodb_CustomerLog.dbo.UserLog_UserControl ul WITH (NOLOCK)
	WHERE LogId >= @MinLogId
		AND LogId < @NextLogId
		AND ul.LogDate < @__archiveDate

	SELECT @MinLogId = @NextLogId
	
	RAISERROR (@msg, 0, 1, @i) WITH NOWAIT
	
	SELECT @i = @i + 1
	
	WAITFOR DELAY '00:00:00:50'
END
GO