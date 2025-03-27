/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios@20250327
	Task: Database - Remove un-used tables of credit [Redmine:#221908] 
	DB:	DBCUST-CustDB
*/

-- Script to check deleted accounts that were recreated with the same username by Headline, Super, Master, or Agent

-- Create a temporary table DeletedAccounts to store filtered data from customer_old
IF OBJECT_ID('tempdb..#DeletedAccounts') IS NOT NULL DROP TABLE #DeletedAccounts;
CREATE TABLE #DeletedAccounts (
    DeletedCustID INT,
    DeletedUsername NVARCHAR(50),
    DeletedRoleID INT,
    DeletedDate DATETIME
);
CREATE CLUSTERED INDEX idx_temp_DeletedAccounts ON #DeletedAccounts (DeletedUsername, DeletedDate);

INSERT INTO #DeletedAccounts (DeletedCustID, DeletedUsername, DeletedRoleID, DeletedDate)
SELECT 
    custid AS DeletedCustID,
    username2 AS DeletedUsername,
    RoleID AS DeletedRoleID,
    creatdate AS DeletedDate
FROM DBARCCUST.bodb_Customer.dbo.customer_old WITH (NOLOCK)
WHERE username2 IS NOT NULL

-- Create a temporary table ReusedAccounts to store filtered data from customer
IF OBJECT_ID('tempdb..#ReusedAccounts') IS NOT NULL DROP TABLE #ReusedAccounts;
CREATE TABLE #ReusedAccounts (
    NewCustID INT,
    NewUsername NVARCHAR(50),
    NewCreateDate DATETIME,
    NewRoleID INT,
    CreatedByCustID INT
);
CREATE CLUSTERED INDEX idx_temp_ReusedAccounts ON #ReusedAccounts (NewUsername, NewCreateDate);

INSERT INTO #ReusedAccounts (NewCustID, NewUsername, NewCreateDate, NewRoleID, CreatedByCustID)
SELECT 
    c.custid AS NewCustID,
    c.username2 AS NewUsername,
    c.creatdate AS NewCreateDate,
    c.RoleID AS NewRoleID,
    c.creator AS CreatedByCustID
FROM customer c WITH (NOLOCK)
INNER JOIN #DeletedAccounts d
    ON c.username2 = d.DeletedUsername
   AND c.creatdate > d.DeletedDate;

-- Query the final result
SELECT 
    r.CreatedByCustID AS CreatedByCustID, 
    c.username AS CreatedByUsername,		
    d.DeletedCustID AS DeletedAccountID,
    d.DeletedUsername AS DeletedUsername,
    d.DeletedRoleID AS DeletedRoleID,
    d.DeletedDate AS DeletedDate,
    r.NewCustID AS NewAccountID,
    r.NewUsername AS NewUsername,
    r.NewRoleID AS NewRoleID,
    r.NewCreateDate AS NewCreateDate   
FROM #DeletedAccounts d
INNER JOIN #ReusedAccounts r ON d.DeletedUsername = r.NewUsername
LEFT JOIN customer c WITH (NOLOCK) ON r.CreatedByCustID = c.custid
ORDER BY d.DeletedUsername, r.NewCreateDate;

-- Clean up temporary tables
DROP TABLE #DeletedAccounts;
DROP TABLE #ReusedAccounts;
