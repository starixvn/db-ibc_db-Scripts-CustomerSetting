/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/ 
/*
	Created: Eden@20251001
	Task: Delete config for SABA.GAMES[#239774]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
DECLARE	@errorCode int, @errorMsg varchar(100)
EXEC [dbo].[Dot_Intg_VendorAPI_Delete_test] @vendorid = 42, @siteid = 0, @servername = N'OneWorksApiCoreServer', @errorCode = @errorCode OUTPUT, @errorMsg = @errorMsg OUTPUT
EXEC [dbo].[Dot_Intg_VendorAPI_Delete_test] @vendorid = 42, @siteid = 0, @servername = N'OwcwApiServer', @errorCode = @errorCode OUTPUT, @errorMsg = @errorMsg OUTPUT
