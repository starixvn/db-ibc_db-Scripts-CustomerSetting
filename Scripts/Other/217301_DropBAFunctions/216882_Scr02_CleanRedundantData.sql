/*<info serverAlias="DBCUST-CustDB" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250307@Virgil
	Task: BA Admin & LAP - Drop BA functions [Redmine #216882]
	DB: DBCUST-CustDB
	Note: Step 2 - Clean redundant data
*/
USE [CustDB]
GO

DECLARE @batchUpdate INT = 2000;

CREATE TABLE #tblCustSettingMode (CustID INT)
CREATE TABLE #tmpCustSettingMode (CustID INT PRIMARY KEY)

CREATE TABLE #tmpListCust (CustID INT)

CREATE TABLE #tblCustPTSetting_Member ([CustID] INT, [SportType] SMALLINT, [BetType] SMALLINT, [IsLive] BIT)
CREATE TABLE #tmpCustPTSetting_Member (CustID INT PRIMARY KEY, [SportType] SMALLINT, [BetType] SMALLINT, [IsLive] BIT)

INSERT INTO #tblCustSettingMode (CustID)
SELECT CustID
FROM Dep_CustSettingMode WITH (NOLOCK)
WHERE IsGroupedPT = 0

WHILE(1=1)
BEGIN
	TRUNCATE TABLE #tmpCustSettingMode
				
	DELETE TOP (@batchUpdate) t
	OUTPUT DELETED.custid 
	INTO #tmpCustSettingMode
	FROM #tblCustSettingMode t
				
	IF @@rowcount = 0 
		BREAK;
					
	UPDATE cs
	SET	cs.IsGroupedPT = 1,
		RepUpdateTime = dbo.f_GetDateTime2()
	OUTPUT DELETED.custid
	INTO #tmpListCust(CustID)
	FROM dbo.Dep_CustSettingMode cs WITH (ROWLOCK, UPDLOCK)
	WHERE CustID IN (SELECT CustID FROM #tmpCustSettingMode)
END	

INSERT INTO #tblCustPTSetting_Member ([CustID], [SportType], [BetType], [IsLive])
SELECT [CustID], [SportType], [BetType], [IsLive]
FROM [dbo].[Dep_CustPTSetting_Member] WITH (NOLOCK)
WHERE CustID IN (SELECT CustID FROM #tmpListCust)

WHILE(1=1)
BEGIN
	TRUNCATE TABLE #tmpCustPTSetting_Member
				
	DELETE TOP (@batchUpdate) t
	OUTPUT DELETED.CustID, DELETED.SportType, DELETED.Bettype, DELETED.IsLive
	INTO #tmpCustPTSetting_Member
	FROM #tblCustPTSetting_Member t
				
	IF @@rowcount = 0 
		BREAK;
					
	DELETE [dbo].[Dep_CustPTSetting_Member] WITH(ROWLOCK) 
	OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive, dbo.f_GetDateTime2()
	INTO [dbo].[Dep_CustPTSetting_Member_Del_InHouse](CustID,SportType,Bettype,IsLive,RepUpdateTime)
	WHERE CustID IN (SELECT CustID FROM #tmpCustPTSetting_Member)
END	


DROP TABLE #tblCustSettingMode;
DROP TABLE #tmpCustSettingMode;
DROP TABLE #tmpListCust;
DROP TABLE #tblCustPTSetting_Member;
DROP TABLE #tmpCustPTSetting_Member;