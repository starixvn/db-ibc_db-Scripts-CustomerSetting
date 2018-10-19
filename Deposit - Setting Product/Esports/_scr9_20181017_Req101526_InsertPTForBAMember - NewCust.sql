/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------


DECLARE @Sporttype INT = 43, @BetType INT = 1
DECLARE @maxcustid INT=xxx
DECLARE @BALogdate DATETIME=xxx
CREATE TABLE  #tmpCustBAActiveOn(CustID INT PRIMARY KEY)
CREATE TABLE  #tmpCustBAActiveOFF(CustID INT PRIMARY KEY)

INSERT INTO #tmpCustBAActiveOn(h.CustID)
SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] h WITH(NOLOCK) 
WHERE h.OnDate>@BALogdate AND h.Custid<=@maxcustid AND h.Status='Running'
	AND NOT EXISTS(SELECT CustID FROM Dep_CustPTSetting_Member m WITH(NOLOCK) WHERE h.CustID=m.CustID )


INSERT INTO #tmpCustBAActiveOFF(CustID)
SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] WITH(NOLOCK) WHERE OffDate>@BALogdate AND Custid<=@maxcustid AND Status='Done'

-- for new BA
INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,@Sporttype
        ,@BetType
        ,0
        ,0
        ,0
        ,0
FROM Dep_CustBAActive BA WITH(NOLOCK)
	WHERE BA.CustId>@maxcustid

INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,SportType
        ,BetType
        ,0
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
FROM Dep_CustBAActive BA WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType AND BA.CustId>@maxcustid

UPDATE m
	SET m.IsGroupedPT=0
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN Dep_CustBAActive ba WITH(NOLOCK) ON m.CustID=ba.CustId
WHERE BA.CustId>@maxcustid

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
SELECT ba.CustId,0
FROM Dep_CustBAActive ba WITH(NOLOCK)
WHERE NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
	AND ba.CustId>@maxcustid
-- new on BA
INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,@Sporttype
        ,@BetType
        ,0
        ,0
        ,0
        ,0
FROM #tmpCustBAActiveOn BA 

INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,SportType
        ,BetType
        ,0
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
FROM #tmpCustBAActiveOn BA WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType 

UPDATE m
	SET m.IsGroupedPT=0
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN #tmpCustBAActiveOn ba WITH(NOLOCK) ON m.CustID=ba.CustId

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
SELECT ba.CustId,0
FROM #tmpCustBAActiveOn ba WITH(NOLOCK)
WHERE NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
	
-- new off BA

UPDATE m
	SET m.IsGroupedPT=1
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN #tmpCustBAActiveOFF ba WITH(NOLOCK) ON m.CustID=ba.CustId

DELETE FROM [Dep_CustPTSetting_Member]
WHERE CustID IN(SELECT CustID FROM #tmpCustBAActiveOFF)


DROP TABLE #tmpCustBAActiveOFF
DROP TABLE #tmpCustBAActiveOn