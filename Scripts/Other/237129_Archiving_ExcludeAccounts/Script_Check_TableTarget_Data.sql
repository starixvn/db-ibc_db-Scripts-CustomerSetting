/*<info serverAlias="DBCUST-CustDB" executers="" viewers=""></info>*/
/*
      Task:         Check target table data for specified customers based on role mapping
      DB:           DBCUST-CustDB
      Author:       Helios
      Created:      20250904@Helios
      Description:  This script generates SELECT statements to check data in target tables
                    for specified customers, filtering by RoleID mapping.
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

-- Create script for tables with RoleID = 1 (for Members)
PRINT '-- SELECT statements for Member (RoleID = 1) data from target tables';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN (SELECT CustID FROM #CustomerList WHERE RoleID = 1);' AS QueryForMembers
FROM #TableList
WHERE RoleID = 1
ORDER BY TableTarget;

-- Create script for tables with RoleID = 2 (for Agents and Masters)
PRINT '-- SELECT statements for Agent/Master (RoleID = 2,3) data from target tables';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN (SELECT CustID FROM #CustomerList WHERE RoleID IN (2,3));' AS QueryForAgentsMasters
FROM #TableList
WHERE RoleID = 2
ORDER BY TableTarget;

-- Create script for tables with RoleID = 0 (for all roles)
PRINT '-- SELECT statements for ALL roles data from target tables';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN (SELECT CustID FROM #CustomerList);' AS QueryForAllRoles
FROM #TableList
WHERE RoleID = 0
ORDER BY TableTarget;

-- Now create consolidated script that shows actual CustIDs for each query
PRINT '-- CONSOLIDATED SCRIPT FOR TARGET TABLES --';
PRINT '-- =====================================';

-- Member-specific tables
PRINT '-- Member Tables (RoleID = 1)';
PRINT '-- For CustID: 206734130';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID = 206734130;' 
FROM #TableList
WHERE RoleID = 1
ORDER BY TableTarget;

-- Agent/Master specific tables
PRINT '-- Agent/Master Tables (RoleID = 2)';
PRINT '-- For CustIDs: 206734128, 206734129, 206734126, 206734127';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN (206734128, 206734129, 206734126, 206734127);' 
FROM #TableList
WHERE RoleID = 2
ORDER BY TableTarget;

-- Tables for all roles
PRINT '-- Common Tables for ALL Roles (RoleID = 0)';
PRINT '-- For CustIDs: 206734130, 206734128, 206734129, 206734126, 206734127';
SELECT 'SELECT * FROM dbo.' + TableTarget + ' WITH (NOLOCK) WHERE CustID IN (206734130, 206734128, 206734129, 206734126, 206734127);' 
FROM #TableList
WHERE RoleID = 0
ORDER BY TableTarget;

-- Drop temporary tables
DROP TABLE #CustomerList;
DROP TABLE #TableList;
