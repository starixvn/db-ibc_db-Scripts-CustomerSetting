/*<info serverAlias="DBGRP01L-bodb02"></info>*/

/*
    Created: 20250820@Tacy
	Task: [3rd Integration] - Open SP permission to TW team - SIT [Redmine: #235989]
	DB: DBGRP01L-bodb02

	** Please use [oneseal_integration] account to exection.
*/
USE bodb02
GO

-- Athena000UUS01S1904478 : 25016534

-- Current Balance = 52000.0000

---------------------------------------------------------------
-- STEP 1: Deposit Transfer Third Party: amount = 1000
-- Third Party Transfer
declare @o_transid bigint                                        
declare @o_ErrCode int                                        
declare @o_ErrMsg nvarchar(200)                                        
declare @o_RefNo bigint                                        
declare @o_bal_transid bigint                                        
declare @o_transdate datetime                                        
declare @o_balance money                                        
exec dbo.Dot_Int_BettransInsTransactionWithoutLog_Cust                            
		@amount= 1000,                                        
		@custid= 25016534,      -- Athena000UUS01S1904478     
		@bal_custid= 10063450,     -- Athena000WithdrawalUUS       
		@transdesc=N'[IBCustid: 148625643]Deposit, [DepositId: 37849]',                                        
		@transid=@o_transid output,                                        
		@ErrCode=@o_ErrCode output,                                        
		@ErrMsg=@o_ErrMsg output,                                        
		@bettype=22014,                                        
		@IsCharge=0,                                        
		@ip=N'',                                        
		@RefNo=@o_RefNo output,                                        
		@bal_transid=@o_bal_transid output,                                        
		@transdate=@o_transdate output,                                        
		@BetCheck=N'D37849',                                        
		@BonusID=NULL,                                        
		@balance =@o_balance output        ,                                
		@TheirPartyType  =4                                        
                                        
select @o_transid as transid, @o_ErrCode as errorcode                                        
, @o_ErrMsg as errormsg, @o_RefNo as Refno, @o_bal_transid as DummyTransID, @o_transdate as transdate,        @o_balance as AfterBalance                                

---------------------------------------------------------------------------------------------------------------------------------------
--> Excepted Balance = 53000.0000


---------------------------------------------------------------------------------------------------------------------------------------
-- STEP 2: Cancel Transfer amt = 1000

-- Cancel transfer third party
DECLARE @o_ErrCode INT, @o_ErrMsg NVARCHAR(200)
exec Dot_Int_BettransInsCancelTransfer_Cust
		@custid =  25016534,
		@transid =  xxx  ,-- get value from @o_transid (at step 1)
		@transdesc ='',
		@ip= '',
		@NewTransID= 0 ,
		@ErrCode = @o_ErrCode out  ,
		@ErrMsg =   @o_ErrMsg out ,
		@TheirPartyType = 4,
		@betcheck= ''

select @o_ErrCode,@o_ErrMsg
go