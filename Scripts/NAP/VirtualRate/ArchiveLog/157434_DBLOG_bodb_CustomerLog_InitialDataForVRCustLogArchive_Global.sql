/*
	Created: 20210714@Elodie	
	Task: initial data to archive log of new table log
	DB: DBLOG/bodb_CustomerLog_Archive
*/
USE bodb_CustomerLog_Archive
GO

INSERT INTO VRCustLog (LogId, SportType, CustID, ActionID, TrackingValue1, TrackingValue2, UserID, LogTime, Duration, IP)
SELECT LogId, SportType, vr.CustID, ActionID, TrackingValue1, TrackingValue2, UserID, LogTime, Duration, IP
FROM bodb_CustomerLog.dbo.VRCustLog vr WITH (NOLOCK)
WHERE vr.custid = 0
	AND LogTime < '2021-06-21'

