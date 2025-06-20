/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20250611@Tacy
	Task:  Cust_TrackingLastBetDate - Initial for Exchange Ticket [#RedmineID:#230025]
	DB: DBACC-bodb02
*/
USE bodb02
GO

DECLARE @BatchSize INT = 3000

-- Temp tables
CREATE TABLE #BettingMember (
    custid INT PRIMARY KEY,
    LastBetDate DATETIME
)

CREATE TABLE #tmpProcess (
    custid INT PRIMARY KEY,
    LastBetDate DATETIME,
    IsProcessed BIT DEFAULT 0
)

-- Get all customers who have tickets in Bettrans_Exchange within 1 year
INSERT INTO #BettingMember(custid, LastBetDate)
SELECT custid, DATEADD(HOUR, -12, transdate)			-- 15,317
FROM OPENQUERY (DBLIC, 'SELECT b.custid AS custid
								, MAX(b.betPlaced) AS transdate
						FROM bodb_3rdProduct.dbo.Bettrans_Exchange b with (NOLOCK) 
						WHERE betPlaced > ''2024-06-30''			-- add column CustID (Betttrans_Exchange)
						AND betPlaced < CONVERT(DATE,DATEADD(HOUR, 12, GETDATE()))		-- yesterday
						AND custid IS NOT NULL
						GROUP BY b.custid
					') AS ex

-- Remove invalid customers
DELETE b
FROM #BettingMember b
LEFT JOIN bodb02..Customer c WITH(NOLOCK) ON b.custid = c.custid
WHERE c.custid IS NULL

INSERT INTO #BettingMember(custid,LastBetDate)
SELECT custid, DATEADD(HOUR, -12, transdate)		-- 3,984
FROM OPENQUERY (DBLIC, 'SELECT CONVERT(INT,REPLACE(REPLACE(REPLACE(userId, ''poc'', ''''), ''sit'', ''''), ''uat'', '''')) AS custid
							, MAX(b.betPlaced) AS transdate
						FROM bodb_3rdProduct.dbo.Bettrans_Exchange b with (NOLOCK)
						WHERE betPlaced >= CONVERT(DATE,DATEADD(HOUR, 12, GETDATE()) - 365)
						AND betPlaced <=  ''2024-06-30''
						GROUP BY CONVERT(INT,REPLACE(REPLACE(REPLACE(userId, ''poc'', ''''), ''sit'', ''''), ''uat'', ''''))
					') AS ex
WHERE ex.custid NOT IN (SELECT custid FROM #BettingMember)

-- Remove invalid customers
DELETE b
FROM #BettingMember b
LEFT JOIN bodb02..Customer c WITH(NOLOCK) ON b.custid = c.custid
WHERE c.custid IS NULL

------------------------------------------------------------------------------
------------------------------------------------------------------------------

DECLARE @cnt INT, @index INT = 0

SET @cnt = (SELECT COUNT(*) FROM #BettingMember)

DECLARE @msg_total nvarchar(200) = 'Total of customers: %d.'

RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Process existing customers in Cust_TrackingLastBetDate
INSERT INTO #tmpProcess(custid, LastBetDate)
SELECT b.custid, b.LastBetDate
FROM #BettingMember b
INNER JOIN Cust_TrackingLastBetDate t WITH(NOLOCK) 
    ON b.custid = t.CustID

WHILE EXISTS(SELECT 1 FROM #tmpProcess WHERE IsProcessed = 0)
BEGIN
    UPDATE TOP(@BatchSize) t
    SET IsProcessed = 1
    FROM #tmpProcess t
    WHERE IsProcessed = 0

    -- Update existing records if new LastBetDate is greater
    UPDATE c
    SET c.LastBetDate = t.LastBetDate 
    FROM Cust_TrackingLastBetDate c WITH(ROWLOCK, UPDLOCK)
    INNER JOIN #tmpProcess t ON c.CustID = t.custid
    WHERE t.IsProcessed = 1
        AND t.LastBetDate > c.LastBetDate
	
	DELETE FROM #tmpProcess WHERE IsProcessed=1

	WAITFOR DELAY '00:00:0.1'
END

-- Process new customers not in Cust_TrackingLastBetDate
TRUNCATE TABLE #tmpProcess

INSERT INTO #tmpProcess(custid, LastBetDate)
SELECT b.custid, b.LastBetDate
FROM #BettingMember b
LEFT JOIN Cust_TrackingLastBetDate t WITH(NOLOCK) 
    ON b.custid = t.CustID
WHERE t.CustID IS NULL

WHILE EXISTS(SELECT 1 FROM #tmpProcess WHERE IsProcessed = 0)
BEGIN
    UPDATE TOP(@BatchSize) t
    SET IsProcessed = 1
    FROM #tmpProcess t
    WHERE IsProcessed = 0

    -- Insert new records
    INSERT INTO Cust_TrackingLastBetDate(CustID, LastBetDate)
    SELECT t.custid, t.LastBetDate
    FROM #tmpProcess t
    WHERE t.IsProcessed = 1
        AND NOT EXISTS (
            SELECT 1 
            FROM Cust_TrackingLastBetDate c WITH(NOLOCK)
            WHERE c.CustID = t.custid
        )

	DELETE FROM #tmpProcess WHERE IsProcessed=1

	WAITFOR DELAY '00:00:0.1'
END

-- Cleanup
DROP TABLE #BettingMember
DROP TABLE #tmpProcess
GO