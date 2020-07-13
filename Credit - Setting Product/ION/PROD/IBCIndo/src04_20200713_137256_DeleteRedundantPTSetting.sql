/*
	Created: 20200504@Eden
	Task: Delete redundant data of ION - HKK [Redmine: 132323]
	DB: DBCUST/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
USE CustDB
GO

PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @SportType SMALLINT = 225
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT custid
FROM Acc_CustGroup WITH(NOLOCK)
WHERE groupname = 'INDOWIN'
UNION ALL SELECT 43099928 --T-IbcIndoS
UNION ALL SELECT 43765778 --TM

DELETE cg
FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID= c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.AgentID > @maxcustID


DELETE cg
FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID


DELETE cg
FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

DELETE cg
FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType = @SportType
	AND cg.custid > @maxcustID

PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
