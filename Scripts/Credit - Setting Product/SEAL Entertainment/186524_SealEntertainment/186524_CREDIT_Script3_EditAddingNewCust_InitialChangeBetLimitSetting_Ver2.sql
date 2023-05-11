/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/04/13
	Task: Seal Entertainment - Project Team [RM:#186524]
	DB: DBCUST/CUSTDB

	Revisions:
		- Initial Script Update BetType Seal [RM:#186524]
*/

DECLARE @maxcustid INT = xxx
		
BEGIN

	SET NOCOUNT ON  
	
---------------------------------COLLECT DATA---------------------------------
DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 8900
	,  @New_BetType = 8999
	,  @SportType = 156

IF OBJECT_ID('tempdb..#CustListAgent') IS NOT NULL
    DROP TABLE #CustListAgent ;  
IF OBJECT_ID('tempdb..#CustListMember') IS NOT NULL
    DROP TABLE #CustListMember ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #CustStakeLevel_Member ;  

CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY(CustID))
CREATE TABLE #CustListMember (CustID INT  PRIMARY KEY(CustID))
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
		, @agent_cnt INT
		, @member_cnt INT
		, @msg_total_sma NVARCHAR(200) = 'Total of SMA: %d.' 
		, @msg_total_mem NVARCHAR(200) = 'Total of Member: %d.' 

SET @agent_cnt = (SELECT COUNT(*) FROM #CustListAgent)

RAISERROR (@msg_total_sma , 0 ,1 , @agent_cnt) WITH NOWAIT

-----------------------------------CustStakeLevel_Agent---------------------------------

WHILE (1=1)
	BEGIN

		TRUNCATE TABLE #CustStakeLevel_Agent

		DELETE TOP (@BatchSize) c WITH (ROWLOCK)
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Agent (CustID)
		FROM #CustListAgent c

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cA SET BetType = @New_BetType
		FROM CustStakeLevel_Agent cA WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Agent cust on cA.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 
	END

-------------------------------------CustStakeLevel_Member---------------------------------


SET @member_cnt = (SELECT COUNT(*) FROM #CustListMember)

RAISERROR (@msg_total_mem , 0 ,1 , @member_cnt) WITH NOWAIT

WHILE (1=1)
	BEGIN

		TRUNCATE TABLE #CustStakeLevel_Member

		DELETE TOP (@BatchSize) c WITH (ROWLOCK)
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Member (CustID)
		FROM #CustListMember c

		IF @@ROWCOUNT = 0
			BREAK;

		UPDATE cM SET BetType = @New_BetType
		FROM CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 
	END
END
GO




