/*
	Created: 20200303@Elodie	
	Task: initial data to archive log of new table log
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

DECLARE @__archiveDate DATETIME, @MinLogId BIGINT, @MaxLogId BIGINT, @Batch INT = 1000
SELECT @__archiveDate = DATEADD(DAY, 1, dbo.f_CustomerLog_GetArchiveDate())
DECLARE @msg NVARCHAR(200) = 'Currently at batch %d'

SELECT @MinLogId = MIN(LogId) FROM bodb_CustomerLog_Archive.dbo.VRCustLog WITH (NOLOCK)

DECLARE @i INT = 1

WHILE (1=1) --AND @i < 50
BEGIN
	SELECT @MaxLogId = @MinLogId + @Batch

	DELETE l
	FROM dbo.VRCustLog l WITH (NOLOCK)
	WHERE LogId >= @MinLogId AND LogId < @MaxLogId
		AND LogTime < @__archiveDate

	IF @@ROWCOUNT = 0
		BREAK

	SELECT @MinLogId = @MaxLogId
	RAISERROR (@msg, 0, 1, @i) WITH NOWAIT
	SELECT @i = @i + 1
END

