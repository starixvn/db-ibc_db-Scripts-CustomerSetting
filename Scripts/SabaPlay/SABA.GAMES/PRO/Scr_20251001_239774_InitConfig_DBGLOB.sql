/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on GlobCustDB [#239774]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
--Insert GlobCustDB.dbo.Intg_VendorAPI table
DECLARE @return_value int, @ErrCode int, @ErrMsg varchar(100)
--Insert
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0, @servername = N'OneWorksApiCoreServer', @url = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub', @logincode = NULL, @loginpwd = '1q2w3e4r', @DesKey = NULL, @MD5Key = NULL, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0, @servername = N'OwcwApiServer', @url = N'http://saba-plus-group-005.3rd-party.klt2p.gamora.prod:32280/api/CommonWallet', @logincode = NULL, @loginpwd = '1q2w3e4r', @DesKey = NULL, @MD5Key = '1qaz2wsx', @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
GO
/*
SELECT 1 
FROM GlobCustDB.dbo.Intg_VendorAPI WITH (NOLOCK) 
WHERE vendorid = 42 AND SiteID = 0
	AND Servername IN(
		'OneWorksApiCoreServer'
		,'OwcwApiServer'
	)
*/
