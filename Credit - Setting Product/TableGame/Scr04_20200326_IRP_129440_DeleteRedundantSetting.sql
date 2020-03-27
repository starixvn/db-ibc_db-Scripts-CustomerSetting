/*
	Created: Elodie
	Task: Delete redundant setting
	DB: DBCUST/CustDB
	Date: 20200321
*/ 
USE CustDB
GO

PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT, @Sporttype SMALLINT = 222
	
SELECT @MaxCustID = xxx
	
DELETE cg
FROM CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID
						
DELETE cg
FROM CustPTSetting3rd_Member cg WITH(ROWLOCK)		
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID
		
DELETE cg
FROM CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
WHERE SportType = @Sporttype
	AND c.custid > @maxcustID
				
DELETE cg
FROM CustBetSetting3rd_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustBetSetting3rd_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustWinLossLimit_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustWinLossLimit_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID	

PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 