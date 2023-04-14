/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/20
	Task: DEPOSIT - Enhance Initial data Setting For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686]
*/

use CustDB

DECLARE @maxcustid INT = xxx

BEGIN
	SET NOCOUNT ON  

---------------------------------COLLECT DATA---------------------------------
DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @New_BetType = 7000
	,  @SportType = 248

IF OBJECT_ID('tempdb..#Dep_CustListAgent') IS NOT NULL
    DROP TABLE #Dep_CustListAgent ;  
IF OBJECT_ID('tempdb..#Dep_CustListMember') IS NOT NULL
    DROP TABLE #Dep_CustListMember ;  
IF OBJECT_ID('tempdb..#Dep_CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #Dep_CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#Dep_CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #Dep_CustStakeLevel_Member ;  

CREATE TABLE #Dep_CustListAgent (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #Dep_CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #Dep_CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
CREATE TABLE #Dep_CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))

INSERT INTO #Dep_CustListAgent(CustID)
SELECT cg.custid  
FROM dbo.Dep_CustStakeLevel_Agent cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
WHERE SportType = @Sporttype 
AND BetType = @Old_BetType
AND ci.Enabled = 1
AND ci.roleid in (2,3,4) 
AND ci.custid > @maxcustid
GROUP BY cg.custid
	
INSERT INTO #Dep_CustListMember(CustID)
SELECT cg.custid  
FROM dbo.Dep_CustStakeLevel_Member cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
WHERE SportType = @Sporttype
AND BetType = @Old_BetType
AND ci.Enabled = 1 
AND ci.roleid = 1	
AND ci.custid > @maxcustid 
GROUP BY cg.custid


DECLARE @BatchSize INT = 5000   

-----------------------------------Dep_CustStakeLevel_Agent---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #Dep_CustStakeLevel_Agent (CustID)
		FROM #Dep_CustListAgent c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cA SET BetType = @New_BetType
		FROM Dep_CustStakeLevel_Agent cA WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Dep_CustStakeLevel_Agent cust on cA.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #Dep_CustStakeLevel_Agent
	END
-------------------------------------Dep_CustStakeLevel_Member---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #Dep_CustStakeLevel_Member (CustID)
		FROM #Dep_CustListMember c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cM SET BetType = @New_BetType
		FROM Dep_CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Dep_CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #Dep_CustStakeLevel_Member
	END
END
GO
 