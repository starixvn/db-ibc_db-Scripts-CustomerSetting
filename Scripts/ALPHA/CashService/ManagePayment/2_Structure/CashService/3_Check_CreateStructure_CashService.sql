/*<info serverAlias="DBCUST-AgencyCashService,DBTP-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service [223896]  
	DB: DBCUST/AgencyCashService
*/
--*************************Step 1*************************
-- Check table exists or Not
DECLARE @MissingTables TABLE (TableName SYSNAME);

-- Check each table.
IF OBJECT_ID('dbo.CashAgentBankAccount') IS NULL
    INSERT INTO @MissingTables VALUES ('CashAgentBankAccount');
IF OBJECT_ID('dbo.CashAgentBankAccountLimit') IS NULL
    INSERT INTO @MissingTables VALUES ('CashAgentBankAccountLimit');
IF OBJECT_ID('dbo.CashAgentManagement') IS NULL
    INSERT INTO @MissingTables VALUES ('CashAgentManagement');
IF OBJECT_ID('dbo.CashAgentPaymentMethod') IS NULL
    INSERT INTO @MissingTables VALUES ('CashAgentPaymentMethod');
IF OBJECT_ID('dbo.CashAgentProviderConfig') IS NULL
    INSERT INTO @MissingTables VALUES ('CashAgentProviderConfig');
IF OBJECT_ID('dbo.CashBankConfig') IS NULL
    INSERT INTO @MissingTables VALUES ('CashBankConfig');
IF OBJECT_ID('dbo.CashBankList') IS NULL
    INSERT INTO @MissingTables VALUES ('CashBankList');
IF OBJECT_ID('dbo.CashDomainManagement') IS NULL
    INSERT INTO @MissingTables VALUES ('CashDomainManagement');
IF OBJECT_ID('dbo.CashMemberBankAccount') IS NULL
    INSERT INTO @MissingTables VALUES ('CashMemberBankAccount');
IF OBJECT_ID('dbo.CashPaymentMethod') IS NULL
    INSERT INTO @MissingTables VALUES ('CashPaymentMethod');
IF OBJECT_ID('dbo.CashPaymentProvider') IS NULL
    INSERT INTO @MissingTables VALUES ('CashPaymentProvider');
IF OBJECT_ID('dbo.CashPaymentProviderAPIConfig') IS NULL
    INSERT INTO @MissingTables VALUES ('CashPaymentProviderAPIConfig');
IF OBJECT_ID('dbo.CashPaymentProviderInfo') IS NULL
    INSERT INTO @MissingTables VALUES ('CashPaymentProviderInfo');
IF OBJECT_ID('dbo.CashProviderConfig') IS NULL
    INSERT INTO @MissingTables VALUES ('CashProviderConfig');
IF OBJECT_ID('dbo.CashSiteConfig') IS NULL
    INSERT INTO @MissingTables VALUES ('CashSiteConfig');

-- If any tables are missing, display the list.
IF EXISTS (SELECT 1 FROM @MissingTables)
BEGIN
    PRINT 'Missing table(s):';
    SELECT * FROM @MissingTables;
END
ELSE
BEGIN
    -- If all tables exist, display the list of tables.
    SELECT name AS ExistingTable
    FROM sys.tables
    WHERE name IN (
        'CashAgentBankAccount','CashAgentBankAccountLimit','CashAgentManagement',
        'CashAgentPaymentMethod','CashAgentProviderConfig','CashBankConfig',
        'CashBankList','CashDomainManagement','CashMemberBankAccount','CashPaymentMethod',
        'CashPaymentProvider','CashPaymentProviderAPIConfig','CashPaymentProviderInfo',
        'CashProviderConfig','CashSiteConfig'
    )
    ORDER BY name;
END


--*************************Step 2*************************
-- Tables to be checked
DECLARE @TableList TABLE (TableName SYSNAME);
INSERT INTO @TableList (TableName)
VALUES 
('CashAgentBankAccount'),
('CashAgentBankAccountLimit'),
('CashAgentManagement'),
('CashAgentPaymentMethod'),
('CashAgentProviderConfig'),
('CashBankConfig'),
('CashBankList'),
('CashDomainManagement'),
('CashMemberBankAccount'),
('CashPaymentMethod'),
('CashPaymentProvider'),
('CashPaymentProviderAPIConfig'),
('CashPaymentProviderInfo'),
('CashProviderConfig'),
('CashSiteConfig');

-- Checked
SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLength,
    CASE WHEN c.is_nullable = 1 THEN 'NULL' ELSE 'NOT NULL' END AS Nullability,
    pk.name AS PrimaryKeyName,
    i.name AS IndexName,
    dc.name AS ConstraintName
FROM sys.tables t
JOIN @TableList l ON t.name = l.TableName
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.columns c ON c.object_id = t.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
LEFT JOIN sys.index_columns ic ON ic.object_id = t.object_id AND ic.column_id = c.column_id
LEFT JOIN sys.indexes i ON i.object_id = ic.object_id AND i.index_id = ic.index_id
LEFT JOIN sys.key_constraints pk ON pk.parent_object_id = t.object_id AND pk.type = 'PK'
LEFT JOIN sys.default_constraints dc ON c.default_object_id = dc.object_id
ORDER BY t.name, c.column_id;


--*************************Step 3*************************
-- Get table exists Mask Column
SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    c.is_masked
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE c.is_masked = 1
ORDER BY t.name, c.name;


--*************************Step 4*************************
--Check permission of new ACCOUNT : Just exist in DBCust
SELECT 
    dp.name AS AccountName,
    perm.permission_name,
    perm.state_desc,
    s.name AS SchemaName,
    o.name AS TableName
FROM sys.database_permissions perm
JOIN sys.database_principals dp ON perm.grantee_principal_id = dp.principal_id
JOIN sys.objects o ON perm.major_id = o.object_id
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE dp.name IN ('asv_CashService','wsv_CashService')
  AND perm.permission_name IN ('SELECT', 'UPDATE', 'INSERT')
ORDER BY dp.name, perm.permission_name, o.name;
