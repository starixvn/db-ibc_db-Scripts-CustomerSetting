/*
	Created: Johnson
	Date: 2018-06-19
	Task: insert PP settings for newly created customers for licensees
	DB: DBCUST/CUSTDB
*/
DECLARE @max_custid INT = xxx,--old max_custid
		@max_custid2 INT = zzz--get new max_custid 

--pt setting on sma dummy
SELECT custid 
INTO #supers
FROM dbo.Dep_CustSuper WITH(NOLOCK) 
WHERE site IN ('ISC888')
					
CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT, currency INT, mrecommend INT)
DECLARE @bitmapOrder INT = 8,--PP
		@StakeLevelID VARCHAR(10)

INSERT INTO #tblCust (custid,roleid,currency,mrecommend)			
SELECT custid,roleid,currency,mrecommend
FROM dbo.Customer WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND custid > @max_custid
	AND custid <= @max_custid2

DELETE #tblCust 
WHERE mrecommend IN (SELECT custid 
					FROM dbo.custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #supers) 
						AND username like '%Acc%' 
						AND roleid=3)

--Delete Dep_LicenseeProductSetting
DELETE Dep_LicenseeProductSetting WITH(UPDLOCK,ROWLOCK)
WHERE ProductSettingID IN (21,22,23)--PP 
	AND custid IN (SELECT custid FROM #tblCust WHERE roleid = 4)

INSERT INTO Dep_LicenseeProductSetting (CustID,ProductSettingID)	
SELECT c.custID,ps.ProductSettingID
FROM #tblCust c
	CROSS APPLY dbo.Dep_ProductSetting ps WITH (NOLOCK)
WHERE productid = 32
	AND roleid = 4
	
--PT setting on SMA dummy
DELETE dbo.Dep_CustPTSetting_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
	AND sporttype = 248

INSERT INTO [dbo].[Dep_CustPTSetting_Agent]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT])
SELECT t.custid,
	s.SportType,
	s.Bettype,
	s.IsLive,
	s.SuperPT,
	s.MasterPT,
	s.AgentPT
FROM #tblCust t
	INNER JOIN (SELECT 4 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 92 SuperPT, 92 MasterPT, 92 AgentPT
				UNION SELECT 3 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 0 SuperPT, 92 MasterPT, 0 AgentPT
				UNION SELECT 2 roleid, 248 as SportType, 4101 as Bettype, 0 isLive, 0 SuperPT, 0 MasterPT, 92 AgentPT
				) s ON t.roleid = s.roleid

--pt group on members ??? check current group if not have member downline
DELETE dbo.Dep_CustPTGroupSetting_Member WITH(UPDLOCK,ROWLOCK)
WHERE AgentID IN (SELECT custid FROM #tblCust WHERE roleid =2)
	AND sporttype = 248

INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
		   ([AgentID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT])
SELECT t.custid,
	248 SportType,
	4101 Bettype,
	0 IsLive,
	0 SuperPT,
	0 MasterPT,
	92 AgentPT
FROM #tblCust t
WHERE roleid = 2	
---------------------------------------------------------------------

--enable status 
UPDATE dbo.Dep_CustProductStatus WITH(UPDLOCK,ROWLOCK)
SET bitmapIsHidden = dbo.f_GenerateProductStatus(bitmapIsHidden,@bitmapOrder,0),
	bitmapIsDisabled = dbo.f_GenerateProductStatus(bitmapIsDisabled,@bitmapOrder,0)
WHERE custID IN (SELECT custid FROM #tblCust)
---------------------------------------------------------------------

--stakelevel on sma dummy
DELETE dbo.Dep_CustStakeLevel_Agent WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
	AND sporttype = 248

INSERT INTO [dbo].[Dep_CustStakeLevel_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
SELECT custID, 248 as sporttype, 4101 as BetType, StakeLevelID
FROM #tblCust t
	INNER JOIN dbo.Dep_StakeLevel s WITH(NOLOCK) ON t.currency = s.ExchangeID
WHERE roleid IN (2,3,4)	
	AND GameTypeID = 4101
	
--stakelevel on member level
DELETE dbo.Dep_CustStakeLevel_Member WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid =1)
	AND sporttype = 248

INSERT INTO [dbo].[Dep_CustStakeLevel_Member]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[StakeLevelList]
	   ,[LastUpdated])
SELECT custID, 248 as sporttype, 4101 as BetType, StakeLevelID, GetDate()	   
FROM #tblCust t
	INNER JOIN dbo.Dep_StakeLevel s WITH(NOLOCK) ON t.currency = s.ExchangeID
WHERE roleid = 1
	AND GameTypeID = 4101
	

