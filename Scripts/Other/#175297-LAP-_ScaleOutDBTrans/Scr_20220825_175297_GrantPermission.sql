/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Eden@20220825
	Task: Grant permission for some sp on DBTXN + SiteDB [Redmine:#175297]	
	DB: DBTXN-bodb02 (SiteDB and CentralDB)
*/
USE bodb02
GO
GRANT EXECUTE ON [dbo].Dot_BalanceInsCredit TO [Dot_Member]
GO
GRANT EXECUTE ON [dbo].Dot_BalanceInsDebit TO [Dot_Member]
GO
GRANT EXECUTE ON [dbo].Task_Cust_CheckBalance_Exception_Ins TO [Dot_Member]
-------------------------------
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditInitialize TO [Dot_Member]
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditInitialize TO [Dot_Evolution] 
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditInitialize TO bodbAdminNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditInitialize TO bodbDownlineNet 
GO
GRANT EXECUTE ON [dbo].Dot_BalanceCreditInitialize TO bodbExtAccNet
GO

GRANT EXECUTE ON [dbo].Dot_BalanceDebitInitialize TO [Dot_Member]
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitInitialize TO [Dot_Evolution] 
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitInitialize TO bodbAdminNet
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitInitialize TO bodbDownlineNet 
GO
GRANT EXECUTE ON [dbo].Dot_BalanceDebitInitialize TO bodbExtAccNet
GO

GRANT EXECUTE ON [dbo].Dot_Int_BettransInsTransactionWithoutLog_Cust TO [Dot_Member]
GO
GRANT EXECUTE ON [dbo].Dot_Int_BettransInsTransactionWithoutLog_Cust TO [Dot_Evolution] 
GO

