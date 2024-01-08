/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231214@Winfred
	DB: DBCUST/CustDB
	Task: [NAP CM] Customer Class - Auto include new items for rows that is selected option "All"
	Revisions:
		- 20231214@Winfred: [NAP CM] Customer Class - Auto include new items for rows that is selected option "All" [RedmineID: #186699] 
*/
-- Remove Data policy old
--===================================================================================
USE CustDB
GO
-- 10278938 : starixIT
DECLARE @p5 INT
SET @p5=0
DECLARE @p6 NVARCHAR(MAX)
SET @p6=''
EXEC NAP_LM_CustomerClassPolicyDel_xpre @UserID=10278938,@IP='10.18.200.204',@IsTest=0,@Policies='10,15,16,13',@ErrCode=@p5 output,@ErrMsg=@p6 output
SELECT @p5, @p6

