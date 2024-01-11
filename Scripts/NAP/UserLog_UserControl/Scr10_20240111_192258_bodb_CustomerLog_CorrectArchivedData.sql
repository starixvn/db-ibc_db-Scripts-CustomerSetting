/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Tacy@20240111
	Task: Archive table UserLog_UserControl - Correct archived data
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DECLARE @FromDateTime DATETIME, @NextDateTime DATETIME,
	@ToDateTime DATETIME = CAST(DATEADD(DAY, 1, dbo.f_CustomerLog_GetArchiveDate()) AS DATE),
	@Mode VARCHAR(20),
	@ErrorCode INT = 0,
	@CNT INT

SELECT @FromDateTime=CAST(MIN(LogDate) AS DATE)
FROM UserLog_UserControl ul WITH (NOLOCK)
WHERE logdate < @ToDateTime

SELECT @FromDateTime FromDateTime, @ToDateTime ToDateTime

SELECT @NextDateTime = DATEADD(DAY, 1, @FromDateTime)

WHILE (@NextDateTime<=@ToDateTime)
BEGIN
	PRINT 'FromDateTime: ' + CONVERT(VARCHAR,@FromDateTime,121)
	PRINT 'NextDateTime: ' + CONVERT(VARCHAR,@NextDateTime,121)

	--COPY
	EXEC [dbo].[Task_Archive_CustomerLog_UserLog_UserControl]
		@FromDateTime =@FromDateTime,
		@ToDateTime=@NextDateTime,
		@Mode='copy',
		@RowInBatch=2000,
		@ErrorCode = @ErrorCode OUTPUT

	IF @ErrorCode <>0 RETURN

	--DELETE
	EXEC [dbo].[Task_Archive_CustomerLog_UserLog_UserControl]
		@FromDateTime =@FromDateTime,
		@ToDateTime=@NextDateTime,
		@Mode='delete',
		@RowInBatch=2000,
		@ErrorCode = @ErrorCode OUTPUT

	IF @ErrorCode <>0 RETURN

	SELECT @FromDateTime=@NextDateTime
	SELECT @NextDateTime = DATEADD(DAY, 1, @FromDateTime)
END
GO