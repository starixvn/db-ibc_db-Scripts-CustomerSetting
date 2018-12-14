/*
	Created: Winnie
	Date: 20181011
	Task: Copy PT & Bet setting for Esports for new turn on/off BA
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
USE CustDB
GO

	DECLARE @maxcustid INT=xxx
	DECLARE @BALogdate DATETIME=xxx

	DECLARE @Sporttype INT = 43, @BetType INT = 1

	CREATE TABLE  #tmpCustBAActiveOn(CustID INT PRIMARY KEY)
	CREATE TABLE  #tmpCustBAActiveOFF(CustID INT PRIMARY KEY)

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN ('368Cash','Abcasino','Aoncash','e8casino','Arlocash')

	INSERT INTO #tmpCustBAActiveOn(h.CustID)
	SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] h WITH(NOLOCK) 
	WHERE h.OnDate>@BALogdate AND h.Custid<=@maxcustid AND h.Status='Running'
		AND NOT EXISTS(SELECT CustID FROM Dep_CustPTSetting_Member m WITH(NOLOCK) WHERE h.CustID=m.CustID )


	INSERT INTO #tmpCustBAActiveOFF(CustID)
	SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] WITH(NOLOCK) WHERE OffDate>@BALogdate AND Custid<=@maxcustid AND Status='Done'

	DELETE t
	FROM #tmpCustBAActiveOn t
		INNER JOIN Customer c WITH(NOLOCK) ON t.CustID=c.custid
	WHERE c.srecommend NOT IN (SELECT CustID FROM #supers)
		OR t.CustID IN(SELECT custid FROM Dep_CustPTSetting_Member)

	DELETE t
	FROM #tmpCustBAActiveOFF t
		INNER JOIN Customer c WITH(NOLOCK) ON t.CustID=c.custid
	WHERE c.srecommend NOT IN (SELECT CustID FROM #supers)	

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
			,[IsLive]
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
