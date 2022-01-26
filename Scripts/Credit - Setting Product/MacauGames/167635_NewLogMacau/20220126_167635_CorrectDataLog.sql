

CREATE TABLE #LogTmp (logid	BIGINT, custid	INT,ActionID	INT,TrackingValue	nvarchar(MAX),TrackingValue2	nvarchar(MAX))

INSERT INTO #LogTmp (logid,custid,ActionID,TrackingValue,TrackingValue2)
SELECT logid,custid,ActionID,TrackingValue,TrackingValue2
FROM dbo.UserLog_RunSP WITH(NOLOCK)
WHERE ActionID in (60504,60505,65508,65509,65510,65511,70512,70513,70514,70515,70516,70517,75516,75517,75518,75519,75520,75521,75522,75523) 
	AND  logdate >= '2022-01-06 23:12:08' 

UPDATE lgTbl
SET lgTbl.TrackingValue = Replace(lgTbl.TrackingValue,'SportType="212"','ProductID="22"'),
	lgTbl.TrackingValue2 = Replace(lgTbl.TrackingValue2,'SportType="212"','ProductID="22"')
FROM #LogTmp lgTbl 


UPDATE lgTbl
SET lgTbl.TrackingValue = lg.TrackingValue, lgTbl.TrackingValue2 = lg.TrackingValue2 
FROM dbo.UserLog_RunSP lgTbl WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #LogTmp lg ON lg.LogID = lgTbl.logid AND lg.CustID = lgTbl.custid

	
DROP TABLE 	#LogTmp