/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220126@Winfred
	Task: Correct new action status of Macau [#RM:167635]
	DB: DBLOG/bodb_CustomerLog
*/

CREATE TABLE #LogTmp (logid	BIGINT, custid	INT,ActionID	INT,TrackingValue	nvarchar(MAX),TrackingValue2	nvarchar(MAX))

INSERT INTO #LogTmp (logid,custid,ActionID,TrackingValue,TrackingValue2)
SELECT logid,custid,ActionID,TrackingValue,TrackingValue2
FROM dbo.UserLog_RunSP WITH(NOLOCK)
WHERE ActionID in (60504,60505,65508,65509,65510,65511,70512,70513,70514,70515,70516,70517,75516,75517,75518,75519,75520,75521,75522,75523) 
	AND  logid BETWEEN 1039197140 AND 1045114294

-- Update real currency
DELETE a FROM #LogTmp a 
	INNER JOIN bodb02.dbo.CustInfo ci WITH (NOLOCK) ON a.custid = ci.custid
WHERE  ci.currency IN (20,72)

UPDATE lgTbl
SET lgTbl.TrackingValue = Replace(lgTbl.TrackingValue,'SportType="212"','ProductID="22"'),
	lgTbl.TrackingValue2 = Replace(lgTbl.TrackingValue2,'SportType="212"','ProductID="22"')
FROM #LogTmp lgTbl 


UPDATE lgTbl
SET lgTbl.TrackingValue = lg.TrackingValue, lgTbl.TrackingValue2 = lg.TrackingValue2 
FROM dbo.UserLog_RunSP lgTbl WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #LogTmp lg ON lg.LogID = lgTbl.logid AND lg.CustID = lgTbl.custid

	
DROP TABLE 	#LogTmp