/*<info serverAlias="DBAGE-bodb_Age" executers="" viewers=""></info>*/
/*
      Task:         Create Account CashService – Create wsv_CashService account if not exists [#232347]
      DB:           DBAGE-bodb_Age
      Created:      2025-07-22@Helios
*/
SET NOCOUNT ON;

-- Check if the account wsv_CashService exists; create if it does not exist 
IF NOT EXISTS (
    SELECT TOP 1 1 
    FROM sys.database_principals WITH (NOLOCK)
    WHERE name = N'wsv_CashService'
)
BEGIN
    -- Create user for wsv_CashService login (assumes login already exists)
    CREATE USER [wsv_CashService] FOR LOGIN [wsv_CashService];

    -- Grant basic connect permission to allow login to the database
    GRANT CONNECT TO [wsv_CashService];

    -- Grant SELECT permission on all accessible objects (unless otherwise restricted by schema)
    GRANT SELECT TO [wsv_CashService];   
END;
ELSE
BEGIN
    -- Account already exists, output informational message
    PRINT N'Account [wsv_CashService] already exists.';
END;
