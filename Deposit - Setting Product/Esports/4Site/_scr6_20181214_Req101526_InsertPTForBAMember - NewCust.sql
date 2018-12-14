/*
	Created: Winnie
	Date: 20181011
	Task: Copy PT & Bet setting for Esports BA new cust
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
USE CustDB
GO

	DECLARE @maxcustid INT=xxx
	
	DECLARE @Sporttype INT = 43, @BetType INT = 1


	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN ('368Cash','Abcasino','Aoncash','e8casino','Arlocash')

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
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	WHERE BA.CustId>@maxcustid
		AND c.srecommend IN (SELECT CustID FROM #supers)

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
	FROM Dep_CustBAActive BA WITH(NOLOCK)
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
		INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
	WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType AND BA.CustId>@maxcustid
		AND c.srecommend IN (SELECT CustID FROM #supers)
	
	UPDATE m
		SET m.IsGroupedPT=0
	FROM Dep_CustSettingMode m WITH(NOLOCK)
		INNER JOIN Dep_CustBAActive ba WITH(NOLOCK) ON m.CustID=ba.CustId
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	WHERE BA.CustId>@maxcustid AND c.srecommend IN (SELECT CustID FROM #supers)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT ba.CustId,0
	FROM Dep_CustBAActive ba WITH(NOLOCK)
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	WHERE c.srecommend IN (SELECT CustID FROM #supers)
		AND NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
		AND ba.CustId>@maxcustid 

	