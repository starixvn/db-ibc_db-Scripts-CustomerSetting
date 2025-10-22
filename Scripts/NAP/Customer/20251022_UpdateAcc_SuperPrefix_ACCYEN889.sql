/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*  
	Created: 20251022@Dave  
	Task: Allow create Super with Prefix ET
	DB: DBCUST/CustDB 
 */
USE CustDB;
--Step 1
UPDATE dbo.Acc_SuperPrefix WITH(ROWLOCK, UPDLOCK)
SET AllowNewSuper = 1,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE Prefix = 'ET' 

--Step 2
UPDATE dbo.Acc_SuperPrefix WITH(ROWLOCK, UPDLOCK)
SET AllowNewSuper = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE Prefix = 'ET' 
