/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: Johnson
	Date: 20211210
	Task: Disable BA for Alog
	DB: DBCust/bodb_Licensee
*/

DECLARE @p3 INT
SET @p3 = 0
DECLARE @p10 NVARCHAR(4000)
SET @p10 = N''

EXEC Acc_BA_LicConfigUpd @EnableBA = 0
	,@OtherComm = 0.0025
	,@ErrCode = @p3 OUTPUT
	,@IP = '10.18.200.125'
	,@1x2Comm = 0.0025
	,@groupc = 0.0025
	,@groupb = 0.0025
	,@groupa = 0.0025
	,@UserID = 10278938 --starixIT	
	,@ErrMsg = @p10 OUTPUT
	,@groupd = 0.0025
	,@LicenseeID = 4

SELECT @p3
	,@p10
	
	