/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250323@Elodie
	Task: Fix Data [Redmine:#221349]
	DB: DBCUST.CustDB
*/
USE CustDB
GO
DECLARE @ErrCode INT = 0, @ErrMsg NVARCHAR(1000) = ''
EXEC EAS_CustomerInsMember_CloneSetting_ExtraPT 
@Custid = 220860312, @ExistingCustid = 219693456, @Creator = 4578191, @IP = '107.150.96.254', 
@ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT



	