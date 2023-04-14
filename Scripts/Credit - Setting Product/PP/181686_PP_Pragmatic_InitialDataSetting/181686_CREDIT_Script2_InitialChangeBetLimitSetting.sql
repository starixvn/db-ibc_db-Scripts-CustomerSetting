/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/17
	Task: CREDIT - Enhance Initial data Setting For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686]
*/

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

IF OBJECT_ID('tempdb..#CustListAgent') IS NOT NULL
    DROP TABLE #CustListAgent ;  
IF OBJECT_ID('tempdb..#CustListMember') IS NOT NULL
    DROP TABLE #CustListMember ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #CustStakeLevel_Member ;  

CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
CREATE TABLE #CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))

INSERT INTO #CustListAgent(CustID)
SELECT cg.custid  
FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
WHERE SportType = @Sporttype 
AND BetType = @Old_BetType
AND ci.Enabled = 1
AND ci.roleid in (2,3,4) --> Checked this valid
AND ci.custid > @maxcustid
GROUP BY cg.custid
	
INSERT INTO #CustListMember(CustID)
SELECT cg.custid  
FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)	
INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
WHERE SportType = @Sporttype
AND BetType = @Old_BetType
AND ci.Enabled = 1 
AND ci.roleid = 1	--> Checked this valid
AND ci.custid > @maxcustid 
GROUP BY cg.custid


DECLARE @BatchSize INT = 5000     

-----------------------------------CustStakeLevel_Agent---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Agent (CustID)
		FROM #CustListAgent c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cA SET BetType = @New_BetType
		FROM CustStakeLevel_Agent cA WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Agent cust on cA.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Agent
	END

-------------------------------------CustStakeLevel_Member---------------------------------

WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Member (CustID)
		FROM #CustListMember c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cM SET BetType = @New_BetType
		FROM CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Member
	END
END
GO




