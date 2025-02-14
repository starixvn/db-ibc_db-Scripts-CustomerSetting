/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250110@Virgil
	Task: Vgaming - Integrate Bettype Jackpot Contribution [RedmineID: #216274]
	DB: DBCUST/CustDB
	Description: Step 3 Delete redundant and copy new setting newly created customer Vgaming Jackpot Contribution
*/
USE CustDB
GO

DECLARE @MaxCustID INT, @ProductID TINYINT, @batch INT;
	
SELECT @MaxCustID = XXX;

SELECT @batch = 2000, @ProductID = 66

CREATE TABLE #supers (custid int)

DECLARE @SportBetType TABLE
(
	SportType  SMALLINT, 
	BetType	   SMALLINT,
	NewBetType SMALLINT
)
INSERT INTO @SportBetType(SportType, BetType, NewBetType) VALUES (171, 3801, 3898);
	
CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT,isfinished BIT DEFAULT(0))
CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT,isfinished BIT DEFAULT(0))
CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT)
CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT)
	
CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(AgentID INT,Sporttype INT,Bettype INT, PRIMARY KEY(AgentID ,Sporttype ,Bettype))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK)
		ON ci.custid = cs.custid
	INNER JOIN Dep_CustPTSetting_Agent pt WITH(NOLOCK) 
		ON ci.custid = pt.CustID 
	INNER JOIN @SportBetType sb
		ON pt.SportType = sb.SportType
		AND pt.BetType = sb.BetType
WHERE ci.Enabled = 1

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) 
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
INSERT INTO #SMATemp(CustID,RoleID,mrecommend,Currency)
SELECT custid, roleid,mrecommend,Currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) 
	AND roleid IN (2,3,4) 
	AND Enabled = 1 
	AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #MemberTemp(CustID,mrecommend,Currency)
SELECT custid, mrecommend,Currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) 
	AND roleid = 1  
	AND Enabled = 1 
	AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

--------------------//* DELETE existing data *//--------------------
	
SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Agent
FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.NewBetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

SELECT a.CustID,a.SportType,a.BetType
INTO #Dep_CustPTSetting_Member
FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.NewBetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

SELECT a.AgentID,a.SportType,a.BetType
INTO #Dep_CustPTGroupSetting_Member
FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.NewBetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid

WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
BEGIN
	DELETE TOP (@batch) #Dep_CustPTSetting_Agent 
	OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype 
	INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTSetting_Agent_Del_InHouse]([CustID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
			ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

	TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
END
	
WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
BEGIN	
	
	DELETE TOP (@batch) #Dep_CustPTSetting_Member 
	OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype 
	INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTSetting_Member_Del_InHouse]([CustID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
			ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
	OPTION(MAXDOP 1)
		
	TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
END  
	
WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
BEGIN	
	DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member 
	OUTPUT DELETED.AgentID,DELETED.Sporttype,DELETED.Bettype 
	INTO #Dep_CustPTGroupSetting_MemberTemp(AgentID,Sporttype,Bettype)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.AgentID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTGroupSetting_Member_Del_InHouse]([AgentID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
			ON cg.AgentID=t.AgentID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
			
	TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
END 	

--------------------//* INSERT New BetType data *//--------------------	
-- SMA LEVEL
WHILE(1 =1)
BEGIN
		
	UPDATE TOP (@batch) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.RoleID,DELETED.Currency 
	INTO #SMABatch(CustID,RoleID,Currency)
	FROM #SMATemp c 
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK
	-------------------------------------------------Add new PT Setting----------------------------------------------------------------
	INSERT INTO dbo.Dep_CustPTSetting_Agent
			(	[CustID]
				,[SportType]
				,[BetType]
				,[IsLive]
				,[SuperPT]
				,[MasterPT]
				,[AgentPT]
				,[RepUpdateTime]
				)
		SELECT  a.CustID
				,t.SportType
				,t.NewBetType
				,0 AS IsLive
				,CASE WHEN a.RoleID = 4 THEN 100.00 ELSE 0 END AS SuperPT
				,CASE WHEN a.RoleID IN (4,3) THEN 100.00 ELSE 0 END AS MasterPT
				,CASE WHEN a.RoleID IN (4,2) THEN 100.00 ELSE 0 END AS AgentPT
				,[dbo].[f_GetDateTime2]()
		FROM #SMABatch a WITH(NOLOCK)
			CROSS APPLY @SportBetType t

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
			(	AgentID
				,[SportType]
				,[BetType]
				,[IsLive]
				,[SuperPT]
				,[MasterPT]
				,[AgentPT]
				,[RepUpdateTime]
				)
		SELECT  a.CustID
				,t.SportType
				,t.NewBetType
				,0 AS IsLive
				,0 AS SuperPT
				,0 AS MasterPT
				,100.00 AS AgentPT
				,[dbo].[f_GetDateTime2]()
		FROM #SMABatch a WITH(NOLOCK)
				CROSS APPLY @SportBetType t	
		WHERE a.RoleID=2

	TRUNCATE TABLE #SMABatch
END			
	
-- MEMBER LEVEL
WHILE(1 =1)
BEGIN
		
	UPDATE TOP (@batch) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.Currency 
	INTO #MemberBatch(CustID,Currency)
	FROM #MemberTemp c 
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK
	-------------------------------------------------Add new PT Setting----------------------------------------------------------------
	INSERT INTO dbo.Dep_CustPTSetting_Member
	(	CustID
		,[SportType]
		,[BetType]
		,[IsLive]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[RepUpdateTime]
		)
	SELECT  a.CustID
			,t.SportType
			,t.NewBetType
			,0 AS IsLive
			,0 AS SuperPT
			,0 AS MasterPT
			,100.00 AS AgentPT
			,[dbo].[f_GetDateTime2]()
	FROM #MemberBatch a WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
		CROSS APPLY @SportBetType t
	WHERE m.IsGroupedPT = 0

	INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT, RepUpdateTime)
	SELECT t.CustID, 1, [dbo].[f_GetDateTime2]()
	FROM #MemberBatch t WITH(NOLOCK) 
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
					
	TRUNCATE TABLE #MemberBatch
END 
	
	
DROP TABLE #MemberTemp
DROP TABLE #SMATemp    
DROP TABLE #MemberBatch 
DROP TABLE #SMABatch    
DROP TABLE #Dep_CustPTSetting_AgentTemp
DROP TABLE #Dep_CustPTSetting_MemberTemp
DROP TABLE #Dep_CustPTGroupSetting_MemberTemp
DROP TABLE #supers
