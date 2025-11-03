/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB

GO

-- Adjust Intg_VendorAPI
DECLARE
	@return_value INT
    , @ErrCode	  INT
    , @ErrMsg	  VARCHAR(100)


EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Update] @vendorid	 = 116
								     , @siteid	 = 0
								     , @servername = N'OneWorksApiCoreServer'
								     , @url		 = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/VertexPlay'
								     , @ErrCode	 = @ErrCode OUTPUT
								     , @ErrMsg	 = @ErrMsg OUTPUT

SELECT
	@ErrCode
    , @ErrMsg

EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Update] @vendorid	 = 116
								     , @siteid	 = 0
								     , @servername = N'OwcwApiServer'
								     , @url		 = N'http://saba-plus-group-005.3rd-party.klt2p.gamora.prod:32280/api/CommonWallet'
								     , @ErrCode	 = @ErrCode OUTPUT
								     , @ErrMsg	 = @ErrMsg OUTPUT

SELECT
	@ErrCode
    , @ErrMsg