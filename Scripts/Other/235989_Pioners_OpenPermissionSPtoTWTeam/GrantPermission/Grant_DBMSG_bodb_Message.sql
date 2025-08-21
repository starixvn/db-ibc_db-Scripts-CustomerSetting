/*<info serverAlias="DBMSG-bodb_Message" executers="" viewers="" isFunction="0" isNested="0"></info>*/
/*
      Task:         [3rd Integration] - Open SP permission to TW team [#235989]
      DB:           DBMSG-bodb_Message
      Created:      20250820@Helios
*/
SET NOCOUNT ON;


-- 1. Check if account 'oneseal_integration' exists
IF NOT EXISTS (
      SELECT 1 FROM sys.database_principals WHERE name = N'oneseal_integration'
)
BEGIN
      PRINT N'Error: Account [oneseal_integration] does not exist in this database.';
      RETURN;
END

-- 2. Check if stored procedure 'Dot_Msg_SetMessage2' exists
IF NOT EXISTS (
      SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Dot_Msg_SetMessage2') AND type IN (N'P', N'PC')
)
BEGIN
      PRINT N'Error: Stored Procedure [dbo.Dot_Msg_SetMessage2] does not exist.';
      RETURN;
END

-- 2. Check if stored procedure 'Dot_Msg_SetUsrMessage' exists
IF NOT EXISTS (
      SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Dot_Msg_SetUsrMessage') AND type IN (N'P', N'PC')
)
BEGIN
      PRINT N'Error: Stored Procedure [dbo.Dot_Msg_SetUsrMessage] does not exist.';
      RETURN;
END

-- 3. Grant EXECUTE permission
GRANT EXECUTE ON dbo.Dot_Msg_SetMessage2 TO [oneseal_integration];
GRANT EXECUTE ON dbo.Dot_Msg_SetUsrMessage TO [oneseal_integration];
