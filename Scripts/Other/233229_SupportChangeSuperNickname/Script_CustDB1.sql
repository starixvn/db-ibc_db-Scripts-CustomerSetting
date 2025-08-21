/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20250716@Helios
    Task: Support Change Super Nickname
    DB: DBCUST-CustDB
    
    Revisions:
        - 20250716@Helios: Support Change Super Nickname [RedmineID: #233229]
*/
-- 1. Create temp table to store Username and CustID
IF OBJECT_ID('tempdb..#tmpUser') IS NOT NULL 
    DROP TABLE #tmpUser;

CREATE TABLE #tmpUser (
    Username NVARCHAR(50) PRIMARY KEY,
    CustID INT
);

-- 2. Insert Username data into temp table, get CustID from main table
INSERT INTO #tmpUser (Username, CustID)
SELECT Username, CustID
FROM dbo.Customer WITH (NOLOCK)
WHERE Username IN (
    'J09'
);

-- 3. Check how many rows will be updated: expected 200 customers affected
-- SELECT COUNT(1) AS RowWillBeUpdated FROM #tmpUser

-- 4. Proceed to update using INNER JOIN on CustID (optimal for clustered index)
IF NOT EXISTS (SELECT 1 FROM #tmpUser)
BEGIN
    PRINT 'No rows to update.';
    RETURN;
END
ELSE
BEGIN
    -- Update Customer table
    UPDATE t
    SET t.Username2 = NULL,
        t.RepUpdateTime = [dbo].[f_GetDateTime2]()
    FROM dbo.Customer t WITH (UPDLOCK, ROWLOCK)
    INNER JOIN #tmpUser u ON t.CustID = u.CustID;

    -- Update CustSuper table: set NicknameLoginOnly = 0, RepUpdateTime = SYSDATETIME() for affected CustID
    UPDATE s
    SET s.NicknameLoginOnly = 0,
        s.RepUpdateTime = [dbo].[f_GetDateTime2]()
    FROM dbo.CustSuper s WITH (UPDLOCK, ROWLOCK)
    INNER JOIN #tmpUser u ON s.CustID = u.CustID;
END
