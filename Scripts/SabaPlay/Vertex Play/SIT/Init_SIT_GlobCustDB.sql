/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBGLOB-GlobCustDB
*/

USE GlobCustDB

GO
-- Insert Intg_VendorAPI
DECLARE
	@return_value INT
    , @ErrCode	  INT
    , @ErrMsg	  VARCHAR(100)
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid	 = 116
								     , @siteid	 = 0
								     , @servername = N'OneWorksApiCoreServer'
								     , @url		 = N'http://172.16.4.41:7137/api/VertexPlay'
								     , @logincode	 = NULL
								     , @loginpwd	 = '1q2w3e4r'
								     , @DesKey	 = NULL
								     , @MD5Key	 = '1qaz2wsx'
								     , @ErrCode	 = @ErrCode OUTPUT
								     , @ErrMsg	 = @ErrMsg OUTPUT

SELECT
	@ErrCode
    , @ErrMsg



EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid	 = 116
								     , @siteid	 = 0
								     , @servername = N'OwcwApiServer'
								     , @url		 = N'http://172.16.4.41:7136/api/CommonWallet'
								     , @logincode	 = NULL
								     , @loginpwd	 = '1q2w3e4r'
								     , @DesKey	 = NULL
								     , @MD5Key	 = '1qaz2wsx'
								     , @ErrCode	 = @ErrCode OUTPUT
								     , @ErrMsg	 = @ErrMsg OUTPUT

SELECT
	@ErrCode
    , @ErrMsg