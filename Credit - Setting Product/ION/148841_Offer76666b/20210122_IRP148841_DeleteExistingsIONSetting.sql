/*
	Created: 20210122@Johnson
	DB: DBCUST/CustDB
	Task: Delete existing ION Live Casino setting for 76666b,766666,7aa666
*/
CREATE TABLE #tblCust (CustID INT PRIMARY KEY, roleid TINYINT)

--17 rows affect
SELECT c.custid into #supers
FROM vw_Customer c (nolock) 
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
WHERE site IN ('76666b','766666','7aa666')
	AND c.roleid = 4
	AND c.currency =69
	AND ci.Enabled = 1

--1087 rows affect	
INSERT INTO #tblCust(custid,roleid)
SELECT custid,roleid
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)	
GO

----------------------------------------------------------
--PT
--189 rows affect
DELETE CustPTSetting3rd_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
	AND SportType = 225
GO

--733 rows affect
DELETE CustPTSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND SportType = 225
GO
----------------------------------------------------------

----------------------------------------------------------
--Commission
--189 rows affect
DELETE CustDiscount3rd_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
	AND SportType = 225
GO	

--733 rows affect	
DELETE CustDiscount3rd_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND SportType = 225
GO
----------------------------------------------------------


----------------------------------------------------------
--winlimit
--189 rows affect
DELETE CustWinLossLimit_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
	AND SportType = 225
GO	

--733 rows affect	
DELETE CustWinLossLimit_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND SportType = 225
GO
----------------------------------------------------------


----------------------------------------------------------
--stakelevel
--189 rows affect
DELETE CustStakeLevel_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
	AND SportType = 225
GO	

--733 rows affect	
DELETE CustStakeLevel_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
	AND SportType = 225
GO
----------------------------------------------------------
	
