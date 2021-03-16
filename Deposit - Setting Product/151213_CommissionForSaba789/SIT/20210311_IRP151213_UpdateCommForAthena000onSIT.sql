/*
	Created: 20210311@Johnson
	Task: update dcs comm settings for athena000 
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

--6k rows affected
UPDATE cs
SET playerdiscount = 0
FROM Dep_CustSetting3rd cs WITH (UPDLOCK,ROWLOCK)
WHERE custid in (select custid from #tblcust)	
	AND playerdiscount <> 0
	
	