/*
	Created: 20200303@Elodie	
	Task: initial data to archive log of new table log
	DB: DBLOG/bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

DECLARE @__archiveDate DATETIME, @MinLogId BIGINT, @NextLogId BIGINT,  @MaxLogId BIGINT, @Batch INT = 1000
SELECT @__archiveDate = DATEADD(DAY, 1, bodb_CustomerLog.dbo.f_CustomerLog_GetArchiveDate())
DECLARE @msg NVARCHAR(200) = 'Currently at batch %d'

SELECT @MinLogId = MIN(LogId) FROM bodb_CustomerLog.dbo.VRCustLog WITH (NOLOCK)
SELECT @MaxLogId = MAX(LogId) FROM bodb_CustomerLog.dbo.VRCustLog WITH (NOLOCK) WHERE LogTime < @__archiveDate

DECLARE @i INT = 1

WHILE (@MinLogID <= @MaxLogId) --AND @i < 50
BEGIN
	SELECT @NextLogId = @MinLogId + @Batch

	INSERT INTO VRCustLog (LogId, SportType, CustID, ActionID, TrackingValue1, TrackingValue2, UserID, LogTime, Duration, IP)
	SELECT LogId, SportType, CustID, ActionID, TrackingValue1, TrackingValue2, UserID, LogTime, Duration, IP
	FROM bodb_CustomerLog.dbo.VRCustLog WITH (NOLOCK)
	WHERE LogId >= @MinLogId AND LogId < @NextLogId
		AND LogTime < @__archiveDate

	SELECT @MinLogId = @NextLogId
	RAISERROR (@msg, 0, 1, @i) WITH NOWAIT
	SELECT @i = @i + 1
END

