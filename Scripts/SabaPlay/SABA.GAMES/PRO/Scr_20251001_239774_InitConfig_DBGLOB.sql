/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on GlobCustDB [#239774]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
--Insert GlobCustDB.dbo.Intg_VendorAPI table
DECLARE @Env VARCHAR(10) = 'UAT' --SIT, UAT, PRO
DECLARE @return_value int, @ErrCode int, @ErrMsg varchar(100)
DECLARE @OwcwURL varchar(300)  -- OwcwApiServer
DECLARE @OwCoreURL varchar(300) --OneWorksApiCoreServer

IF @Env = 'PRO'
BEGIN
	SET @OwcwURL = N'http://saba-plus-group-005.3rd-party.klt2p.gamora.prod:32280/api/CommonWallet'
	SET @OwCoreURL = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub'
END
ELSE IF @Env = 'UAT'
BEGIN
	SET @OwcwURL = N'http://saba-plus-group-005.3rd-party.klt2p.gamora.prod:32280/api/CommonWallet'
	SET @OwCoreURL = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub'
END
IF @Env = 'SIT'
BEGIN
	SET @OwcwURL = N'http://owapi1.playonesit.com:7132/api/CommonWallet'
	SET @OwCoreURL = N'http://owapi1.playonesit.com:7133/api/SabaClub'
END

--Insert
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0
	, @servername = N'OneWorksApiCoreServer'
	, @url = @OwCoreURL
	, @logincode = NULL, @loginpwd = '1q2w3e4r', @DesKey = NULL, @MD5Key = NULL
	, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0
	, @servername = N'OwcwApiServer'
	, @url = @OwcwURL
	, @logincode = NULL, @loginpwd = '1q2w3e4r', @DesKey = NULL, @MD5Key = '1qaz2wsx'
	, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
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
