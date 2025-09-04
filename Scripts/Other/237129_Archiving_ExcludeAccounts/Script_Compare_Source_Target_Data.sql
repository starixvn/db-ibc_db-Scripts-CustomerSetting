/*<info serverAlias="DBCUST-CustDB" executers="" viewers=""></info>*/
/*
      Task:         Compare source and target table data for specified customers
      DB:           DBCUST-CustDB
      Author:       Helios
      Created:      20250904@Helios
      Description:  This script generates SELECT statements to compare data between
                    source (_old) tables and target tables for validation purposes.
*/

SET NOCOUNT ON;

-- Create customer list with specific CustIDs
IF OBJECT_ID('tempdb..#CustomerList') IS NOT NULL DROP TABLE #CustomerList;
CREATE TABLE #CustomerList (
    CustID INT NOT NULL,
    RoleID INT NOT NULL
);

-- Insert the provided customer list
INSERT INTO #CustomerList (CustID, RoleID) VALUES
    (206734130, 1),  -- Member
    (206734128, 2),  -- Agent
    (206734129, 2),  -- Agent
    (206734126, 3),  -- Master
    (206734127, 3);  -- Master

-- Create table list with mappings
IF OBJECT_ID('tempdb..#TableList') IS NOT NULL DROP TABLE #TableList;
CREATE TABLE #TableList (
    TableSource NVARCHAR(100),
    TableTarget NVARCHAR(100),
    RoleID      INT DEFAULT 0   -- 0 : ALL , 1 : Member , 2 : SMA
);

-- Insert table mappings (from the function)
INSERT INTO #TableList VALUES
    ('BetSetting_Agent_old',           'BetSetting_Agent', 2),
    ('BetSetting3rd_Agent_old',        'BetSetting3rd_Agent' , 2),
    ('CustDiscount3rd_Agent_old',      'CustDiscount3rd_Agent' , 2),
    ('CustMaxPayoutSetting_Agent_old', 'CustMaxPayoutSetting_Agent' , 2),
    ('CustPTSetting3rd_Agent_old',     'CustPTSetting3rd_Agent' , 2),
    ('CustStakeLevel_Agent_old',       'CustStakeLevel_Agent' , 2),
    ('CustWinLossLimit_Agent_old',     'CustWinLossLimit_Agent' , 2),
    ('CustSettingMode3rd_old',         'CustSettingMode3rd' , 1),
    ('BetSetting_Member_old',          'BetSetting_Member' , 1),
    ('BetSetting3rd_Member_old',       'BetSetting3rd_Member' , 1),
    ('CustDiscount3rd_Member_old',     'CustDiscount3rd_Member' , 1),
    ('CustPTSetting3rd_Member_old',    'CustPTSetting3rd_Member' , 1),
    ('CustMaxPayoutSetting_Member_old','CustMaxPayoutSetting_Member' , 1),
    ('CustStakeLevel_Member_old',      'CustStakeLevel_Member', 1),
    ('CustWinLossLimit_Member_old',    'CustWinLossLimit_Member' , 1),
    ('CustVirtualSetting_Old',         'CustVirtualSetting' , 0 ),
    
    ('custinfo_old',                   'custinfo' , 0),
    ('CustProductStatus_old',          'CustProductStatus' , 0),
    ('CustLoginInfo_old',              'CustLoginInfo' , 2),
    ('CustLoginInfo_Member_old',       'CustLoginInfo_Member' , 1);

-- Generate comparison scripts for member tables
PRINT '-- COMPARISON SCRIPTS FOR MEMBER TABLES (RoleID = 1)';
PRINT '-- For CustID: 206734130';
PRINT '';

SELECT 
    'SELECT s.*, t.* FROM DBAGE.bodb_Customer.dbo.' + TableSource + ' s WITH (NOLOCK) ' +
    'FULL OUTER JOIN dbo.' + TableTarget + ' t WITH (NOLOCK) ON s.CustID = t.CustID ' +
    'WHERE s.CustID = 206734130 OR t.CustID = 206734130;' AS ComparisonQuery
FROM #TableList
WHERE RoleID = 1
ORDER BY TableSource;

-- Generate comparison scripts for agent/master tables
PRINT '';
PRINT '-- COMPARISON SCRIPTS FOR AGENT/MASTER TABLES (RoleID = 2)';
PRINT '-- For CustIDs: 206734128, 206734129, 206734126, 206734127';
PRINT '';

SELECT 
    'SELECT s.*, t.* FROM DBAGE.bodb_Customer.dbo.' + TableSource + ' s WITH (NOLOCK) ' +
    'FULL OUTER JOIN dbo.' + TableTarget + ' t WITH (NOLOCK) ON s.CustID = t.CustID ' +
    'WHERE s.CustID IN (206734128, 206734129, 206734126, 206734127) OR t.CustID IN (206734128, 206734129, 206734126, 206734127);' AS ComparisonQuery
FROM #TableList
WHERE RoleID = 2
ORDER BY TableSource;

-- Generate comparison scripts for all roles tables
PRINT '';
PRINT '-- COMPARISON SCRIPTS FOR ALL ROLES TABLES (RoleID = 0)';
PRINT '-- For CustIDs: 206734130, 206734128, 206734129, 206734126, 206734127';
PRINT '';

SELECT 
    'SELECT s.*, t.* FROM DBAGE.bodb_Customer.dbo.' + TableSource + ' s WITH (NOLOCK) ' +
    'FULL OUTER JOIN dbo.' + TableTarget + ' t WITH (NOLOCK) ON s.CustID = t.CustID ' +
    'WHERE s.CustID IN (206734130, 206734128, 206734129, 206734126, 206734127) OR ' +
    't.CustID IN (206734130, 206734128, 206734129, 206734126, 206734127);' AS ComparisonQuery
FROM #TableList
WHERE RoleID = 0
ORDER BY TableSource;

-- Generate validation counts to check data integrity
PRINT '';
PRINT '-- DATA INTEGRITY VALIDATION COUNTS';
PRINT '-- Shows row counts in source vs target tables for each customer';
PRINT '';

SELECT 
    'SELECT ''' + TableSource + ''' AS TableName, ' +
    '(SELECT COUNT(*) FROM DBAGE.bodb_Customer.dbo.' + TableSource + ' WITH (NOLOCK) WHERE CustID IN ' +
    '(SELECT CustID FROM #CustomerList WHERE RoleID IN (CASE WHEN ' + CAST(RoleID AS VARCHAR) + ' = 1 THEN (1) ' +
    'WHEN ' + CAST(RoleID AS VARCHAR) + ' = 2 THEN (2,3) ELSE (1,2,3) END))) AS SourceCount, ' +
    '(SELECT COUNT(*) FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN ' +
    '(SELECT CustID FROM #CustomerList WHERE RoleID IN (CASE WHEN ' + CAST(RoleID AS VARCHAR) + ' = 1 THEN (1) ' +
    'WHEN ' + CAST(RoleID AS VARCHAR) + ' = 2 THEN (2,3) ELSE (1,2,3) END))) AS TargetCount;' AS CountValidation
FROM #TableList
ORDER BY TableSource;

-- Drop temporary tables
DROP TABLE #CustomerList;
DROP TABLE #TableList;
