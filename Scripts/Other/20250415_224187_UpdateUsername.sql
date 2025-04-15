/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 15/04/2025
	Task: Update username [Redmine:#224187]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @OldUsername VARCHAR(30),
		@ErrCode INT = 0,
		@ErrMsg NVARCHAR(200) = ''


--Update for STRC9-USDT	226096735
SELECT @OldUsername = username FROM vw_Customer (NOLOCK) WHERE custid = 226096735

EXEC GlobCustDB.dbo.Acc_CustomerEditUserName_Register @oldname = @OldUsername, @newname = 'STRC9-USDT', @custId = 226096735, @roleid = 1, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

EXEC dbo.Acc_CustomerUpdUserName @oldname = @OldUsername, @newname = 'STRC9-USDT', @custId = 226096735, @roleid = 1, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

--Update for STRC10-USDT 226097080
SELECT @OldUsername = username FROM vw_Customer (NOLOCK) WHERE custid = 226097080

EXEC GlobCustDB.dbo.Acc_CustomerEditUserName_Register @oldname = @OldUsername, @newname = 'STRC10-USDT', @custId = 226097080, @roleid = 1, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

EXEC dbo.Acc_CustomerUpdUserName @oldname = @OldUsername, @newname = 'STRC10-USDT', @custId = 226097080, @roleid = 1, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
