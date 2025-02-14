/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250110@Virgil
	Task: Vgaming - Integrate Bettype Jackpot Contribution [RedmineID: #216274]
	DB: DBCUST-CustDB
	Description: Step 1 - Delete existing data Vgaming for all currency
*/

DECLARE @sportType SMALLINT,
		@BetType SMALLINT,
		@ProductId TINYINT;

SELECT @sportType = 171 , @BetType = 3898, @ProductId = 66

CREATE TABLE #supers (custid INT)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) 
		ON ci.custid = cs.custid
	INNER JOIN Dep_CustPTSetting_Agent pt WITH(NOLOCK) 
		ON ci.custid = pt.CustID 
		AND SportType = @sportType 
		AND BetType = @BetType
WHERE ci.Enabled = 1


CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))

CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))

INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
SELECT s.Custid,SportType,BetType,IsLive 
FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
	INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	INNER JOIN #supers su ON c.srecommend = su.custid
WHERE SportType =@sportType AND BetType = @BetType

INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
SELECT s.CustID,Sporttype,Bettype,IsLive 
FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
	INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	INNER JOIN #supers su ON c.srecommend = su.custid
WHERE SportType =@sportType AND BetType = @BetType

INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
SELECT AgentID,SportType,BetType,IsLive 
FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
	INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	INNER JOIN #supers su ON c.srecommend = su.custid
WHERE SportType =@sportType AND BetType = @BetType 

DECLARE @batch int = 2000
	
---- /* Dep_CustPTSetting_Agent */ ----
WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
BEGIN
	DELETE TOP (@batch) #Dep_CustPTSetting_Agent 
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive 
	INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype,IsLive)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive , [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTSetting_Agent_Del_InHouse] ([CustID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
			ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive

	TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
END
	
---- /* Dep_CustPTSetting_Member */ ----
WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
BEGIN	
	
	DELETE TOP (@batch) #Dep_CustPTSetting_Member 
	OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive 
	INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTSetting_Member_Del_InHouse]([CustID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTSetting_MemberTemp t 
			ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
	OPTION(MAXDOP 1)
		
	TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
END  
	
---- /* Dep_CustPTGroupSetting_Member */ ----
WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
BEGIN	
	DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member 
	OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive 
	INTO #Dep_CustPTGroupSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

	IF @@ROWCOUNT=0
		BREAK		

	DELETE cg
	OUTPUT DELETED.AgentID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, [dbo].[f_GetDateTime2]()
	INTO [dbo].[Dep_CustPTGroupSetting_Member_Del_InHouse]([AgentID], [SportType], [BetType], [IsLive], [RepUpdateTime])
	FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
			ON cg.AgentID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
			
	TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
END 		

	
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Member
DROP TABLE #Dep_CustPTGroupSetting_Member
