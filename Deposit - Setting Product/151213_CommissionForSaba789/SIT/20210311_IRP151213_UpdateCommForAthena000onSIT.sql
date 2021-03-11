/*
	Created: 20210311@Johnson
	Task: update dcs comm settings for athena000 on SIT
	DB: DBCUST/CustDB
*/

SELECT custid
INTO #tblCust
FROM custinfo WITH(NOLOCK)
WHERE srecommend = 10063437--Athena000SuperUUS


DELETE Dep_CustDiscountSetting_Member WITH(UPDLOCK,ROWLOCK)
WHERE CustID IN (SELECT custid FROM #tblCust)


UPDATE Dep_CustSettingMode WITH(UPDLOCK,ROWLOCK)
SET IsGroupedComm = 1
WHERE CustID IN (SELECT custid FROM #tblCust)
