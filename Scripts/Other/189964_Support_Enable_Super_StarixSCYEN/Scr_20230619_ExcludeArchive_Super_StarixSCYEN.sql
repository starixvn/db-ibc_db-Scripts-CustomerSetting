/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Eden@20230619
	Task: Exclude archived : StarixSCYEN - 42399710 [Redmine:#189964]
	DB: DBACC-bodb02
*/
USE bodb02
GO
DECLARE @ErrCode INT = 0, @ErrMsg NVARCHAR(4000) = '' 
EXEC [DBA_ArchiveAccount_UpdateException_ByCust] 
	@CustID = 42399710,
	@ErrCode = @ErrCode OUT,
	@ErrMsg = @ErrMsg OUT
SELECT @ErrCode,@ErrMsg