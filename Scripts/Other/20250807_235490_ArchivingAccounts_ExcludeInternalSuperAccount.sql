/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20250807@Helios
	Task: Archiving credit accounts - Exclude internal super account SS-USTM - [Redmine: #235490]   
	DB: DBACC-bodb02

*/


SELECT c.custid AS CustID_Input , c.roleid
FROM Customer c WITH (NOLOCK) 
WHERE c.username  = 'SS-USTM' -- OR c.username2  = 'SS-USTM'


DECLARE
	@ErrCode		INT				= 0
    , @ErrMsg		NVARCHAR(4000)		= ''
    , @CustID_Input	INT				= xxx

EXEC [DBA_ArchiveAccount_UpdateException_ByCust] @CustID  = @CustID_Input 
							     , @ErrCode = @ErrCode OUT
							     , @ErrMsg  = @ErrMsg OUT
SELECT
	@ErrCode
    , @ErrMsg