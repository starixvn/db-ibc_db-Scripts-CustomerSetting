/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Create Dummy OddAdj test for QC only SIT  RedmineID:#142532
	DB: DBCust/CustDB
*/
USE CustDB
GO


--First Deposit SP
Declare @CustID int
Declare @Username varchar(50)
Declare @ErrCode int
Declare @ErrMsg nvarchar(4000)
---------------------------------
EXEC dbo.Dot_Dep_CustomerInsMember_Ag_Cust_xtest
@FirstName = 'Unique_username',
@LastName = 'Test',
@Email = 'harmony.huynh@starixsoft.com',
@DepositUserName = 'test120201',
@DepositUserID = 10063439, -- 10063439: for Athena, 61771: For Spondemo
@Password = 'E7274D9885A85811D18A5028C47986',
@OddsType = '',
@AgentID = 10063439, -- Spondemo: roleid = 2: 3233923, Athena000: 10063439: roleid=2
@BonusCode = NULL,
@CustID = @CustID OUTPUT,
@Username = @Username OUTPUT,
@ErrCode = @ErrCode OUTPUT,
@ErrMsg = @ErrMsg OUTPUT
---------------------------------
select
@CustID as CustID,
@Username as Username,
@ErrCode as ErrCode,
@ErrMsg as ErrMsg